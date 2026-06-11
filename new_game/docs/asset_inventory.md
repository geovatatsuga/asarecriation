# Asset Inventory

Inventario gerado a partir dos recursos decodificados do cliente Flash.

## Resumo

- Arquivos decodificados: 12832
- Tamanho total decodificado: 6161.70 MB

## Categorias

- `packed_visual_lib`: 10704
- `characters_or_creatures`: 917
- `config_json`: 623
- `icons_effects_or_items`: 326
- `image_blob`: 239
- `core_config`: 9
- `job_portraits`: 7
- `maps`: 5
- `other`: 2

## Extensoes

- `.lib`: 11955
- `.json`: 636
- `.img`: 239
- `.bin`: 1
- `.txt`: 1

## Grupos De Carregamento Do Cliente

- `res1`: 11 recursos
- `res2`: 123 recursos
- `res3`: 2 recursos

## Primeiros Candidatos Para Importar No Godot

- `idc` -> `server_py\game_resources\decoded\idc.json` (core_config, 246.9 KB)
- `idv` -> `server_py\game_resources\decoded\idv.json` (core_config, 41.4 KB)
- `ihc` -> `server_py\game_resources\decoded\ihc.json` (core_config, 0.4 KB)
- `iie` -> `server_py\game_resources\decoded\iie.json` (core_config, 9445.4 KB)
- `ipm` -> `server_py\game_resources\decoded\ipm.json` (core_config, 199.5 KB)
- `iss` -> `server_py\game_resources\decoded\iss.json` (core_config, 119.0 KB)
- `ma1` -> `server_py\game_resources\decoded\ma1.json` (maps, 250.9 KB)
- `ma2` -> `server_py\game_resources\decoded\ma2.json` (maps, 25.1 KB)
- `map` -> `server_py\game_resources\decoded\map.lib` (maps, 1074.0 KB)
- `ou0` -> `server_py\game_resources\decoded\ou0.lib` (job_portraits, 145.8 KB)
- `ou1` -> `server_py\game_resources\decoded\ou1.lib` (job_portraits, 106.8 KB)
- `ou2` -> `server_py\game_resources\decoded\ou2.lib` (job_portraits, 119.0 KB)
- `ou3` -> `server_py\game_resources\decoded\ou3.lib` (job_portraits, 118.0 KB)
- `ou4` -> `server_py\game_resources\decoded\ou4.lib` (job_portraits, 117.3 KB)
- `ou5` -> `server_py\game_resources\decoded\ou5.lib` (job_portraits, 357.3 KB)
- `ou6` -> `server_py\game_resources\decoded\ou6.lib` (job_portraits, 155.0 KB)

## Proxima Leitura Recomendada

1. Entender `ma1.json` e `ma2.json` para escolher um mapa pequeno de teste.
2. Entender `ipm.json` para renderizar um personagem base.
3. Investigar `.lib`/`.img` para converter sprites para PNG ou atlas Godot.
4. Criar importador apenas de leitura, copiando assets para `client_godot/assets/legacy`.
