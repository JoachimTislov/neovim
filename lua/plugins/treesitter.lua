return {
  'nvim-treesitter/nvim-treesitter',
  -- Uncomment below to get latest release (broken last time I tried)
  -- lazy = false,
  -- branch = 'main',
  branch = 'master',
  build = ':TSUpdate',
  lazy = true,
  event = { 'BufEnter' },
  opts = {
    -- ~/.local/share/nvim/lazy/nvim-treesitter/parser
    sync_install = true,
    ensure_installed = {
      'go',
      'bash',
      'c',
      'diff',
      'html',
      'lua',
      'luadoc',
      'markdown',
      'markdown_inline',
      'query',
      'vim',
      'vimdoc',
    },
    auto_install = true,
    highlight = {
      enable = true,
      -- Some languages depend on vim's regex highlighting system (such as Ruby) for indent rules.
      --  If you are experiencing weird indenting issues, add the language to
      --  the list of additional_vim_regex_highlighting and disabled languages for indent.
      additional_vim_regex_highlighting = { 'ruby' },
    },
    indent = {
      enable = true,
      disable = { 'ruby' },
    },
  },
  -- There are additional nvim-treesitter modules that you can use to interact
  -- with nvim-treesitter. You should go explore a few and see what interests you:
  -- Incremental selection: Included, see `:help nvim-treesitter-incremental-selection-mod`
  -- Treesitter + textobjects: https://github.com/nvim-treesitter/nvim-treesitter-textobjects
  -- Show your current context: https://github.com/nvim-treesitter/nvim-treesitter-context
  config = function(_, opts)
    vim.filetype.add {
      extension = {
        rasi = 'rasi',
        lua = 'lua',
        vim = 'vim',
        go = 'go',
      },
      pattern = {
        ['.*/waybar/config'] = 'jsonc',
        ['.*/mako/config'] = 'dosini',
        ['.*/kitty/*.conf'] = 'bash',
        ['.*/hypr/.*%.conf'] = 'hyprlang',
        ['.*/zshrc/.*'] = 'bash',
      },
      filename = {
        ['.zshrc'] = 'bash',
        ['.zshenv'] = 'bash',
      },
    }
    require('nvim-treesitter.configs').setup(opts)
  end,
}
