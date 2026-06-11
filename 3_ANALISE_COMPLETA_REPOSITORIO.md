# Análise Completa do Repositório: Servidor e Cliente Asa de Cristal

Este documento apresenta uma análise estrutural detalhada de todo o repositório, mapeando o papel de cada arquivo e a conexão entre o cliente Flash e a lógica do servidor em Python.

## Estrutura de Pastas e Arquivos

```
.
├── _game_outer_patched2.swf            # Cliente do jogo modificado ativo (~6.7MB)
├── 1_GUIA_FERRAMENTAS_FLASH.md          # Manual de descompilação com JPEXS FFDEC e VS Code
├── 2_INFORMACOES_GERAIS.md              # Visão geral da arquitetura de servidores e tipos de dados
├── 3_ANALISE_COMPLETA_REPOSITORIO.md    # Este documento
├── README.md                            # Apresentação do projeto e instruções de inicialização
├── _referencias/                        # Diretório de suporte
│   ├── _game_outer.swf                  # Binário original do cliente sem modificações (~6.6MB)
│   ├── _game_outer_patched.swf          # Primeira versão do cliente modificado (~6.7MB)
│   ├── _game_outer_export/              # Scripts ActionScript 3 extraídos do cliente (.as)
│   │   └── scripts/                     # Fontes legíveis para consulta rápida
│   └── _launcher_export/                # Arquivos fontes extraídos do inicializador do jogo
└── server_py/                           # Código-fonte do servidor privado
    ├── main.py                          # Inicializador unificado do servidor
    ├── config.py                        # Definições de conexões e caminhos de arquivos
    ├── servers/                         # Implementação dos soquetes e servidores HTTP/TCP
    ├── handlers/                        # Processamento das requisições e respostas de pacotes
    ├── protocol/                        # Serialização e decodificação do protocolo binário
    ├── game_data/                       # Tabelas estáticas e definições de portais de mapas
    ├── game_resources/                  # Arquivos enviados ao navegador pelo servidor HTTP
    ├── inventory_manager.py             # Regras de bolsas, itens e equipamentos
    ├── player_data_manager.py           # Salvamento e persistência das contas de jogadores
    ├── item_config_loader.py            # Parser e leitor do arquivo de itens (iie.txt)
    └── tools/                           # Utilitários de desenvolvimento e banco de dados
```

## Análise dos Arquivos do Cliente

### Clientes Executáveis (.swf)
- O cliente original (`_game_outer.swf`) foi descompilado para entender as chamadas de rede e extrair a lógica.
- Os clientes modificados (`_patched.swf` e `_patched2.swf`) contêm patches de IPs/Portas redirecionados para apontar para `127.0.0.1` (localhost) ou domínios locais de teste, permitindo que a conexão do Flash ignore os servidores de produção oficiais.

### Scripts Relevantes do Cliente (`_referencias/_game_outer_export/scripts/`)

Estes são arquivos ActionScript 3 vitais extraídos do cliente Flash:

1. **Interface de Comunicação Externa** (`§_-Hl§.as`)
   - Expõe as chamadas Javascript do navegador para dentro do Flash, permitindo, por exemplo, que a página HTML externa passe parâmetros ou envie eventos ao jogo.
   - Utiliza a biblioteca padrão `flash.external.ExternalInterface`.

2. **Gerenciador de Arquivos Locais** (`§_-Jh§.as`)
   - Usado para gravar e ler caches, dados temporários e logs diretamente na máquina local do usuário.
   - Os arquivos são salvos por padrão na pasta local do Windows sob o caminho `./mszj-Asa`.

3. **Arquivos de Skins e Elementos Visuais**
   - Diversos arquivos com o sufixo `Skin` ou `Icon` definem a aparência gráfica de janelas, botões, barras de rolagem, caixas de diálogo e grades de dados dentro do jogo (DataGrids, CheckBoxes, Lists).

4. **SomcGame** (`SomcGame.as`)
   - O arquivo central de inicialização do cliente. Configura a tela principal do jogo, estabelece os ganchos de rede e gerencia as telas de carregamento.

## Comunicação Cliente-Servidor

A dinâmica de funcionamento e sincronia entre as duas frentes segue estes princípios:

### Sequência de Conexão
1. A página HTML abre o inicializador que carrega o `.swf` principal.
2. O cliente realiza uma requisição na porta `843` (Servidor de Diretrizes de Segurança) para obter o arquivo `crossdomain.xml` e liberar conexões locais de soquetes.
3. O cliente conecta no Servidor de Login (porta `9999`) para validar a conta do usuário.
4. O servidor de login autentica e devolve um token de sessão (Ticket).
5. O cliente desconecta do login e abre uma conexão permanente com o Servidor do Mundo (porta `8888`), validando o acesso com o Ticket recebido.
6. O Servidor HTTP (porta `8081`) envia imagens, músicas, texturas e arquivos de dados sob demanda para o cliente Flash renderizar as imagens corretas na tela.

### Fluxo de Pacotes
- Ambas as pontas usam empacotamento binário.
- Toda ação do personagem (andar, usar item, atacar) cria uma mensagem serializada contendo o identificador numérico da ação (Comando), calcula seu tamanho total, anexa uma validação de checksum de 2 bytes (geralmente fixada em zero) e envia pela conexão TCP ativa.

### Alinhamento de Protocolo
Todas as chaves numéricas de comandos definidas no servidor em `server_py/protocol/commands.py` equivalem aos tratamentos de mensagens encontrados no ActionScript.
- Exemplo: Comando `5124` aciona o envio de requisição de uso de item no cliente Flash e chama a lógica de verificação e cálculo de atributos `InventoryHandler.handle_use_item` no servidor.

## Atualizacao 2026-06-09

Este documento estava desatualizado para o estado atual do servidor. Complementos confirmados:

- `server_py/database.py`: runtime PostgreSQL/SQLite e schema dos sistemas persistentes.
- `server_py/handlers/pet_handler.py`: pet view, rename, skills, atributos, action mode, enhance, fusion, remove equipment e decompose.
- `server_py/handlers/advanced_item_handler.py`: trade protocolar, booth, agent market, armory, wardrobe, artifact e kindGrow.
- `server_py/handlers/loot_manager.py`: dono de pickup/drop no mapa (`5123`, `5127`); drop groups hardcodeados (`bw0200`, `ab0000`, `bb1000`); arquivo corrigido (duplicação removida, `@classmethod` adicionado).
- `server_py/handlers/npc_handler.py`: handler `NPC_ASSEMBLE_ITEM_REQUEST` (1026) / `NPC_ASSEMBLE_ITEM_ANSWER` (1027) para montagem de itens.
- `server_py/handlers/wing_spirit_handler.py`: handler `PLAYER_WING_SPIRIT_REQUEST` (12544) / `PLAYER_WING_SPIRIT_ANSWER` (12545) para espírito das asas.
- `server_py/handlers/task_handler.py`: quest chain 4999-5020 implementada com `_main_tasks_4990_5020.json`, `npcMenuReceive`, `npcMenuFinish`, `clientMacro`, auto-receive e conditions.
- `server_py/tools/sql/postgres_advanced_item_systems.sql`: migration PostgreSQL dos sistemas avancados.
- `server_py/scratch_server_commands.txt`: indice atual com 109 comandos registrados.
- Testes atuais: 80 OK com `python -m unittest discover server_py/tests`.
- Spawn `b0100` (Senhor Golem lv10) no mapa a4 já existe nos dados (`ma4.json`).

Atualizacao de recursos em 2026-06-09:

- `server_py/gameplay/resource_index.py`: mantido para skills, buffs e skills por job.
- `server_py/gameplay/game_resource_service.py`: novo servico lazy por dominio para recursos decodificados.
- `server_py/tools/audit_resource_domains.py`: auditoria de palavras-chave nos JSONs decodificados para encontrar configs de sistemas.
- `WorldServer` agora expoe `self.game_resources` sem substituir `self.resource_index`.
