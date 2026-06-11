# Como Jogar Asa de Cristal Localmente

Este guia explica como executar o cliente Flash do jogo Asa de Cristal localmente, conectando-se ao servidor privado que você está executando.

## Pré-requisitos

1. **Servidor em execução**: Você deve ter o servidor Python rodando em `server_py/`
   ```bash
   cd server_py
   python main.py
   ```
   Certifique-se de que você vê logs como `[POLICY]`, `[LOGIN]` e `[WORLD]` no console.

2. **Adobe Flash Player Projector**: O navegador não suporta mais Flash, então você precisa do projetor independente.

## Opções para obter o Flash Player Projector

Eu criei scripts de download na pasta atual para facilitar a obtenção do Adobe Flash Player Projector Debugger (versão 32.0.0.445):

### Opção 1: PowerShell (Recomendado)
```powershell
.\download_flash_player.ps1
```

### Opção 2: Batch File
```cmd
.\download_flash_player.bat
```

### Opção 3: Shell Script (Git-Bash)
```bash
bash download_flash_player.sh
```

**Nota**: Se encontrar problemas com políticas de execução no PowerShell, execute:
```powershell
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
.\download_flash_player.ps1
```

## Após o Download

1. Execute o arquivo baixado: `flashplayer_32_sa_debug.exe`
2. Na janela do Flash Player:
   - Clique em **File → Open**
   - Navegue até esta pasta e selecione `_game_outer_patched2.swf`
3. O jogo deve conectar-se automaticamente ao servidor local (127.0.0.1:9999 para login, 127.0.0.1:8888 para mundo)
4. Use qualquer nome de usuário e senha (modo de depuração aceita todas as credenciais)
5. Você verá a tela de login e depois entrará no mundo do jogo

## Arquivos SWF Disponíveis

- `_game_outer_patched2.swf` (recomendado): Já configurado para conectar-se a 127.0.0.1
- `_game_outer_patched.swf`: Alternativa também configurada para localhost
- `_game_outer.swf`: Original - exigiria modificação de hosts/DNS para apontar para 127.0.0.1

## Solução de Problemas

### Tela preta/blank screen
Isso geralmente significa que o servidor de política (porta 843) não está respondendo corretamente.
Verifique se você vê `[POLICY] 127.0.0.1:843 - <cross-domain-policy>...` nos logs do servidor.
Você pode testar manualmente com:
```bash
telnet 127.0.0.1 843
```
Deve retornar um XML de política de domínio cruzado.

### Conexão recusada/timeouts
- Verifique se o servidor está realmente rodando (`python main.py` em server_py/)
- Confirme que as portas 9999 (login) e 8888 (mundo) estão abertas e não bloqueadas por firewall
- Verifique se `_game_outer_patched2.swf` está realmente apontando para 127.0.0.1 (ele já está pré-configurado)

## Notas Importantes

- Este é o **Flash Player Projector Debugger** - versão independente, não é um plugin de navegador
- O modo de depuração (`auth_mode = 'debug'` no config.py) aceita qualquer credencial, perfeito para testes locais
- Não distribua ou use este projetor para acessar servidores oficiais do jogo - use apenas para seu servidor privado local