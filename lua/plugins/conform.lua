return { -- Autoformat
  'stevearc/conform.nvim',
  event = { 'BufWritePre' },
  cmd = { 'ConformInfo' },
  opts = {
    format_on_save = {
      timeout_ms = 1000,
      lsp_format = 'fallback', -- "first", "last", "fallback", "prefer", "never"
    },
    notify_on_error = true,
    notify_on_formatters = true,
    formatters_by_ft = {
      lua = { 'stylua' },
      jsonc = { 'jq' },
      json = { 'jq' },
      javascript = { 'prettier' },
      typescript = { 'prettier' },
      vue = { 'prettier' },
      yaml = { 'prettierd' },
      bash = { 'shfmt' },
      java = { 'google-java-format' },
      python = { 'black' },
      php = { 'pretty-php' },
      -- Conform can also run multiple formatters sequentially
      -- python = { "isort", "black" },
    },
  },
}
