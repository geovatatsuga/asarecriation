# Guia de Ferramentas - Descompilação e Modificação do Cliente Flash

Este guia explica detalhadamente como trabalhar com os arquivos de código ActionScript 3 (`.as`) e os binários compilados do Flash (`.swf`) do jogo **Asa de Cristal** utilizando ferramentas padrão de engenharia reversa.

---

## Ferramentas Recomendadas

### 1. JPEXS Free Flash Decompiler (FFDEC) - Ferramenta Principal
* **Link para Download:** [JPEXS FFDEC Releases](https://github.com/jindrapetrik/jpexs-decompiler/releases)  
* **Licença:** Gratuito e de Código Aberto (GPLv3)  
* **Requisito:** Java Runtime Environment (JRE 8 ou superior) instalado no Windows.

#### Principais Recursos:
* **Descompilação Limpa:** Converte os arquivos binários `.swf` em código ActionScript 3 (`.as`) legível e organizado.
* **Preserva Estrutura de Pacotes:** Mantém a organização de pastas e namespaces originais do jogo.
* **Extração de Recursos (Assets):** Permite exportar imagens, trilhas sonoras (`.mp3`), formas vetoriais, textos e fontes embutidas no jogo.
* **Edição Direta:** Você pode alterar o código ActionScript 3 diretamente no descompilador, salvar e gerar um novo `.swf` na hora.
* **Pesquisa Global:** Busca de termos (como códigos de pacotes) em todo o projeto de uma só vez.

#### Como Usar no seu Projeto:
1. Abra o JPEXS FFDEC.
2. Vá em `File → Open` e selecione seu cliente de jogo modificado: `_game_outer_patched2.swf`.
3. No painel esquerdo, você verá a árvore de recursos e códigos dividida em pastas (ex: `scripts`, `images`, `sounds`).
4. Para buscar onde um pacote é enviado ou recebido (ex: comando `5124` de uso de item), pressione `Ctrl + F` e faça a busca global pelo número.

---

### 2. Visual Studio Code (VS Code) - Para Leitura do Código Extraído
* **Link para Download:** [VS Code Oficial](https://code.visualstudio.com/)
* **Extensões Recomendadas:**
  * Procure na loja do VS Code por **ActionScript 3** (por *Joshualek* ou *Marc Bosch*) para obter realce de cores no código.

#### Como Usar:
1. No VS Code, vai em `File → Open Folder`.
2. Selecione a pasta de referências de código extraída: `_referencias/_game_outer_export/scripts`.
3. Use o atalho `Ctrl + Shift + F` para realizar buscas em todos os arquivos de script de uma vez só. É extremamente rápido e prático para entender a lógica das funções.

---

## Códigos de Pacotes Principais para Referência rápida

Caso você queira mapear a lógica entre o Cliente e o Servidor, busque por estes códigos chave no descompilador ou VS Code:

| Código de Comando | Ação no Jogo | Descrição do Fluxo |
|-------------------|--------------|---------------------|
| **513**           | `PLAYER_ENTER_WORLD_REQ` | Jogador requisita login no mundo do jogo |
| **519**           | `PLAYER_MOVE_REQ` | Sincroniza e valida a movimentação do boneco |
| **545**           | `PLAYER_USE_SKILL_REQ` | Jogador utiliza uma habilidade/ataque |
| **5121**          | `PLAYER_BAG_CHECK_NOTIFY` | Atualiza os itens da mochila na tela |
| **5124**          | `PLAYER_USE_ITEM_REQ` | Jogador equipa ou consome um item da bag |
| **4609**          | `PLAYER_EQUIPMENT_CHECK` | Atualiza o visual e atributos dos equipamentos |
| **2818**          | `SHOP_BUY_ITEM_REQ` | Compra itens de mercadores NPCs |

---

## Boas Práticas ao Fazer Modificações
1. **Sempre faça backup:** Mantenha uma cópia de segurança do seu arquivo `_game_outer_patched2.swf` funcional antes de tentar editá-lo no JPEXS.
2. **Use o VS Code para ler e pesquisar:** A busca global do VS Code é muito mais rápida do que a do JPEXS para navegar pelos mais de 2.000 arquivos de código.
3. **Edite de forma incremental:** Altere um pequeno script, salve e teste a conexão do jogo para garantir que nenhuma estrutura binária foi quebrada na recompilação.

## Assets de Tela e Tamanho do Palco

Para telas grandes como login e criacao de personagem, confira o `displayrect` do SWF antes de trocar imagens:

```powershell
new_game\tools\ffdec\app\ffdec-cli.exe -header server_py\game_resources\game.swf
```

Em 2026-06-10, as artes novas estavam em `1000x600`, enquanto o SWF declarava `500x375`. Redimensionar a arte para caber no header antigo piorou o resultado, porque esses simbolos podem ter composicao interna, mascaras e elementos sobrepostos. O ajuste que preservou melhor o layout foi manter os PNGs em `1000x600` e alterar o header:

```powershell
new_game\tools\ffdec\app\ffdec-cli.exe -header -set width 1000px -set height 600px server_py\game_resources\game.swf game_1000x600_header.swf
```

Depois copie a saida para os caminhos servidos (`game.swf`, `bin/game.bin` e qualquer hash legado usado por `/res/data1`). Se o problema restante for fullscreen, investigue `SomcGame.as`, onde o cliente define `StageScaleMode.NO_SCALE`; nao use resize de bitmap como solucao para escala de palco.

## Atualizacao 2026-06-09

Comandos uteis adicionados/confirmados para busca no AS:

| Codigo | Nome | Uso |
|--------|------|-----|
| 5129 | PLAYER_VIEW_BAG_REQUEST | Ver bag explicitamente |
| 5137 | PLAYER_RENEW_ITEM_REQUEST | Renovar item |
| 5138 | PLAYER_BUY_AND_USE_ITEM_REQUEST | Comprar e usar |
| 4618-4621 | PLAYER_REPAIR_* | Reparo de equipamento |
| 5378-5431 | PET_* | Sistema de pets |
| 2865-2872 | AGENT_* | Agent market |
| 2946-2953 | BOOTH_* | Loja de jogador |
| 6145-6209 | ARTIFACT_* | Artifact/refino |
| 10800-10810 | KIND_GROW_* | Crescimento de equipamento |

Indice Python atual: `server_py/scratch_server_commands.txt`.

## Auditoria de Recursos Decodificados

O servidor agora possui uma ferramenta para encontrar quais JSONs decodificados parecem pertencer a cada sistema de gameplay:

```bash
python server_py/tools/audit_resource_domains.py --max-examples 6
```

Ela procura palavras-chave como `pet`, `artifact`, `glyph`, `angel`, `cloak`, `divine`, `family`, `mail`, `rank`, `shop`, `kindGrow`, `armory` e `wardrobe` em `server_py/game_resources/decoded`.

Use essa auditoria antes de implementar semantica real de um handler novo. O AS define o pacote; os JSONs decodificados ajudam a descobrir custo, limite, item consumido, level cap e regras de progressao.
