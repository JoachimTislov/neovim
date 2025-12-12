# Neovim config/setup

I thrive for a minimal setup and utilizing the inbuilt features over external ones.

## TODOs

- Figure out how to select duplicate lines in visual mode selectively, ignoring the rest
    -  
    - https://www.youtube.com/watch?v=9apMF3Dpcuw - 23:20
- Add toggle for relative numbers
- Consider turning on freely moving cursor in normal mode
    -h virtualedit
- Add a tmux Telescope or dmenu list to switch sessions
- Figure out what happend to "recording q state" in status line
- Why is an empty entry blocking the "paste" register?
- Use telescope and oil to open folders
- Add custom [LuaSnip](https://github.com/L3MON4D3/LuaSnip) snippets
- Replace mini statusline with lualine
    - Configure trouble to work with lualine
- Use overseer to run tasks
- Figure out why vtsls is not working
    - https://github.com/yioneko/vtsls/issues/159
- Migrate over to the inbuilt package manager in version 12.0
- Consider switching from Qwerty to programmer Dvorak keyboard layout (unlikely)
    - https://wiki.archlinux.org/title/Dvorak
    - https://www.kaufmann.no/roland/dvorak/
    - https://www.kaufmann.no/roland/dvorak/linux.html
    - training: https://learn.dvorak.nl/

## Resources

- [AI plugins](https://gist.github.com/ColinKennedy/8a0eea1b18b6e22bc10daa64cb47ae9d)
- youtube
    - [Vim Tips I Wish I Knew earlier](https://www.youtube.com/watch?v=5BU2gBOe9RU)
    - [Advanced Vim Workflows](https://www.youtube.com/watch?v=futay9NjOac)

## Plugins Overview

### To Add

https://github.com/zbirenbaum/copilot.lua
https://github.com/olimorris/codecompanion.nvim
https://github.com/ycm-core/YouCompleteMe
https://github.com/nvimdev/lspsaga.nvim
https://github.com/neoclide/coc.nvim?tab=readme-ov-file
    - To host VS Code extensions

### Commented Out (to be removed or reconfigured)

- guess indent (in lazy file)
- dashboard
- avante
- treesitter

### Misc

- https://github.com/MunifTanjim/nui.nvim
- https://github.com/lukas-reineke/indent-blankline.nvim?tab=readme-ov-file
- https://github.com/artemave/workspace-diagnostics.nvim
- https://github.com/stevearc/profile.nvim
- https://github.com/tpope/vim-fugitive
- https://github.com/rcarriga/nvim-notify
- https://github.com/nvim-lualine/lualine.nvim
- https://github.com/hrsh7th/nvim-cmp / currently using blink.cmp ...
- https://github.com/Exafunction/windsurf.nvim
- https://github.com/rachartier/tiny-inline-diagnostic.nvim
- https://github.com/SalOrak/whaler.nvim
- https://github.com/kkharji/sqlite.lua

#### Pickers

- https://github.com/echasnovski/mini.pick
- https://github.com/folke/snacks.nvim/blob/main/docs/picker.md
- https://github.com/nvim-telescope/telescope-ui-select.nvim
- https://github.com/ibhagwan/fzf-lua
