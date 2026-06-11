# Relatorio geral do servidor Asa de Cristal

Data da auditoria: 2026-06-08

## Resumo executivo

O servidor possui um núcleo jogável parcial: login, personagens, entrada no mundo, movimento, inventário, equipamentos, missões básicas e uma primeira versão do combate PvE. Ainda não é um servidor completo, mas várias melhorias recentes foram aplicadas, incluindo a atualização de assets visuais (IDs 35 e 4866) e a limpeza de arquivos redundantes.

O cliente ActionScript define 822 comandos. O registro atual possui 55 handlers ativos (alguns são simulações). Alguns handlers registrados são apenas simulações e não implementam a operação real.

## Implementado e funcional ou parcialmente funcional

### Infraestrutura

- Servidores HTTP, login, world e policy.
- Login em modo debug e persistencia SQL/SQLite.
- Criação, seleção e exclusão de personagem.
- Entrada no mundo, mapas, movimento e teleporte básico.
- Serialização do protocolo binário e objetos transportáveis.
- Carregamento dos recursos originais decodificados.

### Personagem e progressão

- Atributos básicos do personagem.
- Distribuição de pontos de atributo.
- Experiência, level up e renascimento básico.
- Aprendizado básico de skills.
- Ataques basicos oficiais por classe (`xj1` a `xj7`) reconhecidos como implicitos pelo servidor.
- Chat básico.
- Sentar e montaria básico.

### Inventario e equipamentos

- Visualização e sincronização da mochila.
- Adicionar, mover, dividir, descartar e ordenar itens.
- Equipar, trocar e remover equipamentos.
- Atualização visual de equipamentos.
- Cálculo de atributos de armas e armaduras.
- Leitura das definições originais no `iie.json`.

### Missoes e NPCs

- Aceitar, finalizar e abandonar missões.
- Recompensas simples de ouro, experiência, honra e itens.
- Dialogos simples, entrega de itens e teleporte por macro de NPC.

### Combate

- Ataque do jogador contra monstros.
- Dano básico mesmo quando o ataque padrao da classe (`xj1` a `xj7`) ou fallback legado nao possui configuração carregada.
- HP, morte, experiência, ouro e drops de monstros.
- Aggro e retaliação de monstros.
- Ataque de monstros usando `physicalAttack` ou `magicAttack`.
- Cooldown básico de ataques de monstros.
- Primeira implementação de buffs, traps, AoE, cura e PvP.

## Correções realizadas nesta sessão

- Ataque básico do jogador deixou de causar dano zero.
- Monstros passaram a usar os atributos reais `physicalAttack`/`magicAttack`.
- Corrigida a localização da sessão alvo durante ataques de monstros.
- Atacar o monstro não reinicia mais o cooldown de ataque dele.
- Corrigido cooldown de ataque dos monstros.
- `basic` deixou de consumir ponto de habilidade.
- `xj1..xj7` deixaram de ser tratados como skills especiais aprendiveis; seguem a regra AS de ataque padrao por `jobCode`.
- Equipamentos passaram a ler `baseAttr` e `extAttr`.
- O carregador de itens passou a usar `server_py/game_resources/decoded/iie.json`.
- Corrigida falha no console Windows que apagava o cache dos 12.074 itens.
- Equipar e remover itens agora recalcula os atributos usando os dados originais.
- Assets visuais dos personagens IDs 35 e 4866 substituídos por novas imagens (35.png e 4866.png) no SWF servido.
- Limpeza de arquivos redundantes: SWFs de backup, PNGs soltos, pastas de verificação, logs antigos, arquivos de texto decodificados, pastas de mídia SQL, executáveis Flash Player, dump SQL e scripts obsoletos movidos para diretórios de backup.

## Erros criticos atuais

### 1. Compra e venda em NPCs esta quebrada ou instável

O `ShopHandler` existe, mas possui problemas importantes:

- Busca preço somente em `TB_ItemDefinition`; muitos dados reais estão apenas no `iie.json`.
- `_allowed_items_for_npc()` depende de índices exatos do menu e não trata o índice inicial `-1` como o `NpcHandler`.
- Se a navegação do menu falhar, retorna conjunto vazio e responde `Loja inválida`.
- Venda usa `JOIN TB_ItemDefinition`, portanto itens ausentes nessa tabela nunca podem ser vendidos.
- Não existem testes automatizados de compra, venda ou loja premium.

Resultado esperado atualmente: comprar de vários NPCs pode falhar mesmo quando o item é exibido pelo cliente.

### 2. Cobertura muito baixa do protocolo

- Cliente: 822 comandos definidos.
- Servidor: 55 handlers ativos no registro atual.
- Grande parte das telas envia comandos sem handler e fica travada, vazia ou sem resposta.
- Isso pode explicar janelas que não fecham, botões sem efeito e telas incompletas.

### 3. Handlers duplicados sobrescrevem outros handlers

O registro atual possui conflitos:

- Comando `50`: `WorldHandler` sobrescrito por `ShortcutHandler`.
- Comando `5127`: `InventoryHandler` sobrescrito por `LootManager`.
- Comando `690`: `PlayerHandler` sobrescrito por `AttributeHandler`.

Esses conflitos podem descartar comportamento necessário silenciosamente.

### 4. Sistema de pets e majoritariamente falso

Embora vários comandos estejam registrados, os handlers de pet possuem muitos `TODO`s e respondem sucesso sem executar a ação real:

- Renomear não persiste.
- Aprender/esquecer skill não altera o pet.
- Pontos de atributo não são aplicados.
- Melhorar pet não consome materiais.
- Equipamento de pet não funciona.
- Decomposição não remove o pet.
- Combate e IA de pet não funcionam.

### 5. Testes gerais não passam de forma limpa

O comando de descoberta executou 45 testes funcionais, mas terminou com dois erros de importação:

- `test_buff_runtime.py` não encontra `gameplay`.
- `test_combat_audit.py` não encontra `tools.audit_combat_completion`.

Isso indica configuração inconsistente de imports/PYTHONPATH.

## Sistemas quebrados ou ausentes

### Prioridade alta

- Compra e venda em NPC.
- Loja premium, VIP, reward shop e var shop.
- Fechamento e estado correto de algumas janelas do personagem.
- Validação completa de pacotes de inventário/equipamento no cliente.
- Skills completas por classe, requisitos e custos reais. A validacao inicial ja usa `isc.json` e o ataque padrao `xj1..xj7`, mas a arvore completa ainda precisa de teste jogavel por classe.
- IA, skills e movimento de monstros completos.
- Persistência consistente de todos os atributos calculados.
- Validação em jogo dos pacotes de morte, renascimento e drops.

### Prioridade média

- Equipes: implementação apenas em memória, incompleta e frágil.
- Amigos: ausente.
- Correio: ausente.
- Trade entre jogadores: ausente.
- Booth/loja de jogador: ausente.
- Familia/guild: ausente.
- Pets: quase todo ausente.
- Farm, artifact, reward, constellation e incubator: ausentes.
- Reparo, reforço, gema, refinamento e crescimento de equipamento: ausentes.

### Prioridade baixa ou conteúdo avançado

- Baby, angel, genie, cloak, tower, lottery, ranking e sistemas de eventos.
- Sistemas de endgame e minigames.
- Ferramentas GM completas.

## Riscos de integridade e segurança

- Alguns handlers de pet retornam sucesso sem validar propriedade ou recursos.
- Várias operações confiam excessivamente nos dados enviados pelo cliente.
- Nem todos os fluxos usam transação no banco.
- Alguns erros são capturados e ignorados, deixando cliente e servidor dessincronizados.
- Existem logs e strings com codificação quebrada.
- Historico antigo: foi citado que o projeto nao possuia repositorio Git nesta pasta. Estado atual em 2026-06-09: existe `.git` na raiz, ainda sem commit inicial.

## Plano recomendado

### P0 - Tornar o núcleo jogável confiável

1. Corrigir compra/venda em NPC usando `iie.json` como fallback.
2. Remover conflitos de comandos no registro de handlers.
3. Criar testes de integração para loja, inventário e equipamentos.
4. Capturar logs dos comandos sem handler ao abrir/fechar cada janela principal.
5. Validar PvE completo em jogo: ataque, retaliação, morte, drop e respawn.

### P1 - Completar progressão principal

1. Validar todas as habilidades iniciais de cada classe.
2. Completar cadeia principal de missões e macros usados por ela.
3. Implementar reparo, aprimoramento e atributos extras de equipamentos.
4. Completar equipes, pets básicos, amigos, trade e correio.

### P2 - Sistemas avançados

1. Familia/guild e lojas de jogadores.
2. Farm, artifact, reward e eventos.
3. Conteúdo de endgame e sistemas secundários.

## Estado atual dos testes

- Testes específicos de combate e equipamentos: 12 passando.
- Descoberta geral: 45 testes executados, com 2 erros de importação.
- Não existem testes adequados para loja/NPC, pets, equipe e grande parte das telas.

## Atualizacao 2026-06-09

Este relatorio estava desatualizado. Estado atual confirmado:

- Dispatcher atual: 109 comandos registrados.
- Testes atuais: `python -m unittest discover server_py/tests` passa com 85 testes.
- PostgreSQL principal `mspt1` validado em runtime.
- Shop compra/venda usa fallback de recursos e possui testes.
- Pet system possui operacoes reais para view, rename, skills, atributos, action mode e upgrades.
- Reparo/durabilidade, renew item e buy-and-use foram implementados com estado.
- Agent market, booth, armory, wardrobe, artifact e kindGrow foram implementados com tabelas persistentes.
- Migration PostgreSQL: `server_py/tools/sql/postgres_advanced_item_systems.sql`.
- Recursos: `GameResourceService` adicionado para cache lazy por dominio e `audit_resource_domains.py` adicionado para mapear configs decodificadas.
- **NOVO**: Drop groups hardcodeados no `LootManager` (`bw0200`, `ab0000`, `bb1000`).
- **NOVO**: Spawn `b0100` (Senhor Golem lv10) no mapa a4 já existe nos dados (`ma4.json`).
- **NOVO**: `loot_manager.py` corrigido (duplicação removida, `@classmethod` adicionado em `get_handlers`).
- **NOVO**: Handler `NPC_ASSEMBLE_ITEM_REQUEST` (1026) / `NPC_ASSEMBLE_ITEM_ANSWER` (1027) em `NpcHandler` para montagem de itens (wing/pet/ride/armory via `assembleRuleIndex`).
- **NOVO**: Handler `PLAYER_WING_SPIRIT_REQUEST` (12544) / `PLAYER_WING_SPIRIT_ANSWER` (12545) em `WingSpiritHandler` para espírito das asas (`equipmentId`, `spiritType`, `doType`).
- **NOVO**: Quest chain 4999-5020 implementada no `TaskHandler` com suporte a `_main_tasks_4990_5020.json`, `npcMenuReceive`, `npcMenuFinish`, `clientMacro`, auto-receive e conditions.
- **NOVO**: Combate/skills atualizados com aprendizado do AS: `WorldConfig.as` define ataques padrao `xj1..xj7`, `PlayerSkillManager` injeta esse ataque como nivel 1, e o servidor agora usa `ResourceIndex.is_basic_attack()`/`basic_attack_for_job_code()` para aceitar esses ataques sem ponto de skill.

As secoes antigas acima ficam como historico quando contradisserem este bloco.
## Atualizacao 2026-06-11

Verificacao feita sobre o que a outra IA alegou ter alterado:

- Confirmado: `TaskHandler._apply_task_effects()` envia `npcMenuFinish` tambem
  na conclusao da missao, usando `_send_show_talks()` para filtrar
  `speaker: "i"` e enviar `PLAYER_SHOW_TALKS_NOTIFY` (`676`).
- Confirmado: `TaskHandler._execute_client_macro()` trata
  `showWelcome <npc_id>` e envia `NPC_FUNCTION_ANSWER` (`1029`) com um payload
  simples.
- Confirmado: `WorldSession.handle_enter_world()` chama
  `_trigger_auto_receive_quests()` em `server_py/servers/world_server.py` apos
  os pacotes iniciais de entrada no mundo.
- Confirmado: `_main_tasks_4990_5020.json` contem a chain `4999-5020` com 21
  missoes auto-recebiveis, mas nao contem `5024`.
- Risco atual: `5007` depende de `hasDoneTask: [5024]`; enquanto `5024` nao
  existir ou essa dependencia nao for ajustada, a progressao automatica pode
  parar antes da `5007`.
- Validacao pendente: testar no Flash se `showWelcome` realmente abre a janela
  esperada; se nao abrir, as falas ainda podem aparecer pelo notify `676`.
