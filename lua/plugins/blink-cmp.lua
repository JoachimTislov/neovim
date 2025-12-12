return {
  'saghen/blink.cmp',
  event = 'VimEnter',
  version = '1.*',
  dependencies = {
    {
      'L3MON4D3/LuaSnip',
      version = 'v2.*',
      build = 'make install_jsregexp',
      dependencies = {
        {
          -- https://github.com/rafamadriz/friendly-snippets
          'rafamadriz/friendly-snippets',
          config = function()
            require('luasnip.loaders.from_vscode').lazy_load()
          end,
        },
      },
      opts = {},
    },
    'folke/lazydev.nvim',
    -- 'giuxtaposition/blink-cmp-copilot',
  },
  opts = {
    keymap = {
      -- :help ins-completion`
      -- <tab>/<s-tab>: move to right/left of your snippet expansion
      -- <c-space>: Open menu or open docs if already open
      -- <c-n>/<c-p> or <up>/<down>: Select next/previous item
      -- <c-e>: Hide menu
      -- <c-k>: Toggle signature help
      -- See :h blink-cmp-config-keymap for defining your own keymap
      preset = 'default',
      -- For more advanced Luasnip keymaps (e.g. selecting choice nodes, expansion) see:
      --    https://github.com/L3MON4D3/LuaSnip?tab=readme-ov-file#keymaps
    },
    appearance = {
      nerd_font_variant = 'normal',
    },
    completion = {
      documentation = { auto_show = true, auto_show_delay_ms = 500 },
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'lazydev' },
      providers = {
        lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
        -- copilot = {
        --   name = 'copilot',
        --   module = 'blink-cmp-copilot',
        --   score_offset = 100,
        --   async = true,
        -- },
      },
    },
    snippets = { preset = 'luasnip' },
    -- :h blink-cmp-config-fuzzy
    fuzzy = {
      implementation = 'prefer_rust_with_warning',
      prebuilt_binaries = {
        download = true,
      },
    },
    -- Shows a signature help window while you type arguments for a function
    -- :h blink-cmp-config-signature
    signature = { enabled = true },
  },
}
