import os
import re
import sys
import shutil

def is_ascii(s):
    return all(ord(c) < 128 for c in s)

def deobfuscate_directory(target_dir):
    print(f"Iniciando desofuscação na pasta: {target_dir}")
    if not os.path.exists(target_dir):
        print("Erro: Pasta de destino não existe!")
        return

    # Regex para capturar identificadores ofuscados contendo caracteres não-ASCII ou o caractere §
    # Ex: §_-SQ§, §_-Ep§, etc.
    obfuscated_pattern = re.compile(r'\b[a-zA-Z0-9_]*[^\x00-\x7F§]+[a-zA-Z0-9_]*\b|\b[a-zA-Z0-9_]*§[a-zA-Z0-9_-]*§[a-zA-Z0-9_]*\b')

    # Passo 1: Coletar todos os identificadores ofuscados em nomes de arquivos, diretórios e conteúdo
    obfuscated_words = set()
    
    # Adicionar também padrões específicos vistos no client decompilado
    # como §_-SQ§, §_-Ep§
    specific_pattern = re.compile(r'§[a-zA-Z0-9_-]+§')

    as_files = []
    for root, dirs, files in os.walk(target_dir):
        for name in dirs + files:
            # Capturar nomes de pastas e arquivos ofuscados
            for match in obfuscated_pattern.findall(name):
                obfuscated_words.add(match)
            for match in specific_pattern.findall(name):
                obfuscated_words.add(match)
                
        for file in files:
            if file.endswith('.as'):
                as_files.append(os.path.join(root, file))

    print(f"Lendo conteúdo de {len(as_files)} arquivos para mapear símbolos ofuscados...")
    
    # Ler conteúdo para encontrar mais símbolos ofuscados
    for idx, filepath in enumerate(as_files):
        try:
            with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
                content = f.read()
                for match in obfuscated_pattern.findall(content):
                    obfuscated_words.add(match)
                for match in specific_pattern.findall(content):
                    obfuscated_words.add(match)
        except Exception as e:
            pass

    # Criar um mapeamento limpo
    mapping = {}
    counter = 1
    for word in sorted(list(obfuscated_words), key=len, reverse=True):
        if not word.strip() or is_ascii(word) and '§' not in word:
            continue
        # Criar um nome limpo e amigável
        clean_name = f"obf_{counter}"
        # Se contiver pistas de nome original ou for curto
        clean_name = f"obf_{word.replace('§', '').replace('-', '_').replace('', '_').strip('_')}_{counter}"
        # Limpar caracteres não-ascii do clean_name final
        clean_name = re.sub(r'[^a-zA-Z0-9_]', '', clean_name)
        if not clean_name:
            clean_name = f"obf_symbol_{counter}"
        
        mapping[word] = clean_name
        counter += 1

    print(f"Mapeados {len(mapping)} símbolos ofuscados únicos.")

    # Passo 2: Substituir referências no conteúdo dos arquivos
    print("Atualizando referências nos arquivos de código...")
    for filepath in as_files:
        try:
            with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
                content = f.read()
            
            original_content = content
            # Substituir do maior para o menor para evitar substituição parcial de substrings
            for obf_word, clean_word in mapping.items():
                if obf_word in content:
                    content = content.replace(obf_word, clean_word)
            
            if content != original_content:
                with open(filepath, 'w', encoding='utf-8') as f:
                    f.write(content)
        except Exception as e:
            print(f"Erro ao processar conteúdo de {filepath}: {e}")

    # Passo 3: Renomear arquivos e pastas (do mais profundo para o mais raso)
    print("Renomeando arquivos e pastas...")
    # Coleta todos os caminhos e ordena por profundidade (descendente)
    all_paths = []
    for root, dirs, files in os.walk(target_dir):
        for name in files:
            all_paths.append((os.path.join(root, name), False))
        for name in dirs:
            all_paths.append((os.path.join(root, name), True))

    # Ordena caminhos por comprimento decrescente (profundidade)
    all_paths.sort(key=lambda x: len(x[0]), reverse=True)

    renamed_count = 0
    for path, is_dir in all_paths:
        dirname, basename = os.path.split(path)
        new_basename = basename
        for obf_word, clean_word in mapping.items():
            if obf_word in new_basename:
                new_basename = new_basename.replace(obf_word, clean_word)
        
        # Limpar caracteres inválidos remanescentes no nome do arquivo
        if not is_ascii(new_basename) or '§' in new_basename:
            # Substitui qualquer não-ascii por _
            new_basename = "".join(c if ord(c) < 128 and c != '§' else '_' for c in new_basename)

        if new_basename != basename:
            new_path = os.path.join(dirname, new_basename)
            try:
                if os.path.exists(path):
                    os.rename(path, new_path)
                    renamed_count += 1
            except Exception as e:
                print(f"Erro ao renomear {path} -> {new_path}: {e}")

    print(f"Sucesso! Substituições de referências completadas. {renamed_count} arquivos/pastas renomeados.")
    print("Dica: Agora você pode usar a pesquisa global do VS Code na pasta sem caracteres especiais ofuscados!")

if __name__ == '__main__':
    target = r"C:\Users\jeova\Downloads\Converted on 2022-06-04\_referencias\_game_outer_export"
    if len(sys.argv) > 1:
        target = sys.argv[1]
    deobfuscate_directory(target)
