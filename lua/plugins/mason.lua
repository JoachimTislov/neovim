return {
  'mason-org/mason.nvim',
  dependencies = {
    'mason-org/mason-lspconfig.nvim',
    'WhoIsSethDaniel/mason-tool-installer.nvim',
    {
      'j-hui/fidget.nvim',
      opts = {
        notification = {
          window = {
            winblend = 0,
          },
        },
      },
    },
    'saghen/blink.cmp',
  },
  lazy = true,
  config = function()
    require('mason').setup()
    require 'config.autocmds.lsp-attach'
    require 'config.diagnostics'

    local servers = {
      'gopls',
      'laravel_ls',
      'phpactor',
      'lua_ls',
      'jdtls',
      'svelte',
      'tailwindcss',
      -- 'harper_ls', -- annoying
      -- 'codebook', -- annoying
      -- 'vtsls', -- not working well ... alot of errors, provider appears to be missing features
      'ts_ls',
      'vue_ls',
      'bashls',
      'jsonls',
      'cssls',
      'pyright',
      'clangd',
      'rust_analyzer',
      'html-lsp',
      'eslint-lsp',
    }

    require('mason-tool-installer').setup {
      ensure_installed = vim.list_extend(vim.deepcopy(servers), {
        'stylua',
        'prettierd',
        'prettier',
        'pretty-php',
        'shfmt',
        'rustywind',
        'clang-format',
        'jq',
        'google-java-format',
        'black',
        'checkmake',
        'golangci-lint',
        -- 'markdownlint',
        'htmlhint',
        -- 'php-cs-fixer',
      }),
    }

    local utils = require 'utils'
    for _, name in ipairs(servers) do
      utils.setup_ls(name, utils.safe_require('config.lsp.' .. name))
    end
  end,
}
