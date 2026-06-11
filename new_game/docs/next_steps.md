# Proximos Passos

Plano recomendado para transformar o legado em um jogo novo no Godot sem perder o que ja foi descoberto.

## 1. Manter o legado como fonte de dados

Nao mexer no cliente Flash para criar jogo novo. Ele deve ficar como referencia:

- `server_py/game_resources/decoded`: fonte principal de mapas, configs, modelos e assets.
- `_referencias`: fonte para ActionScript e simbolos de UI.
- `server_py`: fonte das regras ja implementadas e protocolo quando for conectar online.

## 2. Criar uma camada de importacao

Antes de copiar tudo para o Godot, criar ferramentas pequenas em `new_game/tools`:

1. inventariar assets decodificados;
2. resolver IDs de recursos, por exemplo `c01@sh01`;
3. converter `.lib` e `.img` para PNG/atlas quando o formato estiver entendido;
4. gerar arquivos leves para o Godot em `client_godot/assets/legacy`.

Regra: o Godot deve receber apenas assets escolhidos, nao o pacote inteiro.

## 3. Primeiro alvo jogavel

Comecar pelo fluxo inicial real do jogo:

- tela inicial;
- login/registro;
- loading;
- entrada em `ma1.json` / `a1` / Aldeia Tyria.

Depois disso, usar `ma2.json` como segundo mapa de teste, porque e menor e ja contem monstros.

Primeiro resultado esperado:

1. carregar `ma1.json`;
2. desenhar o mapa com placeholders ou tiles convertidos;
3. mostrar pontos de entrada, saida, NPCs e monstros;
4. colocar um personagem placeholder;
5. fazer movimento clique-para-andar.

## 4. Personagem e combate depois do mapa

Depois que o mapa estiver visivel:

1. ler `ipm.json` para entender modelo/personagem;
2. importar um personagem simples;
3. importar uma criatura simples;
4. criar ataque basico local no Godot;
5. so entao conectar com o servidor Python.

## 5. Ordem pratica

1. Fluxo basico no Godot: iniciar, registrar/login, loading e entrar em `ma1.json`.
2. Conversor minimo de um recurso visual usado pelo mapa.
3. Personagem placeholder andando no mapa.
4. Camera, colisao simples e escala correta.
5. Importar retratos `ou0` a `ou6` para tela de selecao.
6. Importar personagem real a partir de `ipm.json`.
7. Conectar login/world server quando o cliente novo ja tiver forma.
