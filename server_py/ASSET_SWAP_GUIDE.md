# Guia Correto para Trocar Assets Visuais no Servidor

Este documento descreve o passo‑a‑passo recomendado para substituir imagens (PNG/JPG) utilizadas pelo cliente Flash, garantindo que as alterações sejam visíveis no jogo (login, tela de loading, personagens, itens, etc.).

---

## 1. Entenda de onde o cliente carrega cada tipo de asset

| Tipo de asset | Onde está definido | Como é carregado |
|---------------|-------------------|------------------|
| **Bitmap interno (IDs no `_game_outer.swf`)** | `server_py/protocol/commands.py` → IDs de comando; `server_py/handlers/` → handlers; `server_py/tests/` → testes de round‑trip. | O cliente solicita o SWF principal (`_game_outer.swf`). Dentro dele, os objetos `BitmapData` são acessados via `ResourceManager.getBitmapData("<resourceId>")`. O `resourceId` é mapeado para um hash em `game_resources/decoded_resource_manifest.json` (`"id": "<nome>", "url": "<hash>"`). |
| **Assets externos em `assets.swf`** | Arquivos ActionScript que possuem `[Embed(source="/_assets/assets.swf", symbol="symXXX")]`. | O SWF principal nunca lê esses símbolos diretamente; eles são embutidos em tempo de compilação. Para mudar, é necessário editar o próprio `assets.swf` (substituir o símbolo) e garantir que o servidor sirva a versão atualizada. |
| **Outros recursos (JSON, XML, etc.)** | Pastas `game_resources/decoded/` e `game_resources/res/` | Carregados via `URLLoader` ou similares; não envolvem bitmap. |

> **Regra prática:** Se o asset que você quer mudar aparecer em tela de login, loading ou em qualquer UI que seja definida por classes com `[Embed]`, ele está dentro de `assets.swf`. Se aparecer como sprite de personagem, item, mapa ou efeito que é buscado por ID numérico no jogo, ele está dentro do `_game_outer.swf` e no manifesto de recursos.

---

## 2. Fluxo de trabalho para **assets internos** (IDs no SWF)

1. **Identifique o ID numérico**  
   - Procure no cliente AS (`_referencias/_game_outer_export/scripts/.../CommandCode*.as`) o nome do comando que usa o asset.  
   - Abra o arquivo AS de request/answer/notify correspondente e copie a ordem exata dos campos declarados no método de serialização/lista de campos.  
   - Anote o ID (ex.: `CommandCodeFoo.BITMAP_ID = 35;`).

2. **Atualize o manifesto de recursos**  
   - Gere o hash MD5 da nova imagem (mesma dimensão e formato que o original).  
   - Edite `game_resources/decoded_resource_manifest.json` e substitua o campo `"url"` do recurso cujo `"id"` corresponde ao nome que o AS usa (ou crie uma nova entrada se não existir).  
   - Exemplo:
     ```json
     {
       "id": "hero_avatar_35",
       "url": "a7eabbc4b3e0ec9f73b90f743427d02c"
     }
     ```

3. **Coloque a imagem no diretório de recursos**  
   - Copie a nova PNG/JPG para `game_resources/res/<hash>.png` (ou `.jpg`). O nome do arquivo deve ser exatamente o hash que você colocou no manifesto.

4. **Recompile o SWF (se necessário)**  
   - Se o SWF já contém a tag de bitmap com aquele ID, basta substituir o arquivo SWF existente pelo novo (o servidor o servirá na próxima requisição).  
   - Caso você queira garantir que o ID exista, use o FFDEC para importar a imagem como `DefineBitsLossless2` com o ID correto e salve como `_game_outer_patched.swf`.

5. **Substitua o SWF no servidor**  
   ```bash
   cp _game_outer_patched.swf ../_referencias/_game_outer.swf
   ```
   - Mantenha um backup (`_game_outer.swf.bak`) por segurança.

6. **Teste**  
   - Reinicie o servidor HTTP (`pkill -f "servers.http_server"; python -m servers.http_server &`).  
   - Limpe o cache do navegador (Ctrl+Shift+R) e verifique se a nova imagem aparece.  
   - Consulte `server_py/logs/latest.log` (e, se for combate, os logs em `server_py/logs/combat/`) para garantir que não há erros de “End of file was encountered”.

---

## 3. Fluxo de trabalho para **assets externos** (`assets.swf`)

1. **Localize o `assets.swf`**  
   - No ambiente de desenvolvimento, procure a pasta `_assets/` ao lado do SWF principal ou verifique onde o servidor estática serve arquivos (geralmente o mesmo diretório onde você inicia `python -m servers.http_server`).  
   - Se não encontrar, o arquivo pode estar embutido dentro do `_game_outer.swf`. Nesse caso, extraia‑o com:
     ```bash
     ffdec -export _assets/assets.swf _game_outer.swf
     ```

2. **Identifique o símbolo a ser trocado**  
   - No AS que usa o asset, procure a linha `[Embed(source="/_assets/assets.swf", symbol="symbolXX")]`.  
   - Anote o número do símbolo (ex.: `symbol86` para login, `symbol40` para loading).

3. **Edite o `assets.swf`**  
   - Abra o arquivo em FFDEC (ou outro editor SWF).  
   - Navegue até a biblioteca → localize o símbolo pelo número.  
   - Substitua a imagem pelo novo PNG/JPG (mesma dimensão ou ajuste o código de posicionamento se necessário).  
   - Salve o SWF.

4. **Copie o SWF atualizado para o diretório de assets**  
   ```bash
   cp assets.swf _assets/
   ```
   - Se o `_assets/` não existir, crie‑o.

5. **Reinicie o servidor** e limpe o cache do navegador.  
   - Verifique na aba Network que o request a `_assets/assets.swf` retorna o arquivo com o novo timestamp/tamanho.

6. **Confirme visualmente**  
   - Login screen, loading screen, ou qualquer UI que use aquele símbolo deve exibir a nova arte.

---

## 4. Dicas e armadilhas comuns

| Problema | Causa provável | Solução |
|----------|----------------|---------|
| Imagem não muda depois de substituir o SWF | Você editou o SWF errado (ex.: `_game_outer.swf` ao invés de `assets.swf`) | Confirme onde o asset está embarcado (procure por `[Embed]`). |
| “End of file was encountered” ao receber pacote | Ordem ou tipo de campos no handler AS incorreto (ex.: escreveu length prefix duas vezes) | Siga a regra: funções de escrita **raw** escrevem apenas os dados; `write_transportable_object()` adiciona o length prefix. |
| Imagem aparece distorcida ou cortada | Dimensões diferentes do original | Redimensione a nova imagem para exatamente o mesmo tamanho (largura × altura) do bitmap original. |
| O servidor continua servindo a versão antiga | Cache de navegador ou de proxy | Use hard refresh (Ctrl+Shift+R) ou adicione um query string vazio (`?v=2`) para forçar recarregamento. |
| Hash não encontrado no manifesto | Você esqueceu de adicionar ou digitou errado o ID | Verifique novamente o `decoded_resource_manifest.json`; o campo `"id"` deve corresponder ao nome usado no AS (não ao número). |
| Arquivo de recursos muito grande causando timeout ao listar diretório | Sistema de arquivos lento ou número excessivo de arquivos | Evite `ls -la` em pastas grandes; use `find … | head -5` ou limite a listagem. |

---

## 5. Checklist rápido (para copiar‑colar em seu terminal)

```bash
# 1️⃣ Identificar ID e gerar hash
NEW_IMG="path/to/nova_imagem.png"
HASH=$(md5sum "$NEW_IMG" | cut -d' ' -f1)
echo "Hash da nova imagem: $HASH"

# 2️⃣ Atualizar manifesto (exemplo para ID 35)
jq '.[] | select(.id=="hero_avatar_35") | .url = env.HASH' \
    --arg HASH "$HASH" game_resources/decoded_resource_manifest.json \
    > tmp.json && mv tmp.json game_resources/decoded_resource_manifest.json

# 3️⃣ Copiar imagem para res/
cp "$NEW_IMG" "game_resources/res/$HASH.png"

# 4️⃣ (Opcional) Patch SWF com FFDEC se o ID ainda não existir
# ffdec -replacebitmap 35 "$NEW_IMG" _game_outer.swf _game_outer_patched.swf

# 5️⃣ Substituir SWF principal
cp _game_outer_patched.swf ../_referencias/_game_outer.swf   # ou o caminho correto do seu projeto

# 6️⃣ Reiniciar servidor e testar
pkill -f "servers.http_server"
python -m servers.http_server &
# Abra o jogo, limpe cache (Ctrl+Shift+R) e verifique.
```

---

## 6. Exemplo de mapa mental (Mermaid) – Fluxo de decisão

```mermaid
flowchart TD
    A[Quer mudar um asset visual?] --> B{Está em UI com [Embed]?}
    B -->|Sim| C[Editar assets.swf (símbolo)]
    B -->|Não| D[É bitmap interno identificado por ID?]
    D -->|Sim| E[Atualizar manifesto + colocar hash em res/]
    D -->|Não| F[Outro tipo (JSON, XML) – editar diretamente em game_resources/decoded/]
    C --> G[Copiar assets.swf para _assets/]
    E --> G
    G --> H[Reiniciar servidor + limpar cache]
    H --> I[Verificar nos logs e na tela]
```

*Use o bloco acima em qualquer editor que suporte Mermaid (ex.: VS Code com extensão Markdown Preview Mermaid Support) para visualizar o fluxo.*

---

### Conclusão

Seguir esse fluxo garante que você está modificando exatamente o local de onde o cliente lê o asset, evitando o retrabalho de mudar arquivos que nunca são usados em tempo de execução. Sempre valide o hash no manifesto, confirme o símbolo no AS quando for `assets.swf`, e monitore os logs para detectar problemas de desserialização rapidamente.

--- 

*Guia elaborado para a equipe de desenvolvimento do servidor Asa de Cristal. Última revisão: 08‑06‑2026.*
## Atualizacao 2026-06-09

O fluxo de assets continua valido. Observacao importante: localizar telas via AS pode envolver comandos, mas troca visual pura nao exige alterar `protocol/commands.py` nem handlers. So altere protocolo quando a tela depender de novo pacote/estado vindo do servidor.

### Telas do launcher/local client

No launcher local, `server_py/game_resources/index.html` passa por padrao:

```js
so.addVariable("bin", getQueryParamValue("bin") || "bin/game.bin");
```

Entao o SWF que aparece ao abrir o cliente pelo launcher e `server_py/game_resources/bin/game.bin`. Nao basta deixar um `_game_outer_patched2.swf` novo na raiz do projeto; depois de salvar/patchar o SWF, copie a versao final para:

```powershell
Copy-Item -LiteralPath "_game_outer_patched2.swf" -Destination "server_py/game_resources/bin/game.bin" -Force
```

As telas principais vistas antes de entrar no mundo foram confirmadas no AS exportado:

| Tela | Arquivo AS | Simbolo |
|------|------------|---------|
| Login | `_referencias/_game_outer_export/scripts/mmorpg/LoginUI.as` | `symbol86` |
| Selecao de personagem | `_referencias/_game_outer_export/scripts/mmorpg/RoleListUI.as` | `symbol242` |
| Criacao de personagem | `_referencias/_game_outer_export/scripts/mmorpg/CreateRoleUI.as` | `symbol4936` |

Imagens soltas em `assets_raw/` sao apenas fonte/bruto para patch. O Flash nao le essa pasta em runtime. Para testar pelo launcher, o conteudo precisa estar embutido no SWF final que vai para `bin/game.bin`, ou o HTML precisa receber `?bin=...` apontando para outro arquivo servido pelo HTTP.

Em 2026-06-09, `assets_raw/35.png` foi identificado visualmente como fundo/tela inicial de login em `1000x600`; `assets_raw/4866.png` foi identificado como tela de criacao de personagem em `1000x600`.

Em 2026-06-10, foi confirmado que o SWF original declarava `displayrect` de `500x375`, mas as artes novas estavam em `1000x600`. Redimensionar a imagem para `500x375` e reimportar no mesmo ID piorou o visual porque alguns simbolos de tela usam composicao interna/masks/slices e o FFDEC preserva a estrutura ao trocar a imagem. O caminho mais estavel para esse caso foi manter os PNGs em `1000x600` e ajustar o cabecalho do SWF:

```powershell
new_game\tools\ffdec\app\ffdec-cli.exe -header -set width 1000px -set height 600px server_py\game_resources\game.swf game_1000x600_header.swf
```

Depois copie o SWF resultante para `game.swf`, `bin/game.bin`, `_game_outer_patched2.swf` e qualquer caminho legado usado por `/res/data1`. So mexa em `SomcGame.as` (`StageScaleMode.NO_SCALE`) se ainda for necessario resolver fullscreen/escala do standalone; para alinhamento base, o header `1000x600` e menos invasivo.

Estado validado visualmente: login ficou bem alinhado com header `1000x600`. A tela de criacao/selecao de personagem tambem carregou os novos assets, mas alguns controles ficaram levemente fora do encaixe do layout original; esse ajuste fino deve ser tratado no simbolo/timeline da tela ou no modulo AS correspondente, nao por resize global da imagem.

Comandos uteis para auditar esse contrato:

```powershell
# Conferir displayrect/header declarado pelo SWF.
new_game\tools\ffdec\app\ffdec-cli.exe -header server_py\game_resources\game.swf

# Alterar header sem mexer nos bitmaps.
new_game\tools\ffdec\app\ffdec-cli.exe -header -set width 1000px -set height 600px server_py\game_resources\game.swf game_1000x600_header.swf
```

Evite importar scripts AS3 em massa com `-importScript` so para trocar `StageScaleMode.NO_SCALE`: em teste, o import completo ficou muito lento/travou. Para fullscreen/escala, prefira patch pequeno no FFDEC GUI ou export/import cirurgico de apenas `SomcGame.as`, com backup e teste visual imediato.

Se o Flash Debugger abrir diretamente:

```text
http://127.0.0.1:8081/WebLaucher.swf
```

o `index.html` nao injeta o parametro `bin`. Nesse modo o launcher baixa `/res/data1`, descriptografa/descompacta o conteudo e usa a URL encontrada ali. O `data1` antigo apontava para:

```text
{/res/16ceadfbd18d8d9042567d31415807c6}
```

Esse arquivo era uma copia antiga do jogo. Para o modo direto do Flash Debugger, `server_py/game_resources/res/data1` deve apontar para:

```text
{/bin/game.bin}
```

ou o arquivo legado `/res/16ceadfbd18d8d9042567d31415807c6` tambem precisa receber o SWF novo. O servidor HTTP nao deve servir `/res/data1`, `/res/data2` nem esse hash legado com cache imutavel, porque eles funcionam como ponteiros/bootstrap do cliente, nao como assets versionados finais.

Durante desenvolvimento local, tambem nao cacheie `.swf` nem `.bin` por tempo fixo. O Flash Player pode reutilizar `game.swf` antigo quando a URL nao muda, fazendo parecer que o arquivo no disco nao atualizou. `server_py/servers/http_server.py` e `server_py/start_all.py` devem enviar `Cache-Control: no-store, no-cache, must-revalidate, max-age=0` para `.swf`/`.bin`. Assim o link limpo `http://127.0.0.1:8081/game.swf` tende a pegar a versao mais nova sem depender de `?v=...`.

Para evitar cache persistente do Flash standalone, o servidor tambem redireciona automaticamente requests limpos de `/game.swf` e `/bin/game.bin` para a mesma URL com `?v=<mtime_ns_do_arquivo>`. Assim o usuario pode digitar `http://127.0.0.1:8081/game.swf`, mas o Flash recebe uma URL versionada atualizada sem precisar incrementar `v=4`, `v=5`, etc. manualmente. Depois de alterar este comportamento, reinicie o servidor HTTP; o processo antigo nao pega o codigo novo.

Para comandos novos, usar `server_py/GUIA_NOVOS_COMANDOS_AS.md`.

Para recursos JSON de gameplay, usar tambem:

- `server_py/gameplay/game_resource_service.py`: acesso lazy por dominio aos JSONs decodificados.
- `server_py/tools/audit_resource_domains.py`: auditoria de termos como `pet`, `artifact`, `glyph`, `angel`, `cloak`, `divine`, `family`, `mail`, `rank`, `shop`, `kindGrow`, `armory` e `wardrobe`.

Exemplo:

```bash
python server_py/tools/audit_resource_domains.py --max-examples 6
```
