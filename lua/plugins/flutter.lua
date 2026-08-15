vim.pack.add { 'https://github.com/nvim-flutter/flutter-tools.nvim' }
-- vim.pack.del { 'flutter-tools.nvim' }
local home = vim.env.HOME .. '/'
require('flutter-tools').setup {
  debugger = {
    enabled = true,
  },
  default_run_args = { flutter = '--flavor development' },
  lsp = {
    settings = {
      analysisExcludedFolders = { home .. 'flutter/packages', home .. '.pub-cache' },
      autoImportCompletions = true,
    },
  },
}
-- vim.lsp.enable 'dcm'
