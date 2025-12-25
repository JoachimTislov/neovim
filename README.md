# Neovim 12+ configuration

Compatible with Neovim 0.12 and above. Works on hopyefully all OSes that Neovim supports.

## TODOs

- Use native doc view, not inline by blink.cmp or whatever it is.
    - `vim.diagnostics.opts.float`?
- Add "f" - find, in combination with operators ( d, c, y ) to "do" until specified char.
- setup proper diagnostics workflow
- move between error/warning/hint/info (keybind)
- quickfix list (keybind)
- preview to mini.picker
- project picker and set vim cwd to selected project
- custom config support
- look at old config for forgotten features
- mini, snacks, github prs manager
- explore treesitter built upon features
- web icons
- fzf, cmp (cmp-nvim-lsp?)
- fininsh(/add more) snippets
- figure out how to disabled colored names for colorizer

## Windows specific features

- Syncs wsl clipboard with system clipboard
    - but not powertoys clipboard manager
