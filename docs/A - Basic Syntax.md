Tiles are laid out on the grid with their names on a x, y plane, separating by spaces and new lines. `-` or `.` denotes an empty tile.
```
offsetguy yugtesffo
wallw - wallr
```
would give you a 3x2 grid with offsetguy, yugtesffo, and an empty tile on the top row, and a while wall, an empty tile, and a red wall on the bottom row.

Stacking tiles is done with `&`, so `offsetguy&gem` would show offsetguy with a gem on top of it.

All variants are applied using `:` (or `;`, but we'll get to that later). So, if you wanted an `offsetguy` tile that has the variant `blank`, yout would type `offsetguy:blank`.

Variants apply in the order you specify them in. So, for example, `flower:scale2:rot45` scales the tile before rotating it, while `flower:rot45:scale2` rotates the tile before scaling it.