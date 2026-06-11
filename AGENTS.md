# Leia primeiro

Este repo eh a reconstrucao do MMORPG Flash Asa de Cristal. Trabalhe como engenharia reversa: confirme no ActionScript exportado antes de mudar protocolo Python.

## Ordem de contexto

1. Leia `README.md` para entender o estado geral.
2. Leia `TOOLS.md` para usar as ferramentas locais.
3. Para servidor Python, leia `server_py/DOCUMENTACAO_SERVIDOR.md` e `server_py/COMANDOS_TABELA.md`.
4. Para comandos/protocolo, compare sempre:
   - ActionScript em `_referencias/_game_outer_export/scripts/`
   - Python em `server_py/handlers/`, `server_py/protocol/`, `server_py/servers/world_server.py`
5. Para contexto de IA grande, rode `npm run repomix:tokens` antes de empacotar. Respeite `.repomixignore`.

## Ferramentas obrigatorias

Use busca estreita. Nao liste o repo inteiro.

```powershell
.\.tools\bin\rg.cmd "5895"
.\.tools\bin\rg.cmd "End of file"
.\.tools\bin\rg.cmd "write_transportable_object"
.\.tools\bin\fd.cmd task_handler
.\.tools\bin\fd.cmd "CommandCode"
.\.tools\bin\repomix.cmd --token-count-tree
```

Equivalentes npm:

```powershell
npm run rg -- "FarmHarvestCollectTest"
npm run fd -- combat_handler
npm run repomix:tokens
npm test
```

RTK local:

```powershell
.\.rtk-bin\rtk.exe git status
.\.rtk-bin\rtk.exe git diff
.\.rtk-bin\rtk.exe pytest
```

## Regras de eficiencia

- Use `rg` antes de abrir arquivos grandes.
- Use `fd` para achar arquivos por nome.
- Nao leia `server_py/game_resources/`, `new_game/asset_lab/`, SWFs, caches, logs, backups ou binarios salvo se a tarefa pedir.
- Nao empacote `_referencias/` inteira para IA; pesquise nomes/classes especificas com `rg`.
- Se o erro for `End of file`, suspeite primeiro de mismatch de campos/tipos no pacote, tamanho duplicado em transportable object, ou `send()` truncando em vez de `sendall()`.
- `world_server.py` pode ter definicoes duplicadas; em Python vale a ultima definicao carregada.
- Para comandos novos, implemente a partir dos campos exatos do AS: request, answer e notify.
- Ao mexer em gameplay/protocolo, rode `npm test` ou `python -m unittest discover server_py/tests`.

## Mapas mentais rapidos

- Handlers: `server_py/handlers/`
- Registro de comandos: `server_py/handlers/registry.py`
- IDs AS coletados: `server_py/scratch_as_commands.txt`
- IDs servidor: `server_py/scratch_server_commands.txt`
- Packet builder/reader: `server_py/protocol/`
- Servidor mundo e serializers: `server_py/servers/world_server.py`
- Recursos decodificados grandes: ignorados por padrao; use ferramentas de auditoria em `server_py/tools/`.

## Antes de responder

Mostre o que verificou, cite arquivos concretos e diga quais testes rodou. Se nao rodou teste, diga por que.
