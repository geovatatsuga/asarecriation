# Guia para implementar novos comandos AS no servidor

Use este fluxo sempre que aparecer um comando novo no cliente Flash.

## Checklist

1. Procurar primeiro em `_referencias/_game_outer_export/scripts/com/sunweb/game/rpg/worldZone/command/**/CommandCode*.as`.
2. Abrir o arquivo AS de request, answer ou notify correspondente.
3. Copiar a ordem exata dos campos declarados no metodo de serializacao/lista de campos do AS.
4. Registrar o ID em `server_py/protocol/commands.py`.
5. Implementar o handler em `server_py/handlers/`.
6. Registrar o handler em `get_handlers()`.
7. Adicionar teste de roundtrip ou handler em `server_py/tests/`.
8. Verificar em runtime com `server_py/logs/latest.log`.
9. Se for combate, verificar tambem `server_py/logs/combat/*.log`.

## Regra pratica

O servidor deve seguir o AS, nao o contrario. Se um pacote falhar, a primeira suspeita deve ser ordem de campos, tipo numerico, string/byteArray ou objeto transportable com tamanho incorreto.

## Pontes uteis

- Indice AS extraido: `server_py/scratch_as_commands.txt`
- Indice de uso no servidor: `server_py/scratch_server_commands.txt`
- Commands Python: `server_py/protocol/commands.py`
- Dispatcher: `server_py/handlers/registry.py`
- Recursos de skill/buff: `server_py/gameplay/resource_index.py`
- Recursos por dominio: `server_py/gameplay/game_resource_service.py`
- Auditoria de recursos: `server_py/tools/audit_resource_domains.py`
- Recursos decodificados: `server_py/game_resources/decoded`


## Atualizacao 2026-06-09

Este guia continua valido, mas ganhou uma exigencia para sistemas com estado real:

- Validar o schema no banco principal PostgreSQL, nao apenas no SQLite.
- Atualizar `server_py/database.py` e criar migration em `server_py/tools/sql/`.
- Regenerar `server_py/scratch_server_commands.txt` depois de mudar handlers.
- Rodar `python -m unittest discover server_py/tests`.

Estado atual confirmado:

- PostgreSQL principal: database `mspt1` em `localhost:5432`.
- Migration nova: `server_py/tools/sql/postgres_advanced_item_systems.sql`.
- Comandos registrados no dispatcher: 109.
- Testes atuais: 80 OK.

Para comandos que precisam de semantica real, rode a auditoria de recursos antes de codar custo/regra:

```bash
python server_py/tools/audit_resource_domains.py --max-examples 6
```

O pacote continua vindo do AS. A regra economica/progressao deve vir do banco e dos JSONs decodificados quando existir config correspondente.
