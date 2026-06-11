# Asa de Cristal - Documentação do Servidor

## Visão Geral

Implementação de servidor privado para o MMORPG em Flash "Asa de Cristal", escrito em Python.

---

## Arquitetura de Rede

```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│  Servidor HTTP  │     │Servidor de Login│     │Servidor do Mundo│
│  (porta 8081)   │     │   (porta 9999)   │     │   (porta 8888)   │
└────────┬────────┘     └────────┬────────┘     └────────┬────────┘
         │                       │                       │
         │              ┌────────┴────────┐              │
         │              │Servidor Policy  │              │
         │              │   (porta 843)    │              │
         │              └─────────────────┘              │
         │                                               │
         └───────────────────┬───────────────────────────┘
                             │
                    ┌────────▼────────┐
                    │Servidor SQL Server│
                    │ (Banco de Dados)│
                    └─────────────────┘
```

---

## Estrutura do Diretório `server_py/`

```
server_py/
├── main.py                    # Ponto de entrada - inicia todos os servidores
├── config.py                  # Configuração centralizada (portas, caminhos, modo auth)
├── inventory_manager.py       # Operações do inventário (adicionar, mover, equipar itens)
├── player_data_manager.py     # Carregamento/salvamento de dados no banco ou arquivo
├── item_config_loader.py      # Carrega definições de itens do arquivo iie.txt
│
├── servers/                   # Implementação dos servidores de rede
│   ├── __init__.py
│   ├── base_server.py         # Classe base de servidor TCP multithread
│   ├── http_server.py         # Servidor HTTP para recursos do jogo (SWF, XML)
│   ├── login_server.py        # Servidor de autenticação e geração de tickets
│   ├── policy_server.py       # Servidor Flash de diretriz de segurança socket
│   └── world_server.py        # Servidor principal do mundo de jogo
│
├── handlers/                  # Manipuladores modulares de pacotes
│   ├── __init__.py
│   ├── base_handler.py        # Classe base para todos os handlers
│   ├── registry.py            # Registro central e despacho de pacotes
│   ├── world_handler.py       # Login do mundo, ping, config (5 comandos)
│   ├── role_handler.py        # Operações CRUD de personagens (5 comandos)
│   ├── movement_handler.py    # Movimentação e portais de mapas (2 comandos)
│   ├── inventory_handler.py   # Gerenciamento de mochila e itens (7 comandos)
│   └── shop_handler.py        # Compras e vendas com NPCs (3 comandos)
│
├── protocol/                  # Protocolo de rede binário
│   ├── __init__.py
│   ├── commands.py            # Enums dos códigos de comandos e pacotes
│   ├── packet_reader.py       # Desserialização de pacotes binários
│   └── packet_builder.py      # Serialização e criação de pacotes com cabeçalhos
│
├── game_data/                 # Configurações estáticas de dados do jogo
│   ├── __init__.py
│   └── map_teleport_config.py # Configurações de saídas e entradas de mapas
│
├── game_resources/            # Arquivos estáticos entregues pelo HTTP
│   ├── index.html             # Página web do launcher
│   ├── crossdomain.xml        # Liberação de CORS do Flash Player
│   ├── WebLaucher.swf         # Inicializador Flash
│   ├── bin/                   # Arquivos compilados do jogo
│   ├── LoadingBG/             # Fundos de telas de carregamento
│   └── res/                   # Assets do jogo (nomes baseados em hash)
│
├── tools/                     # Utilitários e ferramentas auxiliares
│   ├── packet_proxy.py        # Proxy TCP para capturar e ler pacotes
│   └── sql/                   # Scripts de tabelas SQL
│
└── logs/                      # Pasta contendo logs de pacotes capturados (JSON)
```

---

## Detalhamento dos Componentes de Servidor

### Servidor HTTP (porta 8081)

Distribui arquivos estáticos de imagem, código e interface do jogo utilizando cabeçalhos HTTP CORS amigáveis ao plugin do Adobe Flash Player.

| Rota | Descrição |
|------|-----------|
| `/` | Inicializador web do jogo (index.html) |
| `/crossdomain.xml` | Liberação de permissões de soquete e sandbox do Flash |
| `/bin/*` | Arquivos SWF binários do cliente de jogo |
| `/res/*` | Assets, imagens, texturas e sons do jogo |

Observacoes de asset/launcher:

- Abrir `index.html` injeta `bin=bin/game.bin` no `WebLaucher.swf`.
- Abrir `WebLaucher.swf` direto pelo Flash Debugger usa `/res/data1`; esse arquivo e um ponteiro criptografado/compactado e deve apontar para o SWF correto.
- `server_py/servers/http_server.py` e `server_py/start_all.py` tratam `/res/data1`, `/res/data2` e o hash legado `16ceadfbd18d8d9042567d31415807c6` como bootstrap sem cache imutavel.
- Durante desenvolvimento local, `.swf` e `.bin` tambem sao servidos com `no-store/no-cache` para o Flash Player nao reutilizar `game.swf` antigo quando a URL nao muda. Requests limpos de `/game.swf` e `/bin/game.bin` redirecionam para `?v=<mtime_ns_do_arquivo>` automaticamente.
- Para telas novas em `1000x600`, mantenha os PNGs nessa resolucao e ajuste o header/displayrect do SWF para `1000x600`; nao redimensione telas compostas para `500x375` sem inspecionar o simbolo.

### Servidor de Login (porta 9999)

Fase de autenticação e seleção de personagens inicial.

| Nome do Comando | Código ID | Direção | Descrição |
|-----------------|-----------|---------|-----------|
| WelcomeNotify | 16 | S→C | Envia a chave da sessão ao conectar |
| LoginRequest | 17 | C→S | Envio do nome de usuário e hash de senha |
| LoginAnswer | 18 | S→C | Retorno de status de login (Sucesso/Erro) + Ticket |
| ServerListRequest | 23 | C→S | Requisita a lista de servidores disponíveis |
| ServerListAnswer | 24 | S→C | Retorna a lista de servidores ativos e status de carga |

### Servidor do Mundo (World - porta 8888)

Gerencia e mantém a sessão ativa dos jogadores no mapa de jogo.

**Comandos Gerais do Mundo:**
| Nome do Comando | Código ID | Descrição |
|-----------------|-----------|-----------|
| WorldLoginReq | 33 | Entrar no mundo fornecendo o Ticket obtido no Login |
| WorldLoginAnswer | 34 | Status do resultado da validação do Ticket de entrada |
| WorldPingEcho | 49 | Sinalização de keep-alive periódica para manter conexão |
| ClientSaveConfigNotify | 50 | Salva configurações personalizadas do usuário |

**Comandos de Personagem / Role (257-276):**
| Nome do Comando | Código ID | Descrição |
|-----------------|-----------|-----------|
| RoleListReq | 257 | Busca a lista de personagens criados na conta |
| RoleNameConfirmReq | 259 | Valida se um nome de personagem está livre para uso |
| CreateRoleReq | 261 | Criação de um novo personagem no servidor |
| DeleteRoleReq | 263 | Exclusão de um personagem |
| SelectRoleReq | 265 | Escolhe o personagem para iniciar a gameplay |

**Comandos do Jogador (513-676):**
| Nome do Comando | Código ID | Descrição |
|-----------------|-----------|-----------|
| PlayerEnterWorldReq | 513 | Solicita entrada física e spawn no mundo do jogo |
| PlayerEnterMapReq | 517 | Transição de mapa por portais |
| PlayerMoveReq | 519 | Movimentação baseada em caminho/coordenadas |
| PositionCheckNotify | 520 | Sincroniza a posição exata do jogador com o servidor |
| UseSkillReq | 545 | Uso de habilidades ou ataques fisicos/magicos; ataque padrao por classe usa `xj1..xj7` |
| SendMsgRequest | 673 | Envio de mensagens no chat |

**Comandos de Mochila / Bag (5121-5141):**
| Nome do Comando | Código ID | Descrição |
|-----------------|-----------|-----------|
| BagCheckNotify | 5121 | Sincroniza os itens da mochila com o cliente |
| UseItemReq | 5124 | Usa consumíveis ou equipa itens da bag |
| MoveItemReq | 5125 | Move itens de posição ou entre diferentes mochilas |
| DropItemReq | 5127 | Descarta um item no chão |
| ViewItemReq | 5133 | Solicita detalhes extras de atributos de um item |
| BagSortReq | 5141 | Ordenação automática da mochila |

**Comandos de Equipamentos:**
| Nome do Comando | Código ID | Descrição |
|-----------------|-----------|-----------|
| EquipmentCheckNotify | 4609 | Sincroniza os equipamentos atuais no corpo do personagem |
| RemoveEquipmentReq | 4610 | Retira um equipamento do personagem e devolve à mochila |

**Comandos de Loja / Shop (2817-2821):**
| Nome do Comando | Código ID | Descrição |
|-----------------|-----------|-----------|
| ShopSellItemReq | 2817 | Vende um item da mochila para a loja do NPC |
| ShopBuyItemReq | 2818 | Compra um item do NPC usando ouro |
| StoreBuyItemReq | 2819 | Compra um item da loja de cash utilizando cristais |

### Servidor Policy (porta 843)

Envia o arquivo XML autorizando o cliente Flash a trafegar soquetes TCP na porta configurada.

---

## Especificações Técnicas do Protocolo

### Estrutura Base dos Pacotes

```
┌──────────────┬─────────┬────────┬──────────┐
│ Tam. VarInt  │ Comando │ Digest │ Payload  │
│ (1 a 5 bytes)│ (2 bytes)│(2 bytes)│ (N bytes)│
└──────────────┴─────────┴────────┴──────────┘
```

- **Tamanho**: Inteiro dinâmico VarInt englobando a contagem de bytes dos campos Comando + Digest + Payload.
- **Comando**: Código de pacote em 2 bytes (Unsigned Short, Big Endian).
- **Digest**: Assinatura checksum de integridade de 2 bytes (geralmente enviada como 0).
- **Payload**: Conjunto de dados contínuo lido e gravado sequencialmente.

### Tipos de Dados Suportados

| Tipo | Tamanho (Bytes) | Descrição |
|------|-----------------|-----------|
| byte | 1 | Inteiro de 8 bits com sinal (-128 a 127) |
| ubyte | 1 | Inteiro de 8 bits sem sinal (0 a 255) |
| short | 2 | Inteiro de 16 bits com sinal (Big Endian) |
| ushort | 2 | Inteiro de 16 bits sem sinal (Big Endian) |
| int | 4 | Inteiro de 32 bits com sinal (Big Endian) |
| uint | 4 | Inteiro de 32 bits sem sinal (Big Endian) |
| long | 8 | Inteiro de 64 bits com sinal (Big Endian) |
| float | 4 | Ponto flutuante IEEE 754 de 32 bits (Big Endian) |
| double | 8 | Ponto flutuante IEEE 754 de 64 bits (Big Endian) |
| varint | 1 a 5 | Inteiro comprimido de tamanho variável |
| string | N | Cadeia de caracteres UTF-8 precedida por seu tamanho em VarInt |
| bool | 1 | Representação lógica (0 = falso, diferente de 0 = verdadeiro) |

### Objetos Transportáveis (Transportable Objects)

Objetos complexos compostos de múltiplos campos estruturados são delimitados com um cabeçalho de 2 bytes indicando seu tamanho:
```
┌────────────┬──────────────┐
│Tamanho (2B)│ Dados do Obj │
└────────────┴──────────────┘
```
Caso o cabeçalho de tamanho seja `0`, o objeto é interpretado como nulo ou vazio no cliente.

---

## Sistema de Manipulação (Handlers)

O processamento é mapeado através de handlers dedicados que registram e atendem a requisições de soquetes.

### Como Mapear um Novo Comando

```python
from handlers.base_handler import BaseHandler
from protocol.commands import SomeCommandCode

class MyHandler(BaseHandler):
    @classmethod
    def get_handlers(cls):
        return {
            SomeCommandCode.MY_COMMAND: 'handle_my_command',
        }
    
    def handle_my_command(self, reader):
        data = reader.read_string()
        # Processamento...
        builder = PacketBuilder()
        builder.write_bool(True)
        self.send_packet(builder.build(SomeCommandCode.MY_RESPONSE))
```

### Propriedades Disponíveis nos Handlers

| Variável | Descrição |
|----------|-----------|
| `self.session` | Instância da sessão ativa do soquete TCP do jogador |
| `self.server` | Instância principal do Servidor do Mundo (WorldServer) |
| `self.player_data` | Dicionário contendo os dados do personagem do jogador |
| `self.role_name` | Nome do personagem ativo na sessão |
| `self.account_id` | Identificador único da conta conectada |

---

## Regras de Inventário

### Índices de Bolsas/Contêineres

| Índice | Bolsa |
|-------|------|
| 1 | Mochila principal do jogador (Inventory) |
| 2 | Mochila de mascotes (Pet inventory) |
| 3 | Mochila de montarias (Mount inventory) |
| 10 ou superior | Slots de equipamentos no corpo |

### Slots de Equipamentos (Bolsa ID = 10+)

| Slot | Tipo de Equipamento |
|------|---------------------|
| 0 | Arma (Weapon) |
| 1 | Armadura (Armor) |
| 2 | Elmo / Capacete (Helmet) |
| 3 | Luvas (Gloves) |
| 4 | Botas (Boots) |
| 5 | Colar (Necklace) |
| 6 | Anel 1 (Ring 1) |
| 7 | Anel 2 (Ring 2) |
| 8 | Cinto (Belt) |
| 9 | Capa (Cape) |

## Atualizacao 2026-06-09

Este documento estava desatualizado em alguns pontos.

- O banco principal atual e PostgreSQL (`mspt1`), com fallback SQLite persistente.
- O runtime cria/migra tabelas em `server_py/database.py`.
- A migration PostgreSQL dos sistemas avancados fica em `server_py/tools/sql/postgres_advanced_item_systems.sql`.
- O dispatcher atual registra 109 comandos.
- Testes atuais: `python -m unittest discover server_py/tests` passa com 85 testes.

Sistemas implementados desde a versao antiga:

- Inventario: `5129`, `5137`, `5138`, reparo `4618-4621` e durabilidade `4613`.
- Shop: lead, vip, reward e var shop registrados.
- Pets: comandos `5378-5431`.
- Agent market: `2865-2872`, tabela `TB_AgentItem`.
- Booth/player shop: `2946-2953`, tabelas `TB_RoleBooth` e `TB_BoothItem`.
- Armory: `4625-4629`, tabela `TB_RoleArmory`.
- Wardrobe: `8293-8297`, tabela `TB_RoleWardrobe`.
- Artifact: `6145-6209`, tabela `TB_RoleArtifactState`.
- Equip kindGrow: `10800-10810`, tabela `TB_RoleKindGrow`.
- **NOVO**: Drop groups hardcodeados no `LootManager` (`bw0200`, `ab0000`, `bb1000`).
- **NOVO**: Spawn `b0100` (Senhor Golem lv10) no mapa a4 já existe nos dados (`ma4.json`).
- **NOVO**: `loot_manager.py` corrigido (duplicação removida, `@classmethod` adicionado em `get_handlers`).
- **NOVO**: Handler `NPC_ASSEMBLE_ITEM_REQUEST` (1026) / `NPC_ASSEMBLE_ITEM_ANSWER` (1027) em `NpcHandler` para montagem de itens (wing/pet/ride/armory via `assembleRuleIndex`).
- **NOVO**: Handler `PLAYER_WING_SPIRIT_REQUEST` (12544) / `PLAYER_WING_SPIRIT_ANSWER` (12545) em `WingSpiritHandler` para espírito das asas (`equipmentId`, `spiritType`, `doType`).
- **NOVO**: Quest chain 4999-5020 implementada no `TaskHandler` com suporte a `_main_tasks_4990_5020.json`, `npcMenuReceive`, `npcMenuFinish`, `clientMacro`, auto-receive e conditions.

Recursos de gameplay:

- `ResourceIndex` continua sendo o indice usado por combate/skill para `isc.json`, `ibc.json` e `iix.json`.
- `GameResourceService` foi adicionado em `server_py/gameplay/game_resource_service.py` para acesso lazy por dominio.
- Dominios iniciais: skills, buffs, items, shops, tasks, system, equipment_models e resource_models.
- Auditoria: `python server_py/tools/audit_resource_domains.py --max-examples 6`.
