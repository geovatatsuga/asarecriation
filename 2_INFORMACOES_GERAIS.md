# Servidor Privado Asa de Cristal - Informações Gerais

## Visão Geral do Projeto

Este repositório contém a implementação completa de um servidor privado para o MMORPG baseado em Flash **Asa de Cristal**, juntamente com arquivos do cliente modificados e recursos exportados. O projeto permite a execução do jogo de maneira autônoma para fins de preservação histórica, modificação e aprendizado acadêmico.

## Componentes Principais

### Servidor (Python)
Localizado no diretório `server_py/`:
- Arquitetura de múltiplos servidores (HTTP, Login, Mundo/World e Diretrizes/Policy).
- Protocolo binário customizado.
- Sistema de manipulação de pacotes modular.
- Mecânicas de inventário, equipamentos e gerenciamento de personagens.
- Conexão opcional com banco de dados SQL Server.
- Ferramentas de depuração de tráfego de rede (proxy de pacotes).

### Cliente (Flash/ActionScript)
- Arquivos `.swf` modificados (`_game_outer_patched*.swf`) configurados especificamente para conectar-se ao servidor local privado.
- Código-fonte em ActionScript exportado na pasta `_referencias/_game_outer_export/scripts/`.
- Elementos visuais (skins) de componentes de interface gráfica (UI) e a lógica básica do jogo.
- Wrapper de armazenamento local para persistência de recursos do lado do cliente.
- Wrapper de interface externa para comunicação direta com a página HTML no navegador.

### Recursos (Assets)
- Versões originais e modificadas do executável do cliente de jogo (`.swf`).
- Recursos exportados do inicializador (launcher) e de interfaces do jogo.
- Arquivos estáticos servidos dinamicamente pelo servidor HTTP.

## Principais Funcionalidades Implementadas

1. **Multiplataforma**: Desenvolvido em Python, o servidor roda perfeitamente em Windows, Linux e macOS.
2. **Compatibilidade com o Cliente**: O protocolo binário foi modelado para corresponder exatamente às mensagens lidas e escritas pelo cliente original em Flash.
3. **Estrutura Extensível**: O sistema de handlers facilita o acoplamento de novos comandos e respostas de pacotes.
4. **Armazenamento Flexível**: Suporta o modo simplificado sem banco de dados (gerando contas na hora na memória) ou através de persistência em SQL Server.
5. **Auxiliares de Depuração**: Proxy de pacotes embutido para interceptação e acompanhamento em tempo real do tráfego.
6. **Sistemas de Gameplay**: Movimentação, combate básico, inventário de itens e mercadores.

## Como Utilizar

### Executando o Servidor
```bash
# Navegue para o diretório
cd server_py

# Execução básica
python main.py

# Execução com proxy de depuração ativado
START_DEBUG_PROXY.bat
```

### Inicializando o Cliente
Utilize um dos arquivos do cliente fornecidos na raiz ou na pasta de referências:
- `_game_outer_patched2.swf` (recomendado para conexões locais diretas).
- `_game_outer_patched.swf`.
- O cliente original `_game_outer.swf` exige redirecionamento DNS/hosts para apontar para o seu servidor.

## Configuração Básica

As definições do servidor são controladas por:
- `server_py/config.py`: Portas de rede, IP de escuta e modo de autenticação.
- Variáveis de ambiente: A porta do mundo (`WORLD_PORT`) pode ser injetada via linha de comando para subir múltiplos mundos se necessário.
- Modos de login:
  - `debug`: Aceita qualquer conta inserida no formulário e cria o personagem na hora.
  - `db`: Requer validação de usuários em banco de dados Microsoft SQL Server.

## Fluxo de Desenvolvimento

### Adicionando um Novo Comando de Rede
1. Identifique o número de ID do comando (ex: no cliente Flash ou no dicionário de comandos).
2. Adicione ou modifique o respectivo handler no diretório `server_py/handlers/`.
3. Registre o comando mapeando seu ID para uma função executável no método `get_handlers()` do seu handler.
4. Codifique a lógica herdando da estrutura `BaseHandler`.

### Alterando o Comportamento do Cliente Flash
1. Analise o código ActionScript exportado na pasta de referências.
2. Edite os scripts desejados utilizando uma ferramenta de edição Flash compatível.
3. Recompile ou insira o script modificado de volta no arquivo `.swf` (ex: utilizando o editor JPEXS FFDEC).
4. Substitua o arquivo executável `.swf` na raiz ou na pasta do servidor HTTP.

## Detalhes de Baixo Nível

### Formato dos Pacotes de Rede
- **Estrutura**: `[Tamanho em VarInt] [Comando (2 bytes)] [Digest/Verificação (2 bytes)] [Payload/Conteúdo]`
- **Codificação de Tamanho**: Padrão VarInt (MSB indica continuação de bits).
- **Ordem de Bytes (Endianness)**: Big Endian para todos os números representados por múltiplos bytes.
- **Textos/Strings**: Formato UTF-8 precedido pela indicação do seu tamanho em VarInt.
- **Booleanos**: 1 byte de dados (0 = falso, 1 = verdadeiro).

### Divisão de Comandos por Categoria
- **Servidor do Mundo (Geral)** (IDs 33-50): Conexão inicial, pings de keep-alive e sincronização.
- **Gerenciador de Personagem (Role)** (IDs 257-276): Listagem, verificação de nome, criação e seleção de personagens.
- **Ações do Jogador** (IDs 513-676): Movimentação, envio de chats, uso de habilidades e combate.
- **Mochila e Inventário (Bag)** (IDs 5121-5141): Gerenciamento de itens, separação, ordenação automática e descarte.
- **Equipamentos** (IDs 4609-4610): Atualização visual de armaduras, armas e desequipagem.
- **Mercadores e Lojas (Shop)** (IDs 2817-2821): Operações comerciais de compra e venda de itens.

## Observações Legais
Este projeto destina-se puramente à pesquisa educacional e à preservação histórica de plataformas legadas de jogos eletrônicos que não encontram-se mais ativas oficialmente. Todos os assets, designs, conceitos e códigos originais do cliente permanecem sob a propriedade intelectual de seus detentores legais.

## Atualizacao 2026-06-09

Este documento estava desatualizado onde citava SQL Server e gameplay apenas basico.

Estado atual:

- Banco principal: PostgreSQL `mspt1`, com fallback SQLite persistente.
- Migration PostgreSQL dos sistemas avancados: `server_py/tools/sql/postgres_advanced_item_systems.sql`.
- Dispatcher atual: 109 comandos registrados.
- Testes: `python -m unittest discover server_py/tests` passa com 80 testes.
- Gameplay implementado alem do basico: pets, reparo/durabilidade, buy-and-use, lojas especiais, agent market, booth, armory, wardrobe, artifact e kindGrow.
- **NOVO**: `_send_player_view_map_answer` e `_auto_send_map_data` implementados em `WorldSession`.
- **NOVO**: Auditoria completa de recursos decodificados realizada (`audit_resource_domains.py`).
- **NOVO**: Drop groups hardcodeados no `LootManager` (`bw0200`, `ab0000`, `bb1000`).
- **NOVO**: Spawn `b0100` (Senhor Golem lv10) no mapa a4 já existe nos dados.
- **NOVO**: `loot_manager.py` corrigido (duplicação removida, `@classmethod` adicionado).
- **NOVO**: Handler `NPC_ASSEMBLE_ITEM_REQUEST` (1026) / `NPC_ASSEMBLE_ITEM_ANSWER` (1027) em `NpcHandler` para montagem de itens (wing/pet/ride/armory via `assembleRuleIndex`).
- **NOVO**: Handler `PLAYER_WING_SPIRIT_REQUEST` (12544) / `PLAYER_WING_SPIRIT_ANSWER` (12545) em `WingSpiritHandler` para espírito das asas (`equipmentId`, `spiritType`, `doType`).
- **NOVO**: Quest chain 4999-5020 implementada no `TaskHandler` com suporte a `_main_tasks_4990_5020.json`, `npcMenuReceive`, `npcMenuFinish`, `clientMacro`, auto-receive e conditions.

Infraestrutura de recursos atual:

- `ResourceIndex` permanece como indice enxuto de skill/buff/job skill.
- `GameResourceService` (`server_py/gameplay/game_resource_service.py`) fornece cache lazy por dominio para recursos decodificados.
- A ferramenta `server_py/tools/audit_resource_domains.py` localiza candidatos de config para pet, artifact, glyph, angel, cloak, divine, family, mail, rank, shop, kindGrow, armory e wardrobe.

### Próximos passos (Ordem 1 - Em andamento):

1. ~~**Quest chain 4999-5020**: Implementar no `TaskHandler` lendo `_main_tasks_4990_5020.json` via `GameResourceService`.~~ **CONCLUÍDO**
