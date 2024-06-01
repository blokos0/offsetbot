Flags are a way of altering the _entire_ render. These are much less organized than variants, but there are less of them. They are specified at the beginning of the command, immediately after the command name. A list of common flags is below:

- `-c` - Combines a render with a replied message's render.
- `-speed=<n>[%]` - Speeds up or slows down the render.
- `-f=<gif|png>` - Alters the destination format of the render. PNGS support true transparency and more than 256 colors, but do not animate inside of Discord.
- `-b=<color>` - Sets the background color of a render, in place of transparency. 
- `-bg=<Background>` - Sets the background of a render, a list of which can be found by running `=search type:background`
- `-m=<n>` - Sets the post-rendering upscale.

Again, this is not a comprehensive list, so make sure to look at the `flags` command for a full list of flags. 