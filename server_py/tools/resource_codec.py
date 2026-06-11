#!/usr/bin/env python3
"""Decode and encode Crystal Saga configuration resources.

The Flash client compresses configuration text with zlib and applies Hurlant
DES to the first 8-byte block only. The remaining compressed bytes are stored
unchanged.
"""

import argparse
import json
import shutil
import zlib
from pathlib import Path

from Crypto.Cipher import DES


DEFAULT_KEY = bytes.fromhex("6bc89fe7d5a0f35f")


def crypt_first_block(data: bytes, key: bytes, decrypt: bool) -> bytes:
    if len(data) < 8:
        raise ValueError("Encoded resource must contain at least 8 bytes")
    cipher = DES.new(key, DES.MODE_ECB)
    first = cipher.decrypt(data[:8]) if decrypt else cipher.encrypt(data[:8])
    return first + data[8:]


def decode_bytes(data: bytes, key: bytes = DEFAULT_KEY) -> bytes:
    return zlib.decompress(crypt_first_block(data, key, decrypt=True))


def encode_bytes(data: bytes, key: bytes = DEFAULT_KEY, level: int = 9) -> bytes:
    compressed = zlib.compress(data, level)
    return crypt_first_block(compressed, key, decrypt=False)


def decode_file(source: Path, destination: Path, key: bytes = DEFAULT_KEY):
    destination.parent.mkdir(parents=True, exist_ok=True)
    destination.write_bytes(decode_bytes(source.read_bytes(), key))


def encode_file(source: Path, destination: Path, key: bytes = DEFAULT_KEY):
    destination.parent.mkdir(parents=True, exist_ok=True)
    destination.write_bytes(encode_bytes(source.read_bytes(), key))


def extension_for(resource: dict) -> str:
    resource_type = str(resource.get("type", "bin")).lower()
    return {"txt": ".json", "text": ".json", "xml": ".xml"}.get(
        resource_type, f".{resource_type}"
    )


def decode_manifest(manifest_path: Path, resources_dir: Path, output_dir: Path,
                    key: bytes = DEFAULT_KEY):
    manifest = json.loads(manifest_path.read_text(encoding="utf-8"))
    index = {}
    decoded = skipped = failed = 0

    for resource in manifest.get("resources", []):
        resource_id = resource.get("id")
        resource_url = resource.get("url")
        if not resource_id or not resource_url:
            skipped += 1
            continue

        source = resources_dir / resource_url
        if not source.is_file():
            skipped += 1
            continue

        destination = output_dir / f"{resource_id}{extension_for(resource)}"
        try:
            if resource.get("isEncoded", False):
                decode_file(source, destination, key)
                mode = "decoded"
            else:
                destination.parent.mkdir(parents=True, exist_ok=True)
                shutil.copyfile(source, destination)
                mode = "copied"
            decoded += 1
            index[resource_id] = {
                "source": resource_url,
                "output": destination.name,
                "type": resource.get("type"),
                "mode": mode,
            }
        except Exception as error:
            failed += 1
            index[resource_id] = {
                "source": resource_url,
                "error": str(error),
            }

    output_dir.mkdir(parents=True, exist_ok=True)
    (output_dir / "_index.json").write_text(
        json.dumps(index, ensure_ascii=False, indent=2), encoding="utf-8"
    )
    return decoded, skipped, failed


def parse_key(value: str) -> bytes:
    key = bytes.fromhex(value)
    if len(key) != 8:
        raise argparse.ArgumentTypeError("DES key must contain exactly 8 bytes")
    return key


def build_parser():
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--key", type=parse_key, default=DEFAULT_KEY)
    commands = parser.add_subparsers(dest="command", required=True)

    for name in ("decode", "encode"):
        command = commands.add_parser(name)
        command.add_argument("source", type=Path)
        command.add_argument("destination", type=Path)

    all_command = commands.add_parser("decode-all")
    all_command.add_argument("manifest", type=Path)
    all_command.add_argument("resources", type=Path)
    all_command.add_argument("output", type=Path)
    return parser


def main():
    args = build_parser().parse_args()
    if args.command == "decode":
        decode_file(args.source, args.destination, args.key)
    elif args.command == "encode":
        encode_file(args.source, args.destination, args.key)
    else:
        decoded, skipped, failed = decode_manifest(
            args.manifest, args.resources, args.output, args.key
        )
        print(f"Decoded/copied: {decoded}; skipped: {skipped}; failed: {failed}")


if __name__ == "__main__":
    main()
