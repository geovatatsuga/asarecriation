# Crystal Saga Resource Codec

The client stores encoded configuration resources as:

1. UTF-8 text compressed with zlib.
2. Only the first 8-byte block encrypted with DES ECB.
3. DES key: `6bc89fe7d5a0f35f`.

Decode one resource:

```powershell
python tools/resource_codec.py decode game_resources/res/95f0b5b80be9c50eeb6d0adf7eb700ee game_resources/decoded/itl.json
```

Decode every resource described by the manifest:

```powershell
python tools/resource_codec.py decode-all game_resources/decoded_resource_manifest.json game_resources/res game_resources/decoded
```

Encode an edited resource:

```powershell
python tools/resource_codec.py encode game_resources/decoded/itl.json game_resources/res/95f0b5b80be9c50eeb6d0adf7eb700ee.new
```

Always write encoded changes to a new file first. Keep original resources
untouched until the round-trip and client behavior have been verified.
