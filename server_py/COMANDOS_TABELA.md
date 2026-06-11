| Nome do Comando | CÃ³digo ID | DireÃ§Ã£o | DescriÃ§Ã£o |
|-----------------|-----------|---------|-----------|
| WelcomeNotify | 16 | Sâ†’C | Envia a chave da sessÃ£o ao conectar |
| LoginRequest | 17 | Câ†’S | Envio do nome de usuÃ¡rio e hash de senha |
| LoginAnswer | 18 | Sâ†’C | Retorno de status de login (Sucesso/Erro) + Ticket |
| ServerListRequest | 23 | Câ†’S | Requisita a lista de servidores disponÃ­veis |
| ServerListAnswer | 24 | Sâ†’C | Retorna a lista de servidores ativos e status de carga |
| WorldLoginReq | 33 |  | Entrar no mundo fornecendo o Ticket obtido no Login |
| WorldLoginAnswer | 34 |  | Status do resultado da validaÃ§Ã£o do Ticket de entrada |
| WorldPingEcho | 49 |  | SinalizaÃ§Ã£o de keep-alive periÃ³dica para manter conexÃ£o |
| ClientSaveConfigNotify | 50 |  | Salva configuraÃ§Ãµes personalizadas do usuÃ¡rio |
| RoleListReq | 257 |  | Busca a lista de personagens criados na conta |
| RoleNameConfirmReq | 259 |  | Valida se um nome de personagem estÃ¡ livre para uso |
| CreateRoleReq | 261 |  | CriaÃ§Ã£o de um novo personagem no servidor |
| DeleteRoleReq | 263 |  | ExclusÃ£o de um personagem |
| SelectRoleReq | 265 |  | Escolhe o personagem para iniciar a gameplay |
| PlayerEnterWorldReq | 513 |  | Solicita entrada fÃ­sica e spawn no mundo do jogo |
| PlayerEnterMapReq | 517 |  | TransiÃ§Ã£o de mapa por portais |
| PlayerMoveReq | 519 |  | MovimentaÃ§Ã£o baseada em caminho/coordenadas |
| PositionCheckNotify | 520 |  | Sincroniza a posiÃ§Ã£o exata do jogador com o servidor |
| UseSkillReq | 545 |  | Uso de habilidades ou ataques fisicos/magicos; ataque padrao por classe usa `xj1..xj7` |
| SendMsgRequest | 673 |  | Envio de mensagens no chat |
| ShopSellItemReq | 2817 |  | Vende um item da mochila para a loja do NPC |
| ShopBuyItemReq | 2818 |  | Compra um item do NPC usando ouro |
| StoreBuyItemReq | 2819 |  | Compra um item da loja de cash utilizando cristais |
| EquipmentCheckNotify | 4609 |  | Sincroniza os equipamentos atuais no corpo do personagem |
| RemoveEquipmentReq | 4610 |  | Retira um equipamento do personagem e devolve Ã  mochila |
| BagCheckNotify | 5121 |  | Sincroniza os itens da mochila com o cliente |
| UseItemReq | 5124 |  | Usa consumÃ­veis ou equipa itens da bag |
| MoveItemReq | 5125 |  | Move itens de posiÃ§Ã£o ou entre diferentes mochilas |
| DropItemReq | 5127 |  | Descarta um item no chÃ£o |
| ViewItemReq | 5133 |  | Solicita detalhes extras de atributos de um item |
| BagSortReq | 5141 |  | OrdenaÃ§Ã£o automÃ¡tica da mochila |
## Atualizacao 2026-06-09

Este arquivo estava incompleto. O indice completo atual foi regenerado em `server_py/scratch_server_commands.txt`.

| Nome do Comando | Codigo ID | Estado atual |
|-----------------|-----------|--------------|
| PlayerViewBagRequest | 5129 | Handler real, responde BagCheck |
| PlayerRenewItemRequest | 5137 | Persiste RenewRuleIndex |
| PlayerBuyAndUseItemRequest | 5138 | Compra, desconta Gold e consome |
| PlayerViewRepairInfo/RepairEquipment | 4618-4621 | Reparo real com durabilidade |
| EquipDurCheckNotify | 4613 | Sincroniza durabilidade |
| Lead/VIP/Reward/Var shop | 2821/2822/2823/10557/10560 | Handlers registrados |
| Pet system | 5378-5431 | Gerenciamento, skills, atributos e upgrades |
| Trade | 2897/2899/2914/2916/2918/2920 | Fluxo protocolar |
| Booth/player shop | 2946-2953 | Persistente em TB_RoleBooth/TB_BoothItem |
| Agent market | 2865-2872 | Persistente em TB_AgentItem |
| Armory | 4625-4629 | Persistente em TB_RoleArmory |
| Wardrobe | 8293-8297 | Persistente em TB_RoleWardrobe |
| Artifact | 6145-6209 | Persistente em TB_RoleArtifactState |
| Equip KindGrow | 10800-10810 | Persistente em TB_RoleKindGrow |
| NPC_ASSEMBLE_ITEM_REQUEST/ANSWER | 1026/1027 | Handler em NpcHandler para montagem itens (wing/pet/ride/armory) |
| PLAYER_WING_SPIRIT_REQUEST/ANSWER | 12544/12545 | Handler em WingSpiritHandler para espÃ­rito das asas |
| Task chain 4999-5020 | 5889-5895 | TaskHandler com _main_tasks_4990_5020.json, npcMenuReceive, clientMacro, auto-receive e fallback de coleta |
| Farm harvest collect test | 1828/1829 | FarmHandler responde teste de coleta e progride missao ativa de coleta |

Observacao de recursos: comandos com custo, progressao ou regra economica devem consultar configs decodificadas via `server_py/gameplay/game_resource_service.py`. Antes de implementar um sistema novo, rode `python server_py/tools/audit_resource_domains.py --max-examples 6` para localizar os JSONs candidatos.

**Atualizacao 2026-06-09 (loot fix)**: `loot_manager.py` corrigido - duplicaÃ§Ã£o removida dentro de `handle_pickup_item`, `@classmethod` adicionado em `get_handlers()`, linha duplicada `packet_data = notify.build()` removida em `spawn_loot_on_ground`. Drop groups hardcodeados: `bw0200`, `ab0000`, `bb1000`. Spawn `b0100` no mapa a4 confirmado em `ma4.json`.

**Atualizacao 2026-06-09 (novos handlers)**: Adicionados `NpcCommandCode` (1026/1027) e `WingSpiritCommandCode` (12544/12545) em `protocol/commands.py`. Handlers implementados: `NpcHandler.handle_assemble_item` e `WingSpiritHandler.handle_wing_spirit`.

**Atualizacao 2026-06-09 (quest chain)**: Quest chain 4999-5020 implementada no `TaskHandler` carregando `_main_tasks_4990_5020.json`. Suporte a `npcMenuReceive` (talks ao aceitar), `npcMenuFinish` (talks ao concluir), `clientMacro` (ex: showWelcome), auto-receive com conditions (`hasDoneTask`, `roleJob=`, `mainBagSpace>=`), e `equipItems` condition para finish.

**Atualizacao 2026-06-10 (quest/inventario 1-10)**: `TaskHandler` agora evita reaplicar recompensa ao receber/concluir missao repetida, nao reenvia falas de aceite apos `RECEIVE_REQUEST`, e cobre os contratos iniciais `itemsInBag`, `equipItems`, `hp%>=`, `boolVar=`, `jobSkPtUsed>=`, `hasKilledMonster`, `loseItems`, `clearItems`, `setBoolVar` e `clearBoolVar`. `CombatHandler` incrementa `killedMonsters.int` em kill de monstro. `Database.add_item_to_inventory` corrige `MaxStack` stale usando `stackSize` dos JSONs decodificados, permitindo pocoes empilharem no mesmo slot.

**Atualizacao 2026-06-10 (fix pos-teste 1-10)**: Corrigido `KeyError: 'BagIndex'` ao remover item de missao em `loseItems` (ex: `q50060` da missao 5006). O normalizador do banco agora reconhece `bagindex`, e `TaskHandler._remove_item_code` aceita chaves normalizadas/minusculas. `TaskHandler._send_show_talks` tambem filtra falas `speaker: "i"` para evitar uma fala extra do proprio personagem apos fechar a fala final do NPC.

**Atualizacao 2026-06-10 (coleta/dialogo 5010)**: Logs do teste mostraram `cmd=5895` desconhecido durante a missao `5010` de coletar ervas. No AS, `5895` e `PLAYER_FINISH_SUCCESS_REQUEST` com campo `successId:ushort`; o `TaskHandler` agora registra esse comando, responde `5896` (`PLAYER_FINISH_SUCCESS_NOTIFY`) e usa o request como fallback controlado para missoes ativas de coleta por `itemsInBag`, entregando 1 item faltante por vez ate o limite do objetivo (ex: `q50100` 0/2 -> 1/2 -> 2/2). Naquele momento foi tentado desativar o envio automatico de `npcMenuFinish` ao concluir missao por causa do loop ao fechar no X; o estado atual verificado em 2026-06-11 voltou a enviar `npcMenuFinish` com filtro de falas `speaker: "i"`.

**Atualizacao 2026-06-10 (farm harvest visual)**: Confirmado em `ma2.json` que o mapa `a2` tem `harvestRule.harvestArray` com 16 plantas `q50100`. O `PlayerViewMapAnswer` (`522`) agora serializa esses registros no array `farmHarvests` como `FarmHarvestInfo` (`fh_a2_0..fh_a2_15`), permitindo o cliente criar `AIFarmHarvest` clicavel. Criado `FarmHandler` para `FARM_HARVEST_COLLECT_TEST_REQUEST` (`1828`, `farmHarvestId:string`) respondendo `1829` com `canCollect=True`, `hasNoProduct=False`, cooldown 0, e tambem chamando o progresso controlado da missao ativa de coleta. Total atual de comandos registrados: 111.

**Atualizacao 2026-06-11 (verificacao de task/clientMacro)**: Confirmado no codigo atual que `TaskHandler` envia `npcMenuFinish` ao concluir missao via `PLAYER_SHOW_TALKS_NOTIFY` (`676`), filtrando falas `speaker: "i"`. `clientMacro` de finish agora reconhece `showWelcome <npc_id>` e tenta enviar `NPC_FUNCTION_ANSWER` (`1029`) com `npc_id:string` e byte `0`; ainda precisa teste no Flash para saber se isso abre a janela correta. No Enter World, `WorldSession` chama `_trigger_auto_receive_quests()` em `server_py/servers/world_server.py` apos os pacotes iniciais, acionando o auto-receive. Ponto de atencao: a chain `4999-5020` possui 21 missoes no JSON, mas `5007` depende de `5024`, que nao existe em `_main_tasks_4990_5020.json`.

**Atualizacao 2026-06-09 (combate/skills)**: `UseSkillReq` (545) segue o AS: `WorldConfig.getDefaultAttackSkillCode(jobCode)` retorna `xj1..xj7`, e `PlayerSkillManager` injeta esse ataque como nivel 1. O servidor reconhece `xj1..xj7` como ataques basicos implicitos via `ResourceIndex`, sem exigir `learnedSkills` nem consumir ponto de skill. Fallbacks legados aceitos: `za0`, `basic`, `hg1`. Testes: 85 OK.

**Plano de reconstrucao**: ver `ASA_RECONSTRUCAO_PLANO.md` na raiz para a ordem atual de trabalho: consolidar progressao 1-30 com quatro classes principais e asa normal; asa heroica, espirito de asa e sistemas endgame ficam para depois.

