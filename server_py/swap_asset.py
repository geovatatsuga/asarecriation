#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
swap_asset.py – utilitário único para trocar assets visuais no servidor Asa de Cristal.
Suporta:
  • bitmap interno (ID numérico) – atualiza manifesto e opcionalmente patcha o SWF
  • asset externo em assets.swf (símbolo) – substitui o símbolo diretamente
Uso exemplos:
  python swap_asset.py --image nova.png --id 35
  python swap_asset.py --image loading.png --symbol 40
"""

import argparse, hashlib, json, os, shutil, subprocess, sys
from pathlib import Path

# ------------------- CONFIGURAÇÕES DO PROJETO -------------------
BASE_DIR      = Path(__file__).resolve().parent          # server_py/
REF_SWF       = BASE_DIR.parent / "_referencias" / "_game_outer.swf"
MANIFEST      = BASE_DIR / "game_resources" / "decoded_resource_manifest.json"
RES_DIR       = BASE_DIR / "game_resources" / "res"
ASSETS_DIR    = BASE_DIR.parent / "_assets"               # onde o servidor espera assets.swf
FFDEC_CMD     = shutil.which("ffdec") or "ffdec"          # ajuste se precisar de caminho absoluto
# ----------------------------------------------------------------

def md5_file(path: Path) -> str:
    h = hashlib.md5()
    with path.open("rb") as f:
        for chunk in iter(lambda: f.read(8192), b""):
            h.update(chunk)
    return h.hexdigest()

def load_manifest():
    if not MANIFEST.is_file():
        print(f"[ERRO] Manifesto não encontrado: {MANIFEST}")
        sys.exit(1)
    with MANIFEST.open("r", encoding="utf-8") as f:
        return json.load(f)

def save_manifest(data):
    MANIFEST.write_text(json.dumps(data, indent=2, ensure_ascii=False), encoding="utf-8")

# ---------- BITMAP INTERNO ----------
def handle_internal(img_path: Path, bitmap_id: int):
    hash_val = md5_file(img_path)
    print(f"[INFO] Hash da imagem: {hash_val}")

    manifest = load_manifest()
    # procura por entrada existente com mesmo id (pelo campo "id")
    entry = None
    for item in manifest:
        if isinstance(item, dict) and item.get("id") == str(bitmap_id):
            entry = item
            break
    if entry is None:
        # cria nova entrada – você pode definir um nome descritivo se quiser
        entry = {"id": str(bitmap_id), "url": hash_val}
        manifest.append(entry)
        print(f"[INFO] Criada nova entrada para ID {bitmap_id}")
    else:
        if entry.get("url") == hash_val:
            print("[INFO] Hash já está no manifesto – nada a fazer.")
        else:
            print(f"[INFO] Atualizando URL da ID {bitmap_id} de {entry.get('url')} para {hash_val}")
            entry["url"] = hash_val

    save_manifest(manifest)

    # copia a imagem para res/
    dest = RES_DIR / f"{hash_val}{img_path.suffix.lower()}"
    if not dest.is_file():
        shutil.copy2(img_path, dest)
        print(f"[INFO] Imagem copiada para {dest}")
    else:
        print(f"[INFO] Imagem já presente em {dest}")

    # opcional: garante que o bitmap exista no SWF (usa ffdec apenas se necessário)
    swf_patch_internal(REF_SWF, bitmap_id, img_path)

    # substitui o SWF servido (mantém backup)
    backup = REF_SWF.with_suffix(".swf.bak")
    if not backup.is_file():
        shutil.copy2(REF_SWF, backup)
        print(f"[INFO] Backup criado em {backup}")
    shutil.copy2(REF_SWF, REF_SWF)  # garante que o timestamp seja atualizado (no‑op, apenas para indicar mudança)
    # na prática, o SWF já foi modificado pela função acima; aqui só garantimos que o servidor veja a mudança
    print(f"[INFO] SWF principal atualizado: {REF_SWF}")

# ---------- BITMAP INTERNO – patch SWF ----------
def swf_patch_internal(swf_path: Path, bitmap_id: int, img_path: Path):
    """
    Tenta garantir que o SWf contenha um DefineBitsLossless2 com o ID indicado.
    Se o bitmap já existir, ffdec não faz nada; se não existir, ele o adiciona.
    """
    # ffdec tem modo de exportar/importar tags: podemos usar -replacebitmap
    # Sintaxe: ffdec -replacebitmap <id> <imagem> <swf_entrada> <swf_saida>
    tmp_swf = swf_path.with_name(swf_path.stem + "_tmp.swf")
    cmd = [
        FFDEC_CMD,
        "-replacebitmap",
        str(bitmap_id),
        str(img_path),
        str(swf_path),
        str(tmp_swf)
    ]
    print(f"[INFO] Tentando patchar bitmap ID {bitmap_id} no SWF via ffdec …")
    result = subprocess.run(cmd, capture_output=True, text=True)
    if result.returncode != 0:
        print(f"[WARN] ffdec retornou {result.returncode}. Saída:\n{result.stderr}")
        # tenta apenas ler o SWF para ver se o ID já existe (não crítico)
        return
    # substitui o original
    shutil.move(tmp_swf, swf_path)
    print(f"[OK] Bitmap ID {bitmap_id} inserido/atualizado no SWF.")

# ---------- ASSETS EXTERNOS (assets.swf) ----------
def handle_external(img_path: Path, symbol: int):
    # 1. localiza ou extrai assets.swf
    assets_swf = ASSETS_DIR / "assets.swf"
    if not assets_swf.is_file():
        # tenta extrair do _game_outer.swf (às vezes está embutido)
        print(f"[INFO] assets.swf não encontrado em {ASSETS_DIR}. Tentando extrair do SWF principal …")
        extract_cmd = [FFDEC_CMD, "-export", str(assets_swf), str(REF_SWF)]
        subprocess.run(extract_cmd, stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL)
        if not assets_swf.is_file():
            print(f"[ERRO] Não foi possível localizar/extrair assets.swf. Certifique‑se de que ele exista.")
            sys.exit(1)

    hash_val = md5_file(img_path)
    print(f"[INFO] Hash da imagem: {hash_val}")

    # 2. usa ffdec para substituir o símbolo
    tmp_swf = assets_swf.with_name(assets_swf.stem + "_tmp.swf")
    cmd = [
        FFDEC_CMD,
        "-replacesymbol",
        str(symbol),
        str(img_path),
        str(assets_swf),
        str(tmp_swf)
    ]
    print(f"[INFO] Substituindo símbolo {symbol} em assets.swf …")
    result = subprocess.run(cmd, capture_output=True, text=True)
    if result.returncode != 0:
        print(f"[ERRO] ffdec falhou: {result.stderr}")
        sys.exit(1)
    shutil.move(tmp_swf, assets_swf)
    print(f"[OK] Símbolo {symbol} atualizado em assets.swf")

    # 3. copia o assets.swf para a pasta que o servidor serve (se não for já a mesma)
    if not assets_swf.samefile(ASSETS_DIR / "assets.swf"):
        shutil.copy2(assets_swf, ASSETS_DIR / "assets.swf")
        print(f"[INFO] assets.swf copiado para {ASSETS_DIR}")

    # 4. (opcional) atualiza o manifesto apenas se quiser que o ID também exista lá
    #    Não é obrigatório para assets.swf, mas deixamos como comentário:
    # manifest = load_manifest()
    # ... (similar ao caso interno) ...

    print(f"[OK] Asset externo pronto. Reinicie o servidor e faça hard‑refresh (Ctrl+Shift+R).")

# ------------------- MAIN -------------------
def main():
    p = argparse.ArgumentParser(description="Troca assets visuais (bitmap interno ou assets.swf) de forma simplificada.")
    group = p.add_mutually_exclusive_group(required=True)
    group.add_argument("--id", type=int, help="ID numérico do bitmap no _game_outer.swf (ex.: 35)")
    group.add_argument("--symbol", type=int, help="Número do símbolo dentro de assets.swf (ex.: 86 para login)")
    p.add_argument("--image", required=True, type=Path, help="Caminho para a nova imagem (PNG/JPG).")
    p.add_argument("--no-restart", action="store_true", help="Não tentar reiniciar o servidor HTTP após a troca.")
    args = p.parse_args()

    if not args.image.is_file():
        print(f"[ERRO] Imagem não encontrada: {args.image}")
        sys.exit(1)

    if args.id is not None:
        handle_internal(args.image, args.id)
    else:
        handle_external(args.image, args.symbol)

    if not args.no_restart:
        # tenta reiniciar o servidor HTTP (ajuste o nome do processo se necessário)
        print("[INFO] Reiniciando servidor HTTP …")
        subprocess.run("pkill -f \"servers.http_server\"", shell=True)
        subprocess.Popen("python -m servers.http_server", shell=True, cwd=BASE_DIR)
        print("[INFO] Servidor reiniciado. Abra o jogo e pressione Ctrl+Shift+R para limpar o cache.")

if __name__ == "__main__":
    main()