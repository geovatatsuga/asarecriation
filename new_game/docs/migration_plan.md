# Plano De Migracao

## Decisao

Usar o projeto atual como legado vivo e criar um cliente novo em Godot.

Versao alvo: Godot 4.6.3 stable.

Motivos:

- O cliente Flash tem UI, fluxo e assets presos em SWF ofuscado.
- O servidor Python ja ajuda a entender regras, mapas, combate e banco.
- Godot da controle real de cena, animacao, input, camera, UI e performance.

## Fases

1. Base limpa
   - Criar projeto Godot.
   - Definir estrutura de assets.
   - Criar cena inicial.

2. Asset vault
   - Catalogar mapas, personagens, monstros, icones, efeitos e UI.
   - Copiar assets aproveitaveis para `client_godot/assets/legacy`.
   - Registrar origem e formato.

3. Prototipo offline
   - Renderizar mapa de teste.
   - Mostrar personagem placeholder.
   - Implementar movimento basico.

4. Prototipo conectado
   - Criar ponte com servidor Python ou mock.
   - Login fake/local.
   - Entrar no mapa.

5. Combate
   - Ataque basico.
   - Monstro com IA simples.
   - HP, morte e respawn.

## O Que Nao Fazer Agora

- Nao reescrever todo o servidor.
- Nao tentar redesenhar todo o Flash.
- Nao mover assets originais.
- Nao misturar arquivos novos dentro de `server_py/game_resources`.
