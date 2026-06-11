# Relatorio de implementacoes do servidor e referencias AS

Data: 2026-06-08

Este relatorio resume o que esta implementado em `server_py`, quais arquivos do cliente ActionScript servem de referencia de protocolo, e quais recursos decodificados em `server_py/game_resources` alimentam o servidor.

## Fontes usadas

- Servidor Python: `server_py/servers`, `server_py/handlers`, `server_py/protocol`, `server_py/gameplay`, `server_py/map_manager.py`, `server_py/attribute_calculator.py`.
- Recursos do cliente: `server_py/game_resources`.
- Indices locais de comandos: `server_py/scratch_as_commands.txt` e `server_py/scratch_server_commands.txt`.
- Referencias AS exportadas: `_referencias/_game_outer_export/scripts/com/sunweb/game/rpg/worldZone/command/**` e `_referencias/_game_outer_export/scripts/com/sunweb/game/rpg/skill/**`.
- Pasta ignorada conforme pedido: `new_game`.

## Arquitetura implementada

O servidor esta separado em quatro frentes principais:

- `servers/http_server.py`: entrega launcher, SWF, `crossdomain.xml` e arquivos de `game_resources`.
- `servers/policy_server.py`: atende a politica de socket do Flash.
- `servers/login_server.py`: login, tickets e lista de servidores.
- `servers/world_server.py`: sessao do mundo, carregamento do personagem, envio inicial de estado, mapa, inventario, equipamentos, atributos, skills, pets, broadcast de jogadores e despacho para handlers.

O despacho modular fica em `handlers/registry.py`: cada handler declara `get_handlers()` com os comandos que atende. O protocolo binario usa `protocol/packet_reader.py`, `protocol/packet_builder.py` e os IDs em `protocol/commands.py`.

## Recursos em `game_resources`

`server_py/game_resources` contem:

- `index.html`, `WebLaucher.swf`, `swfobject.js`, `logo.swf`, `crossdomain.xml`: base do launcher HTTP.
- `bin/`, `res/`, `LoadingBG/`: arquivos estaticos consumidos pelo cliente Flash.
- `decoded_resource_manifest.json`: manifesto decodificado dos recursos.
- `decoded_idc.txt`, `decoded_idv.txt`, `decoded_iss.txt`, `decoded_ma1.json`: configuracoes globais/itens/mapas extraidas.
- `decoded/`: grande conjunto de `.lib` e arquivos decodificados usados como dados estaticos do jogo.

O indice de gameplay atual (`gameplay/resource_index.py`) carrega de `game_resources/decoded`:

- `isc.json`: skills, lista de skills por job, ataques basicos `xj1..xj7` e configuracoes de `levelInfo`, `castRule`, `resultRule`.
- `ibc.json`: buffs e efeitos.
- `iix.json`: objetos com `code`, `skillCode` e `buffId` adicionais.

Esses recursos sao usados pelo combate, aprendizado de skill, atributos e buffs.

## Referencias AS principais

### Mundo

Python:

- `protocol/commands.py`: `WorldCommandCode`.
- `handlers/world_handler.py`.
- `servers/world_server.py`.

AS:

- `_referencias/_game_outer_export/scripts/com/sunweb/game/rpg/worldZone/command/CommandCodeWorld.as`

Comandos implementados/considerados:

| Comando | ID | Python | AS |
|---|---:|---|---|
| WORLD_LOGIN_REQ | 33 | `WorldHandler.handle_world_login` | `CommandCodeWorld.as` |
| WORLD_LOGIN_ANSWER | 34 | resposta de login do mundo | `CommandCodeWorld.as` |
| WORLD_PING_ECHO | 49 | ping/keepalive | `CommandCodeWorld.as` |
| WORLD_CLIENT_SAVE_CONFIG_REQ | 50 | `ShortcutHandler`/config do cliente | `CommandCodeWorld.as` |
| WORLD_PVE_MAPS_NOTIFY | 81/82 | mapas PVE basicos | `CommandCodeWorld.as` |
| ROBOT_ACTION_REQUEST | 12081 | acao de bot/auto | `CommandCodeRobot.as` |

### Personagem e entrada no mundo

Python:

- `handlers/role_handler.py`
- `servers/world_server.py`
- `player_data_manager.py`
- `database.py`

AS:

- `worldZone/command/role/*`
- `worldZone/command/player/CommandCodePlayer.as`
- `PlayerEnterWorldRequest.as`
- `PlayerEnterWorldAnswer.as`
- `PlayerViewMapRequest.as`
- `PlayerViewMapAnswer.as`

Implementado:

- Listar personagens.
- Confirmar nome.
- Criar personagem.
- Selecionar personagem.
- Deletar personagem.
- Entrar no mundo e enviar estado inicial.
- Enviar outros players no mapa com remotes/broadcasts.

Comandos relevantes:

| Comando | ID | Observacao |
|---|---:|---|
| ROLE_LIST_REQ/ANSWER | 257/258 | lista de personagens |
| ROLE_NAME_CONFIRM_REQ/ANSWER | 259/260 | validacao de nome |
| CREATE_ROLE_REQ/ANSWER | 261/262 | criacao |
| DELETE_ROLE_REQ/ANSWER | 263/264 | exclusao |
| SELECT_ROLE_REQ/ANSWER | 265/272 | selecao |
| PLAYER_ENTER_WORLD_REQ/ANSWER | 513/514 | entrada efetiva no mapa |
| PLAYER_VIEW_MAP_REQ/ANSWER | 521/522 | consulta do mapa/monstros |

### Movimento, mapas e portais

Python:

- `handlers/movement_handler.py`
- `map_manager.py`
- `game_data/map_teleport_config.py`
- `servers/world_server.py`

AS:

- `PlayerMoveRequest.as`
- `PlayerPositionCheckNotify.as`
- `PlayerEnterMapRequest.as`
- `PlayerEnterMapAnswer.as`
- `MapPoint` usado nas estruturas de path/posicao.

Implementado:

- Movimento por path reverso (`PLAYER_MOVE_REQ`, 519).
- Confirmacao de posicao (`PLAYER_POSITION_CHECK_NOTIFY`, 520).
- Broadcast remoto de movimento.
- Entrada por portal (`PLAYER_ENTER_MAP_REQ`, 517) e resposta (`518`).
- Spawn/remoção de monstros por mapa.

Referencia de estrutura AS:

- `PlayerMoveRequest.as`: `mapId:string`, `pathArrayReversed:array(MapPoint)`.
- `PlayerPositionCheckNotify.as`: `mapId`, `position`, `walkSpeed`, `pathArrayReversed`, `reasonCode`.
- `PlayerEnterMapAnswer.as`: `toMapId`, `toPosition`, `failureReason`, `lineIndex`.

### Combate, skills e auto-ataque

Python:

- `handlers/combat_handler.py`
- `handlers/skill_handler.py`
- `gameplay/combat_rules.py`
- `gameplay/combat_scheduler.py`
- `gameplay/macro_engine.py`
- `gameplay/resource_index.py`
- `map_manager.py`

AS:

- `worldZone/command/player/CommandCodePlayer.as`
- `PlayerUseSkillRequest.as`
- `PlayerCancelSkillRequest.as`
- `PlayerSkillInterruptedNotify.as`
- `PlayerHpChangeNotify.as`
- `PlayerMpChangeNotify.as`
- `PlayerLearnSkillRequest.as`
- `PlayerLearnedSkillsCheckNotify.as`
- `PlayerLearnedSkillNotify.as`
- `worldZone/command/monster/CommandCodeMonster.as`
- `skill/SkillManager.as`
- `skill/PlayerSkillManager.as`

Implementado:

- Uso de skill/ataque (`PLAYER_USE_SKILL_REQ`, 545).
- Cancelamento/interrupcao (`PLAYER_CANCEL_SKILL_REQ`, 548; `PLAYER_SKILL_INTERRUPTED_NOTIFY`, 549).
- Ataque basico oficial por classe com codigos `xj1..xj7`, definidos no cliente por `WorldConfig.getDefaultAttackSkillCode(jobCode)` e presentes no primeiro item de cada lista `jobSkill` em `isc.json`.
- Fallbacks legados ainda aceitos: `za0`, `basic`, `hg1`.
- Correcao recente: alcance fallback do ataque basico aceita o fluxo legado em que o cliente anda ate a distancia e depois manda `UseSkill`; antes o servidor cancelava `za0` por distancia curta demais.
- Dano em monstro (`MONSTER_HP_CHANGE_NOTIFY`, 1286).
- Morte de monstro (`MONSTER_DIED_NOTIFY`, 1282).
- Ataque de monstro (`MONSTER_USE_SKILL_NOTIFY`, 1285) e dano no player (`PLAYER_HP_CHANGE_NOTIFY`, 550).
- Cooldown visual (`PLAYER_SKILL_CD_CHECK_NOTIFY`, 569).
- Custo de MP/HP/SP e notificacoes de MP.
- Cast time, sing time, key times, cooldown por grupo e global lock.
- Buffs, macros, traps, sysTraps, lifesteal, deslocamento e threat.
- AOE por radius/targetNumber.
- Dano fallback quando a skill basica nao tem configuracao carregada.
- Aprendizado de skill (`PLAYER_LEARN_SKILL_REQUEST`, 657), notify individual (`659`) e sync completo (`658`).

Referencia de estrutura AS:

- `PlayerUseSkillRequest.as`: `mapId:string`, `skillSn:ushort`, `skillCode:string`, `targetId:string`, `targetPoint:MapPoint`, `wrappedRequestBytes:byteArray`.
- `PlayerHpChangeNotify.as`: `hpChanged:double`, `hpCurrent:double`, `skillCode:string`, `isCriticalStrike:boolean`, `isHidden:boolean`.
- `PlayerMpChangeNotify.as`: `mpChanged:short`, `mpCurrent:int`, `skillCode:string`.
- `PlayerLearnSkillRequest.as`: `skillKind:byte`, `skillCode:string`, `ssKey:short`.
- `PlayerSkillManager.as`: injeta `WorldConfig.getDefaultAttackSkillCode(GameContext.localPlayer.fullInfo.jobCode)` em `haveSkills` com nivel 1; por isso ataque basico nao deve ser enviado como skill gastavel nem exigir `learnedSkills`.

### Inventario, equipamento e itens

Python:

- `handlers/inventory_handler.py`
- `handlers/loot_manager.py`
- `inventory_manager.py`
- `item_config_loader.py`
- `attribute_calculator.py`
- `servers/world_server.py`

AS:

- `worldZone/command/playerBag/CommandCodeBag.as`
- `worldZone/command/equ/CommandCodePlayerEquip.as`
- `PlayerBagUI.as` e UIs de inventario/equipamento.

Implementado:

- Envio de capacidade de bag.
- Check/sync de bag (`PLAYER_BAG_CHECK_NOTIFY`, 5121).
- Usar/equipar item (`PLAYER_USE_ITEM_REQUEST`, 5124).
- Mover item (`5125`).
- Dropar item (`5127`).
- Pegar item do mapa (`PLAYER_PICKUP_ITEM_REQUEST`, 5123).
- Ver detalhes (`PLAYER_VIEW_ITEM_REQUEST/ANSWER`, 5133/5134).
- Remover equipamento (`PLAYER_REMOVE_EQUIPMENT_REQUEST`, 4610).
- Trocar fashion (`4611/4612`).
- Ordenar mochila (`PLAYER_BAG_SORT_REQUEST`, 5141).
- Calculo de atributos a partir de `baseAttr`, `extAttr` e equipamentos.
- Drops de monstros e itens no chao (`MapItemAddedNotify`, `MapItemRemovedNotify` via IDs no loot).

### Loja e economia

Python:

- `handlers/shop_handler.py`
- `inventory_manager.py`
- `database.py`
- `servers/world_server.py`

AS:

- `worldZone/command/shop/CommandCodeShop.as`
- `worldZone/command/varShop/CommandCodeVarShop.as`

Implementado:

- Compra com ouro (`SHOP_BUY_ITEM_REQUEST`, 2818).
- Compra com cristal/store (`STORE_BUY_ITEM_REQ`, 2819).
- Venda (`SHOP_SELL_ITEM_REQUEST`, 2817).
- Respostas `SHOP_BUY_ITEM_ANSWER` (2826) e `SHOP_SELL_ITEM_ANSWER` (2825).
- Atualizacao de gold (`PLAYER_GOLD_CHANGE_NOTIFY`, 563).
- Atualizacao de money/cristal (`PLAYER_MONEY_CHANGE_NOTIFY`, 564).
- Comandos de reward/var shop mapeados em `protocol/commands.py` para trabalhos futuros.

### Chat, NPC e tarefas

Python:

- `handlers/chat_handler.py`
- `handlers/npc_handler.py`
- `handlers/task_handler.py`

AS:

- `PlayerSendMsgRequest.as`
- `PlayerReceiveMsgNotify.as`
- `worldZone/command/npc/CommandCodeNpc.as`
- `worldZone/command/task/CommandCodeTask.as`

Implementado:

- Chat local/sistema basico (`PLAYER_SEND_MSG_REQUEST`, 673; `PLAYER_RECEIVE_MSG_NOTIFY`, 674).
- Menu/acao de NPC (`NPC_FUNCTION_REQUEST`, 1025).
- Fala/dialogo (`PLAYER_SHOW_TALKS_NOTIFY`, 676).
- Receber, finalizar e abortar tarefas (`5889`, `5890`, `5891`) com notifies (`5892`, `5893`, `5894`).
- Progresso de kill/itens ligado ao combate/loot quando possivel.

### Pet, montaria, ride e equipe

Python:

- `handlers/pet_handler.py`
- `handlers/ride_handler.py`
- `handlers/mount_handler.py`
- `handlers/team_handler.py`

AS:

- `worldZone/command/pet/CommandCodePlayerPet.as`
- `worldZone/command/player/ride/*.as`
- `worldZone/command/team/CommandCodeTeam.as`

Implementado:

- Pet check/view/rename/forget skill/assign attr/learn skill/action mode/enhance/remove equipment/decompose.
- IDs principais: `PET_CHECK_NOTIFY` 5377, `PET_VIEW_REQUEST` 5378, `PET_LEARN_SKILL_REQUEST` 5383, `PLAYER_SET_PET_ACTION_MODE_REQUEST` 5411.
- Montar/desmontar e ride state (`PLAYER_RIDE_REQUEST` 593, `PLAYER_RIDE_STATE_CHECK_NOTIFY` 594).
- Convite de montaria (`PLAYER_INVITE_RIDE_REQUEST` 598, notify 599, reply 600).
- Usar ride (`PLAYER_SET_USING_RIDE_REQUEST` 602, notify 603).
- Adicionar exp de ride (`605`).
- Criar equipe, convidar, aceitar, sair e desfazer equipe (`8465`, `8471`, `8473`, `8479`, `8466`), com notify `PLAYER_TEAM_CHECK_NOTIFY` 8449.

## Correcoes recentes importantes

- O ataque basico `xj1..xj7` agora segue o contrato do cliente e nao depende de skill aprendida nem consome ponto; `za0`, `basic` e `hg1` seguem como fallbacks legados.
- `ResourceIndex` indexa `basic_attack_codes`, `is_basic_attack()` e `basic_attack_for_job_code()` a partir de `isc.json`.
- O alcance fallback do ataque basico foi aumentado para acompanhar o comportamento do cliente: selecionar alvo, caminhar ate a distancia de ataque, e entao bater.
- Testes em `server_py/tests/test_combat_handler_integration.py` garantem que todos os `xj1..xj7` causam dano como ataque basico; `server_py/tests/test_resource_index.py` cobre a ordem Flash `jobCode -> xj`.
- A suite `python -m unittest server_py.tests.test_combat_handler_integration server_py.tests.test_combat_rules` passou com 32 testes.

## Cobertura de testes atual

Testes relevantes em `server_py/tests`:

- `test_combat_handler_integration.py`: skill, dano, ataque basico, cooldown, key times, AOE, ground trap, recompensas.
- `test_combat_rules.py`: atributos, buffs, mitigacao, critico, cura, efeitos, traps.
- `test_combat_scheduler.py`: eventos agendados, cast/key times/cancelamento.
- `test_macro_combat_integration.py`: macro engine e efeitos de combate.
- `test_combat_audit.py`, `test_combat_completion.py`: auditoria/cobertura de combate.
- `test_smart_logging.py`: logging estruturado.

## Pendencias e riscos

- Muitos CommandCode AS ainda existem sem handler Python completo; especialmente sistemas avancados como angel, divine, cloak, glyph, challenge, wardrobe, artifact, family, mail e ranking.
- Alguns comandos ainda usam IDs literais no Python; ideal consolidar todos em `protocol/commands.py`.
- Algumas estruturas de resposta sao aproximadas e devem ser validadas contra os arquivos AS de request/notify quando um fluxo quebrar.
- `game_resources/decoded` e grande; `ResourceIndex` continua propositalmente limitado a skill/buff/job skill e ataques basicos. Para outras mecanicas, usar `GameResourceService` e loaders lazy por dominio.
- Estado Git atual em 2026-06-09: existe `.git` na raiz, ainda sem commit inicial.

## Como continuar

1. Para qualquer comando novo, procurar primeiro em `_referencias/.../command/*/CommandCode*.as`.
2. Abrir o arquivo AS de request/answer/notify correspondente para copiar a ordem exata dos campos.
3. Registrar o ID em `protocol/commands.py`.
4. Implementar o handler em `handlers/`.
5. Adicionar teste de roundtrip/handler em `server_py/tests`.
6. Verificar com logs em `server_py/logs/latest.log` e, se for combate, `server_py/logs/combat/*.log`.


## Atualizacao 2026-06-09

Este relatorio estava desatualizado em relacao ao codigo atual.

Estado validado agora:

- Dispatcher real: 109 comandos registrados.
- PostgreSQL principal `mspt1` validado em `localhost:5432`.
- Migration PostgreSQL criada: `server_py/tools/sql/postgres_advanced_item_systems.sql`.
- Tabelas avancadas aplicadas no PostgreSQL: `TB_AgentItem`, `TB_RoleBooth`, `TB_BoothItem`, `TB_RoleArmory`, `TB_RoleWardrobe`, `TB_RoleArtifactState`, `TB_RoleKindGrow`.
- Inventario/equipamento: view bag 5129, renew 5137, buy-and-use 5138, reparo 4618-4621 e durabilidade 4613.
- Pet system: view, rename, learn/forget skill, assign attr, action mode, enhance, fusion, remove equipment e decompose.
- Sistemas avancados persistentes: agent market, booth, armory, wardrobe, artifact e equip kindGrow.
- `LootManager` e o dono de pickup/drop no mapa (`5123` e `5127`); drop groups hardcodeados (`bw0200`, `ab0000`, `bb1000`); arquivo corrigido (duplicação removida, `@classmethod` adicionado).
- Spawn `b0100` (Senhor Golem lv10) no mapa a4 já existe nos dados (`ma4.json`).
- **NOVO**: Handler `NPC_ASSEMBLE_ITEM_REQUEST` (1026) / `NPC_ASSEMBLE_ITEM_ANSWER` (1027) em `NpcHandler` para montagem de itens (wing/pet/ride/armory via `assembleRuleIndex`).
- **NOVO**: Handler `PLAYER_WING_SPIRIT_REQUEST` (12544) / `PLAYER_WING_SPIRIT_ANSWER` (12545) em `WingSpiritHandler` para espírito das asas (`equipmentId`, `spiritType`, `doType`).
- **NOVO**: Quest chain 4999-5020 implementada no `TaskHandler` com suporte a `_main_tasks_4990_5020.json`, `npcMenuReceive`, `npcMenuFinish`, `clientMacro`, auto-receive e conditions.
- Testes atuais: `python -m unittest discover server_py/tests` passa com 85 testes.
- Recursos: `server_py/gameplay/game_resource_service.py` adicionado como cache lazy por dominio; `server_py/tools/audit_resource_domains.py` adicionado para mapear configs decodificadas.
- Auditoria inicial encontrou candidatos: pet 56, artifact 2, glyph 3, angel 13, cloak 4, divine 5, family 31, mail 2, rank 31, shop 10, kindGrow 3, armory 3, wardrobe 2.

As secoes antigas acima devem ser lidas como historico quando contradisserem este bloco.
