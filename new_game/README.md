# New Game

Novo cliente do jogo, separado do projeto Flash legado.

Objetivo inicial:

- Usar Godot 4.6.3 stable.
- Reaproveitar assets, dados e regras do jogo antigo sem misturar arquivos.
- Manter o servidor Python legado funcionando como laboratorio e referencia.
- Criar um cliente 2D limpo, incremental e testavel.

Pastas principais:

- `client_godot/`: projeto Godot.
- `shared_data/`: dados convertidos para uso no cliente novo.
- `server_bridge/`: adaptadores futuros entre Godot e o servidor Python.
- `docs/`: planejamento e descobertas.
- `tools/`: scripts auxiliares.
- `third_party/`: ferramentas portateis, como o Godot baixado.

Regra de ouro: copiar assets do legado para `client_godot/assets/legacy`, nunca mover nem editar o legado diretamente.
