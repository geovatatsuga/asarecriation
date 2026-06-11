# Asa de Cristal - Plano de Reconstrucao Jogavel 1-30

Atualizado em 2026-06-11.

Este plano guia a reconstrucao do Asa de Cristal antes das mudancas autorais em
`new_game`. A meta agora nao e completar o MMO original, nem levar o jogo ate
endgame. A meta e montar uma base pequena, jogavel e confiavel ate o nivel 30,
com mapas, missoes, combate, drops, equipamentos, skills principais e asa normal.

## Estado atual do trabalho

Ultimo bloco trabalhado: **Fase 1 - Nivel 1-10 / chain inicial 4999-5020**.

Arquivos alterados neste bloco:

- `server_py/handlers/task_handler.py`
- `server_py/handlers/farm_handler.py`
- `server_py/handlers/registry.py`
- `server_py/servers/world_server.py`
- `server_py/handlers/combat_handler.py`
- `server_py/database.py`
- `ASA_RECONSTRUCAO_PLANO.md`
- `server_py/COMANDOS_TABELA.md`

O que foi corrigido em 2026-06-10:

- Inventario: pocoes e consumiveis agora respeitam `stackSize` dos JSONs
  decodificados mesmo quando o banco antigo tem `MaxStack=1`. Exemplo:
  `dy1000`, `dy0000` e `dy0001` possuem `stackSize: 250` em `iix.json`, entao
  devem empilhar no mesmo slot antes de abrir outro.
- Missoes: aceitar a mesma missao novamente nao reaplica `onReceived`.
- Missoes: concluir a mesma missao novamente nao reaplica `onFinished`.
- Dialogo: depois do `RECEIVE_REQUEST`, o servidor nao reenvia mais
  `npcMenuReceive` como uma nova janela de fala. Isso reduz o loop em que o
  jogador fecha no X e ainda aparecem falas extras.
- Dialogo: `PLAYER_SHOW_TALKS_NOTIFY` de missao agora ignora falas com
  `speaker: "i"` por enquanto. Isso evita o caso dos NPCs iniciais em que o
  jogador fecha a ultima fala do NPC e ainda aparece uma fala extra do proprio
  personagem.
- Dialogo: em 2026-06-10 houve uma tentativa de nao enviar `npcMenuFinish`
  automaticamente ao concluir missao para reduzir loop de falas ao fechar no X.
  O estado atual verificado em 2026-06-11 voltou a enviar `npcMenuFinish` com
  filtro de `speaker: "i"`; ver bloco de verificacao abaixo.
- Missoes de coleta: o comando AS `PLAYER_FINISH_SUCCESS_REQUEST` (`5895`,
  payload `successId:ushort`) foi registrado no `TaskHandler`. O servidor
  responde com `PLAYER_FINISH_SUCCESS_NOTIFY` (`5896`) e, quando existe uma
  missao ativa de coleta por `itemsInBag` sem objetivo de matar monstro,
  entrega 1 item faltante por request ate o limite do objetivo. Isso destrava
  a missao `5010`/`q50100` enquanto o spawn visual de plantas coletaveis ainda
  nao esta reconstruido.
- Coleta visual: `PlayerViewMapAnswer` (`522`) agora preenche o array
  `farmHarvests` a partir de `harvestRule.harvestArray` do mapa. No mapa `a2`
  existem 16 harvests `q50100`, com ids gerados `fh_a2_0..fh_a2_15`. Isso deve
  fazer as ervas aparecerem como `AIFarmHarvest` clicavel no cliente.
- Coleta visual: criado `FarmHandler` para `FARM_HARVEST_COLLECT_TEST_REQUEST`
  (`1828`, campo `farmHarvestId:string`). O servidor responde `1829` com
  `canCollect=True` e tambem chama o progresso controlado de coleta da missao.
- Task conditions: a chain inicial agora entende `itemsInBag`, `equipItems`,
  `hp%>=`, `boolVar=`, `jobSkPtUsed>=` e `hasKilledMonster`.
- Task macros: a chain inicial agora aplica `receiveItems`, `loseItems`,
  `clearItems`, `setBoolVar`, `clearBoolVar` e o caso simples de `execScripts`
  com `addHp%`.
- Combate/missao: ao matar monstro, `CombatHandler` incrementa
  `player_data['killedMonsters']['int'][monster_code]`, permitindo objetivos
  como `hasKilledMonster: {"g0050": 3}`.
- Bug corrigido apos teste em jogo: concluir a missao `5006` desconectava o
  cliente com `KeyError: 'BagIndex'` ao aplicar `loseItems: {"q50060": 1}`.
  Causa: normalizador do banco nao tinha alias para `bagindex`, e a remocao de
  item de missao assumia `row['BagIndex']`. Corrigido em `database.py` e
  `task_handler.py`.

Verificacao de 2026-06-11 sobre alteracoes feitas por outra IA:

- Confirmado no codigo: `server_py/handlers/task_handler.py` voltou a enviar
  `npcMenuFinish` ao concluir missao, usando `_send_show_talks()` e filtrando
  falas com `speaker: "i"`. Portanto, a anotacao antiga dizendo que
  `npcMenuFinish` nao era enviado automaticamente esta superada pelo estado
  atual do arquivo.
- Confirmado no codigo: `TaskHandler._execute_client_macro()` reconhece
  `showWelcome <npc_id>` e tenta enviar `NPC_FUNCTION_ANSWER` (`1029`) com
  `npc_id:string` e um byte `0`. Isso afeta os `clientMacro` de finish, como
  `showWelcome n018@a1`, `showWelcome h4@o5` e `showWelcome h5@o5`.
- Confirmado no codigo: `server_py/servers/world_server.py`, depois do
  `PlayerEnterWorldAnswer` (`514`), envia dados de mapa/pet/view-map/enter-map e
  chama `_trigger_auto_receive_quests()`, que aciona
  `TaskHandler._auto_receive_available_tasks()`.
- Confirmado no JSON: `_main_tasks_4990_5020.json` contem 21 missoes da chain
  inicial (`4999`, `5000`, `5002`..`5020`) com `autoReceive` em todas elas,
  mas nao contem a missao `5024`.
- Ponto de atencao confirmado: a missao `5007` existe, mas seu
  `receiveRule.condition.hasDoneTask` exige `5024`; como `5024` nao existe
  neste arquivo, a chain pode travar antes da `5007` ate essa dependencia ser
  corrigida ou a missao `5024` ser adicionada.
- Nao foi confirmado no cliente Flash se o pacote basico de `showWelcome`
  realmente abre a janela desejada. Se nao abrir, o fallback atual continua
  sendo o envio das falas por `PLAYER_SHOW_TALKS_NOTIFY` (`676`).

Correcao aplicada em 2026-06-11 apos teste real:

- O teste em jogo mostrou que personagem novo pulava a primeira missao da Deusa
  e ja aparecia na etapa do Claude. Causa encontrada:
  `server_py/player_data_manager.py` semeava personagem sem historico com
  `4999` ja concluida e `5000` ativa.
- Corrigido: personagem novo agora inicia com `4999` ativa na Deusa
  (`doingTasks: [4999]`, allocator `18`) e sem `doneTasks`.
- Corrigido tambem o legado desse seed ruim: se um personagem tiver apenas
  `4999` concluida com `AllocatorId=0` e `5000` ativa, o carregamento reverte
  para `4999` ativa e remove `5000`, para o teste poder recomecar na Deusa.
- Teste novo: `server_py/tests/test_player_data_manager.py`.

Validacao feita:

- `python -m unittest discover server_py/tests`
- Resultado: 85 testes OK.

Onde estamos:

- A base de missao 1-10 esta mais correta no servidor, mas ainda precisa de
  reteste jogavel no Flash com personagem iniciando pela Deusa (`4999`).
- O ultimo teste em jogo travou em `5010` porque o cliente enviava `5895` a
  cada tentativa de interacao/coleta e o servidor marcava como comando
  desconhecido. Esse handler foi adicionado.
- Na investigacao seguinte foi confirmado que `ma2.json` ja tinha
  `harvestRule.harvestArray` com plantas `q50100`; o servidor e que nao estava
  serializando `farmHarvests` no `PlayerViewMapAnswer`. Isso tambem foi
  corrigido; precisa retestar no Flash.
- A chain atual ainda so leva aproximadamente ate nivel 5 pela XP documentada,
  entao falta ajustar recompensas/novas missoes para chegar no nivel 10.
- A chain `4999-5020` ainda tem uma dependencia suspeita: `5007` pede
  `hasDoneTask: [5024]`, mas `5024` nao esta em `_main_tasks_4990_5020.json`.
  Corrigir isso vem antes de considerar a cadeia 1-10 fechada.
- Ainda falta confirmar no cliente se:
  - pocoes empilham em um slot;
  - a missao da pocao e os NPCs iniciais fecham sem falas extras do jogador ou
    do NPC apos apertar X;
  - equipar arma/armadura conclui a missao correta;
  - matar monstros atualiza objetivos de kill;
  - usar itens de missao que setam `boolVar` conclui as missoes de agua/fonte.
  - concluir a missao `5006` do Prefeito remove `q50060` sem desconectar.
  - a missao `5010` mostra as plantas `q50100` no mapa `a2`;
  - clicar/coletar uma planta envia `1828` e/ou `5895`, entrega `q50100` e
    permite concluir.

Proximo passo imediato:

1. Retestar a chain 4999-5020 em jogo desde a Deusa (`4999`), confirmando que
   ela nao pula direto para Claude (`5000`).
2. Depois de concluir a Deusa, verificar se `5000` aparece no Claude e se a
   conclusao/auto-receive nao dispara dialogos fora de ordem.
3. Retestar a chain a partir de `5010`, olhando logs para
   `PlayerViewMapAnswer ... 16 harvests`, `FarmHarvestCollectTest` e/ou
   `PlayerFinishSuccess`, com `collect=task=5010:q50100`.
4. Ler os logs desse teste e corrigir somente os objetivos que ainda travarem.
5. Depois que 1-10 estiver limpo, ajustar XP/recompensas para o jogador chegar
   perto do nivel 10 sem comando manual.

## Norte do projeto

Objetivo principal:

- Reconstruir uma linha jogavel do Asa de Cristal ate o nivel 30.
- Usar o Asa original como biblioteca de recursos, nao como lista obrigatoria.
- Priorizar sistemas que sustentam o loop: entrar, explorar, lutar, completar
  missao, ganhar item, equipar, upar e ficar mais forte.
- Manter `new_game` como etapa posterior, quando a base do Asa estiver estavel.
- Evitar Protoss e Domador na primeira fase. Eles ficam para depois.

## Escopo fechado da primeira base

### Incluido

- Nivel 1-30.
- Classes principais:
  - Cavaleiro / `paladin`
  - Arqueiro / `elf`
  - Ladino / `killer`
  - Mago / `fairy`
- Ataque basico por classe:
  - Cavaleiro: `xj1`
  - Arqueiro: `xj2`
  - Ladino: `xj3`
  - Mago: `xj4`
- Skills aprendiveis basicas ate nivel 30, escolhidas da arvore `jobSkill` em
  `isc.json`.
- Missao principal e poucas side quests simples.
- Mapas iniciais selecionados.
- Monstros, XP, gold, drops e equipamentos necessarios para a progressao.
- Sistema de asa normal: obter e equipar a primeira asa.

### Fora do escopo agora

- Asa heroica.
- Upgrade avancado de asa depois da asa normal.
- Espirito de asa real.
- Protoss / `druid`.
- Domador / `trainer`.
- Sacerdote / `priest`, salvo se virar prioridade depois.
- Nivel 31+.
- Renascimento.
- Cash shop, VIP e passe.
- Eventos temporarios.
- Ranking.
- Familia/guild completa.
- Casamento.
- Mail.
- Loteria.
- Torre, Escada de Cristal e endgame.
- Angel, genie, cloak, artifact, divine, challenge, wardrobe e sistemas de
  colecao/endgame.
- Todas as 2513 missoes e todos os 530 mapas.

## Estado confirmado do universo bruto

Levantamento atual dos recursos decodificados:

- Dispatcher Python: 111 comandos registrados.
- Testes documentados recentes: `python -m unittest discover server_py/tests`
  com 85 testes OK.
- Mapas decodificados: 530 arquivos `m*.json`.
- Mapas com algum indicio de nivel inicial ate 30: 235, mas muitos sao
  eventos, torres ou conteudo legado.
- Missoes em `server_py/game_resources/decoded/itl.json`: 2513.
- Missoes repetiveis/evento: 234.
- Missoes com auto-receive: 448.
- Missoes principais amarradas em `_main_tasks_4990_5020.json`: 27.
- Cadeia principal atual documentada: `4999`, `5000`, `5002-5020`,
  `50020-50025`.
- XP total da cadeia principal atual: 4756.
- Nivel jogavel pela cadeia atual, saindo do nivel 1: aproximadamente nivel 5.
- Skills/configs em `isc.json`: 2235 configs de skill-like.
- Skills por classe principal:
  - `paladin`: 47
  - `elf`: 47
  - `killer`: 47
  - `fairy`: 48
- Buffs em `ibc.json`: 6195.
- Itens em `iix.json`: 3732.
- Pet possui configuracao grande ate nivel 360, mas nao entra como pilar da
  primeira base 1-30.

## O que ja e base real

Estes sistemas devem ser preservados e usados como fundacao:

- Login, lista/criacao/selecao de personagem.
- Entrada no mundo.
- Movimento e troca de mapa.
- NPC basico com menu, scripts, fala, item e teleporte.
- `TaskHandler` com receber, finalizar, abortar, auto-receive e falas.
- Conditions e macros essenciais da chain inicial: `hasDoneTask`,
  `hasDoneTaskAny`, `roleJob=`, `mainBagSpace>=`, `itemsInBag`, `equipItems`,
  `hp%>=`, `boolVar=`, `jobSkPtUsed>=`, `hasKilledMonster`, `receiveItems`,
  `loseItems`, `clearItems`, `setBoolVar` e `clearBoolVar`.
- Inventario, bag sync, mover, dividir, ordenar e usar item.
- Equipar/remover equipamento.
- Compra/venda e lojas basicas.
- Combate PvE basico.
- Ataques basicos oficiais por classe (`xj1` a `xj7`) reconhecidos a partir do
  cliente e de `isc.json`.
- Dano, morte de monstro, XP, gold e drops.
- Contador `killedMonsters.int` alimentado no kill de monstro para objetivos de
  missao como `hasKilledMonster`.
- Reparo, durabilidade, renew item e buy-and-use.
- Primeiro handler de montagem de item via `NPC_ASSEMBLE_ITEM_REQUEST`.

## O que existe, mas precisa recorte

- `NPC_ASSEMBLE_ITEM_REQUEST` (1026): primeira implementacao real adicionada
  para regras de `iar.json`, validando level, materiais, consumo por `ItemId` ou
  codigo e entrega deterministica do item alvo. Para a fase 1-30, usar isso
  apenas para a asa normal.
- `PLAYER_WING_SPIRIT_REQUEST` (12544): handler existe, mas fica fora da base
  1-30 porque espirito de asa e progressao avancada.
- Sistema de asas: existem dados e tabela `TB_RoleWing`, mas a meta agora e
  obter/equipar asa normal, nao criar cadeia heroica.
- Cadeias de missao apos nivel 5: existem muitos dados brutos, mas precisam ser
  selecionadas e amarradas em blocos jogaveis.
- Monstros por mapa: falta consolidar spawns por bloco de progressao.
- Skills por classe: validacao inicial ja usa `isc.json`, mas a arvore completa
  nao deve ser liberada de uma vez.

## Mapas candidatos 1-30

Usar poucos mapas bons, em vez de tentar ativar todos os mapas de nivel baixo.

Prioridade inicial:

- `ma1` - Aldeia Tyria
- `ma4` - Desfiladeiro da Pedra Negra
- `mb1` - Picos de Vento
- `mb3` - Rocha Escarpada
- `mb4` - Vale de Himeng
- `mb5` - Planicies Brilhantes
- `mb6` - Praia Kaspaya
- `mb7` - Montanha Kaymo

Evitar por enquanto:

- `mta*` e `mz10*` de Escada de Cristal.
- Mapas de evento, fortaleza, passe, torre ou conteudo traduzido misturado com
  textos chineses quando nao forem necessarios para a linha 1-30.

## Plano de progressao 1-30

### Nivel 1-10

Objetivo:

- Jogador novo entende movimento, NPC, item, equipamento, pocao, combate e drop.

Tarefas:

- Revisar as missoes atuais da chain 4999-5020.
- Corrigir loops de fala/NPC e objetivos que repetem recompensa. **Base
  concluida em 2026-06-10:** aceitar missao nao reenvia `npcMenuReceive`, e
  concluir missao repetida nao reaplica recompensas.
- Garantir que cada objetivo pode ser concluido em jogo.
- Garantir stack de consumiveis. **Base concluida em 2026-06-10:** `MaxStack`
  do banco e corrigido pelo `stackSize` dos JSONs decodificados quando estiver
  stale, entao pocoes como `dy1000`/`dy0000` empilham.
- Ajustar XP para chegar perto do nivel 10.
- Consolidar spawns e drops dos mapas iniciais.
- Entregar arma/equipamento inicial por missao, loja ou drop.

Entrega esperada:

- Um personagem novo chega ao nivel 10 sem comando manual.

### Nivel 10-20

Objetivo:

- Aumentar a variedade: mais combate, coleta simples, troca de mapa e primeiras
  skills aprendiveis.

Tarefas:

- Selecionar missoes novas em `itl.json`.
- Criar um bloco dedicado, por exemplo `_main_tasks_5021_5040.json`.
- Amarrar auto-receive, conditions, rewards e talks.
- Adicionar monstros/drops exigidos.
- Liberar 2 a 4 skills por classe principal.

Entrega esperada:

- Cadeia principal continua ate nivel 20 com combate, coleta e NPCs.

### Nivel 20-30

Objetivo:

- Fechar a primeira versao jogavel com sensacao de progressao completa.

Tarefas:

- Criar outro bloco de missoes, por exemplo `_main_tasks_5041_5060.json`.
- Introduzir mapas um pouco maiores, mas ainda dentro do recorte inicial.
- Melhorar drops/equipamentos para fechar o nivel 30.
- Liberar mais 2 a 4 skills por classe principal.
- Entregar a asa normal como marco da progressao.

Entrega esperada:

- Jogador chega ao nivel 30 com classe funcional, equipamento basico e asa
  normal.

## Sistema de asa normal

Meta atual:

- O jogador deve conseguir obter uma asa normal e equipa-la.
- Nao implementar asa heroica nesta fase.
- Nao implementar espirito de asa nesta fase.
- Nao implementar cadeia longa de upgrade nesta fase.

Tarefas:

1. Auditar regras `type: "Asas"` nos recursos decodificados.
2. Confirmar a primeira asa normal da cadeia inicial, partindo de `bb0800` se
   essa continuar sendo a regra correta.
3. Usar `NPC_ASSEMBLE_ITEM_REQUEST` para montagem real da asa normal.
4. Validar material, level e espaco de bag.
5. Consumir materiais e entregar item de asa normal.
6. Garantir que equipar a asa atualiza estado/visual o bastante para o cliente.
7. Criar ou ajustar missao de nivel 20-30 que entrega os materiais ou guia o
   jogador ate a asa normal.

Entrega esperada:

- A asa normal vira recompensa de progressao, nao sistema de cash/endgame.

## Skills por classe

Regra:

- Ataque basico nao e skill aprendivel, nao consome ponto e nao depende de
  `learnedSkills`.
- O cliente injeta o ataque padrao por classe via
  `WorldConfig.getDefaultAttackSkillCode(jobCode)`.
- Skills aprendiveis devem vir de `isc.json`, `jobSkill`, respeitando a classe.

Primeiro recorte:

- Cavaleiro: `paladin`, ataque basico `xj1`, skills `z00...`.
- Arqueiro: `elf`, ataque basico `xj2`, skills `z20...`.
- Ladino: `killer`, ataque basico `xj3`, skills `z40...`.
- Mago: `fairy`, ataque basico `xj4`, skills `z60...`.

Nao gastar tempo agora com:

- `trainer` / Domador: ataque `xj6`, skills `za...`.
- `druid` / Protoss: arvore `da...` e comportamentos proprios.
- `priest` / Sacerdote: pode entrar depois, mas nao e essencial para a primeira
  base solo 1-30.

## Regras de decisao

- Se uma tela depende de comando novo, primeiro ler o ActionScript e copiar a
  ordem exata dos campos.
- Se uma regra depende de custo/progressao, procurar nos JSONs decodificados
  antes de inventar.
- Se um sistema nao aparece na progressao 1-30, ele pode esperar.
- Se um sistema ajuda o loop de jogar, upar, ganhar item, equipar e ficar mais
  forte, ele sobe de prioridade.
- Se houver comando funcionando apenas como sucesso fake, marcar como
  "protocolado" ate virar estado real.
- Evitar consertar bugs de classe/sistema que estao fora do recorte atual.

## Proximo bloco recomendado

Ordem recomendada:

1. Fechar a chain 1-10, corrigindo recompensa repetida, dialogo em loop e
   objetivos que nao concluem.
2. Definir os mapas oficiais do recorte 1-30 e remover da rota inicial qualquer
   mapa de evento/endgame.
3. Selecionar skills 1-30 das quatro classes principais.
4. Criar bloco de missoes 10-20.
5. Criar bloco de missoes 20-30.
6. Ligar a asa normal como recompensa/objetivo da faixa 20-30.
7. So depois pensar em pet, sacerdote, asa heroica, upgrade de asa e sistemas
   avancados.
