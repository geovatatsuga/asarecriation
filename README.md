# Asa de Cristal - Servidor Privado

Uma implementação em Python de servidor privado para o MMORPG em Flash "Asa de Cristal".

## Visão Geral

Este servidor emula os servidores de jogo do MMORPG em Flash "Asa de Cristal". Ele é composto por múltiplos servidores interconectados que gerenciam diferentes aspectos do jogo:

- **Servidor HTTP** (porta 8081): Fornece os recursos do jogo (arquivos SWF, XML, HTML) com cabeçalhos CORS compatíveis com Flash.
- **Servidor de Login** (porta 9999): Gerencia a autenticação dos jogadores e a seleção do servidor.
- **Servidor do Mundo (World)** (porta 8888): Servidor principal do jogo que processa toda a lógica da gameplay.
- **Servidor de Diretrizes (Policy)** (porta 843): Fornece o arquivo XML de política de domínio cruzado (cross-domain) exigido pelo Flash.
- **Servidor SQL** (opcional): Banco de dados para persistência dos dados dos jogadores.

## Recursos

- Arquitetura modular com componentes de servidor separados.
- Protocolo binário customizado com codificação VarInt.
- Sistema extensível de manipuladores (handlers) para processamento de pacotes.
- Suporte para modo de depuração (aceita qualquer credencial) e modo de banco de dados.
- Sistemas completos de inventário, equipamentos e itens.
- Sistema de teletransporte em mapas com entradas e saídas configuráveis.
- Criação, exclusão e seleção de personagens (roles).
- Sistemas de movimento, combate, habilidades (skills) e chat.
- Compra e venda com NPCs mercadores.
- Logs detalhados com saída colorida no console.
- Registro de pacotes (packet logging) para depuração e análise.

## Estrutura do Diretório Principal e do Servidor

```
.
├── 1_GUIA_FERRAMENTAS_FLASH.md          # Guia prático de descompilação e edição do cliente Flash
├── 2_INFORMACOES_GERAIS.md              # Visão geral do projeto e especificações técnicas
├── 3_ANALISE_COMPLETA_REPOSITORIO.md    # Detalhamento de arquivos do cliente e servidor
├── README.md                            # Este arquivo explicativo do repositório
├── _referencias/                        # Pasta consolidada com arquivos do cliente original e patched
└── server_py/                           # Implementação do servidor em Python
    ├── main.py                          # Ponto de entrada - inicia todos os servidores
    ├── config.py                        # Configuração centralizada (portas, caminhos, modo de auth)
    ├── DOCUMENTACAO_SERVIDOR.md         # Documentação técnica detalhada das mensagens e comandos
    ├── inventory_manager.py             # Operações do sistema de inventário
    ├── player_data_manager.py           # Carregamento e salvamento de dados dos jogadores
    ├── item_config_loader.py            # Carrega definições de itens a partir do iie.txt
    ├── servers/                         # Implementação de cada servidor TCP/HTTP
    │   ├── base_server.py               # Classe base do servidor TCP com suporte a threads
    │   ├── http_server.py               # Servidor HTTP para entrega de arquivos do jogo
    │   ├── login_server.py              # Servidor de autenticação e login
    │   ├── policy_server.py             # Servidor de diretrizes de segurança do Flash
    │   └── world_server.py              # Servidor principal do mundo de jogo
    ├── handlers/                        # Manipuladores de pacotes modulares
    │   ├── base_handler.py              # Classe base para todos os handlers
    │   ├── registry.py                  # Registro central de handlers e sistema de despacho
    │   ├── world_handler.py             # Login no mundo, pings e configurações
    │   ├── role_handler.py              # Operações de CRUD de personagens
    │   ├── movement_handler.py          # Movimentação e transição de mapas
    │   ├── inventory_handler.py         # Gerenciamento de bag e uso de itens
    │   └── shop_handler.py              # Operações de compra e venda de lojas
    ├── protocol/                        # Implementação do protocolo de rede
    │   ├── commands.py                  # Definições de códigos de comando (enums)
    │   ├── packet_reader.py             # Desserialização de pacotes (VarInt, strings, etc.)
    │   └── packet_builder.py            # Serialização de pacotes com cabeçalhos
    ├── game_data/                       # Dados estáticos e configurações do jogo
    │   └── map_teleport_config.py       # Definições de saídas e entradas de mapas
    ├── game_resources/                  # Arquivos estáticos entregues pelo servidor HTTP
    ├── tools/                           # Ferramentas de desenvolvimento e depuração
    │   ├── packet_proxy.py              # Proxy TCP para interceptação e análise de pacotes
    │   └── sql/                         # Scripts de banco de dados SQL Server
    └── logs/                            # Logs de pacotes em formato JSON
```

## Como Começar

### Pré-requisitos

- Python 3.8+
- (Opcional) `pyodbc` para suporte a banco de dados SQL Server
- (Opcional) Instância do SQL Server configurada para armazenamento persistente

### Executando o Servidor

1. Abra o console/terminal do seu sistema.
2. Navegue até o diretório do servidor:
   ```bash
   cd server_py
   ```
3. Inicie o servidor:
   ```bash
   python main.py
   ```
4. Para depurar o tráfego de pacotes entre o cliente e o servidor através do proxy:
   ```bash
   START_DEBUG_PROXY.bat
   ```

### Configuração

Edite o arquivo `config.py` dentro da pasta `server_py` para ajustar os seguintes parâmetros:
- `HOST`: Endereço de escuta do servidor (padrão: `0.0.0.0`)
- `HTTP_PORT`: Porta do servidor HTTP (padrão: `8081`)
- `LOGIN_PORT`: Porta do servidor de Login (padrão: `9999`)
- `WORLD_PORT`: Porta do servidor do Mundo (padrão: `8888`, pode ser sobrescrita pela variável de ambiente `WORLD_PORT`)
- `POLICY_PORT`: Porta do servidor de política do Flash (padrão: `843`)
- `AUTH_MODE`: Modo de autenticação (`'debug'` ou `'db'`)
- `GAME_RESOURCES_DIR`: Caminho para a pasta contendo os recursos estáticos do jogo.

## Modos de Autenticação

### Modo de Depuração (`AUTH_MODE = 'debug'`)
- Aceita qualquer combinação de usuário e senha.
- Cria automaticamente contas e personagens novos no primeiro acesso.
- Perfeito para testes locais rápidos e desenvolvimento.

### Modo Banco de Dados (`AUTH_MODE = 'db'`)
- Valida as credenciais comparando-as com uma tabela em banco de dados SQL Server.
- Requisitos:
  - Pacote `pyodbc` instalado (`pip install pyodbc`).
  - Instância do SQL Server ativa e configurada com a estrutura de tabelas correta (veja a pasta `tools/sql/`).
- Configure a string de conexão no arquivo `database.py` ou via variáveis de ambiente.

## Detalhes do Protocolo de Rede

O jogo utiliza um formato binário proprietário estruturado da seguinte forma:

```
Estrutura do Pacote:
┌──────────────┬─────────┬────────┬──────────┐
│ Tam. VarInt  │ Comando │ Digest │ Payload  │
│ (1 a 5 bytes)│ (2B-shrt)│ (2 bytes)│ (N bytes)│
└──────────────┴─────────┴────────┴──────────┘

- Tamanho: Inteiro codificado em VarInt representando a soma dos bytes de Comando + Digest + Payload.
- Comando: Código de 2 bytes (Unsigned Short, Big Endian).
- Digest: Checksum de verificação de integridade de 2 bytes (geralmente zero).
- Payload: O conteúdo contendo os parâmetros específicos do comando.

Tipos de Dados Usados:
- byte: Inteiro de 8 bits com sinal.
- ubyte: Inteiro de 8 bits sem sinal.
- short: Inteiro de 16 bits com sinal (Big Endian).
- ushort: Inteiro de 16 bits sem sinal (Big Endian).
- int: Inteiro de 32 bits com sinal (Big Endian).
- uint: Inteiro de 32 bits sem sinal (Big Endian).
- long: Inteiro de 64 bits com sinal (Big Endian).
- float: Ponto flutuante de 32 bits padrão IEEE 754 (Big Endian).
- double: Ponto flutuante de 64 bits padrão IEEE 754 (Big Endian).
- varint: Inteiro de tamanho dinâmico (7 bits por byte, o MSB indica continuação).
- string: Tamanho VarInt seguido pelos caracteres em UTF-8.
- bool: Booleano de 1 byte (0 = falso, qualquer outro valor = verdadeiro).
```

## Sistema de Mapas

As transições de mapa são mapeadas e configuradas em `game_data/map_teleport_config.py`:

```python
MAP_EXITS = {
    ('mapa_origem', 'id_saida'): ('mapa_destino', 'id_entrada'),
}

MAP_ENTRIES = {
    ('mapa_destino', 'id_entrada'): (coordenada_x, coordenada_y),
}
```

Fluxo de teletransporte:
1. O cliente envia uma mensagem do tipo `PlayerEnterMapReq` com os campos `fromMapId` e `exitId`.
2. O servidor localiza os dados no dicionário `MAP_EXITS`.
3. O servidor obtém a coordenada de destino correspondente no dicionário `MAP_ENTRIES`.
4. O servidor responde com o comando `PlayerEnterMapAnswer`, que carrega o novo mapa e posiciona o jogador.

## Logs do Console

Os logs no terminal usam cores e prefixos claros para facilitar a identificação da origem dos dados:
- `[HTTP]`: Azul - Requisições web de recursos de jogo.
- `[LOGIN]`: Verde - Autenticação e tráfego de login.
- `[WORLD]`: Magenta - Lógica do mundo, combates, posições, monstros.
- `[POLICY]`: Amarelo - Requisição de sandbox do Flash Player.
- `[DB]`: Ciano - Operações de gravação/leitura no banco de dados.

## Créditos e Licença

Esta implementação de servidor foi criada a partir de engenharia reversa do jogo original **Asa de Cristal**. Todos os direitos intelectuais, imagens, marcas, trilha sonora e códigos do cliente Flash pertencem aos seus respectivos criadores e empresas publicadoras originais.

Este código é disponibilizado estritamente para fins de preservação digital, estudo e uso pessoal.
## Estado Atual 2026-06-09

Algumas secoes acima ainda preservam texto historico sobre SQL Server. O runtime atual validado usa:

- PostgreSQL principal `mspt1` em `localhost:5432`.
- SQLite persistente como fallback local.
- Migration PostgreSQL: `server_py/tools/sql/postgres_advanced_item_systems.sql`.
- Dispatcher com 109 comandos registrados.
- Testes: `python -m unittest discover server_py/tests` passa com 85 testes.

Sistemas implementados atualmente:

- Inventario, equipamento, durabilidade e reparo.
- Compra e venda, lojas especiais, buy-and-use e renew item.
- Pet system (5378-5431): view, rename, skills, attrs, action mode, enhance, fusion, remove equip, decompose.
- Agent market, booth/player shop, armory, wardrobe, artifact e equip kindGrow.
- **NOVO**: `_send_player_view_map_answer` e `_auto_send_map_data` implementados em `WorldSession`.
- **NOVO**: Auditoria completa de recursos decodificados realizada (`audit_resource_domains.py`).
- **NOVO**: Drop groups hardcodeados no `LootManager` (`bw0200`, `ab0000`, `bb1000`).
- **NOVO**: Spawn `b0100` (Senhor Golem lv10) no mapa a4 já existe nos dados.
- **NOVO**: `loot_manager.py` corrigido (duplicação removida, `@classmethod` adicionado).
- **NOVO**: Handler `NPC_ASSEMBLE_ITEM_REQUEST` (1026) / `NPC_ASSEMBLE_ITEM_ANSWER` (1027) em `NpcHandler` para montagem de itens (wing/pet/ride/armory via `assembleRuleIndex`).
- **NOVO**: Handler `PLAYER_WING_SPIRIT_REQUEST` (12544) / `PLAYER_WING_SPIRIT_ANSWER` (12545) em `WingSpiritHandler` para espírito das asas (`equipmentId`, `spiritType`, `doType`).
- **NOVO**: Quest chain 4999-5020 implementada no `TaskHandler` com suporte a `_main_tasks_4990_5020.json`, `npcMenuReceive`, `npcMenuFinish`, `clientMacro`, auto-receive e conditions.
- **NOVO**: Ataques basicos por classe corrigidos conforme o cliente Flash: `WorldConfig.getDefaultAttackSkillCode(jobCode)` usa `xj1..xj7`, e o servidor trata esses codigos como ataque basico implicito, sem exigir aprendizado nem consumir ponto.

Recursos do cliente:

- `server_py/gameplay/resource_index.py` continua focado em skills, buffs e job skills usados por combate/aprendizado; tambem indexa ataques basicos por classe (`xj1..xj7`) a partir de `isc.json`.
- `server_py/gameplay/game_resource_service.py` foi adicionado como acesso lazy por dominio aos recursos decodificados.
- Catalogos lazy atuais: `isc.json`, `ibc.json`, `iie.json`, `iix.json`, `isp.json`, `itl.json`, `iss.json`, `iem.json` e `irm.json`.
- Auditoria de recursos: `python server_py/tools/audit_resource_domains.py --max-examples 6`.

### Itens recém concluídos

1. **Handler NPC_ASSEMBLE_ITEM (1026)**: implementado em `NpcHandler` para wing/pet/ride/armory via `assembleRuleIndex`.
2. **Handler WING_SPIRIT (12544/12545)**: implementado em `WingSpiritHandler` com `equipmentId`, `spiritType`, `doType`.
3. **Quest chain 4999-5020**: implementada no `TaskHandler` lendo `_main_tasks_4990_5020.json` via `GameResourceService`.
## Atualizacao 2026-06-11

Estado verificado da chain inicial apos alteracoes feitas por outra IA:

- `server_py/handlers/task_handler.py` envia `npcMenuFinish` ao concluir missao,
  filtrando falas `speaker: "i"` antes do `PLAYER_SHOW_TALKS_NOTIFY` (`676`).
- `TaskHandler._execute_client_macro()` implementa suporte basico a
  `showWelcome <npc_id>` e tenta abrir o menu enviando `NPC_FUNCTION_ANSWER`
  (`1029`).
- `server_py/servers/world_server.py` chama `_trigger_auto_receive_quests()`
  depois do pacote `PlayerEnterWorldAnswer` (`514`) e dos pacotes iniciais de
  mapa, acionando `TaskHandler._auto_receive_available_tasks()`.
- `_main_tasks_4990_5020.json` possui 21 missoes (`4999`, `5000`,
  `5002`..`5020`) com `autoReceive`, e macros `showWelcome` confirmadas nas
  missoes `4999`, `5008` e `5020`.
- Atencao: a missao `5007` ainda exige `hasDoneTask: [5024]`, mas a missao
  `5024` nao existe nesse JSON. Isso pode travar a chain antes da `5007`.
- Ainda falta validacao no cliente Flash para confirmar se o pacote simplificado
  de `showWelcome` abre a janela correta.
