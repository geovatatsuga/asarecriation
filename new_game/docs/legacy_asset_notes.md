# Notas De Assets Legados

## Tela De Selecao/Criacao

Simbolos internos do SWF principal:

- `RoleListUI`: `symbol242`
- `RoleListBoxUIMC`: `symbol4865`
- `CreateRoleUI`: `symbol4936`

Retratos grandes das classes:

- `ou0`: Paladino
- `ou1`: Elfo
- `ou2`: Assassino
- `ou3`: Fada
- `ou4`: Sacerdote
- `ou5`: Domador
- `ou6`: Druida

Cada recurso usa:

- `sex0@ouX`
- `sex1@ouX`

Na lista de personagens, a caixa limita o retrato a aproximadamente `400x400`.
Na tela de criacao, o retrato e exibido em escala `0.8`.

## Modelos No Mundo

Arquivo principal:

- `server_py/game_resources/decoded/ipm.json`

Os personagens sao montados por camadas:

- clothes
- hat
- weapon
- shield
- wing
- face
- hair

Equipamentos:

- `server_py/game_resources/decoded/iem.json`
