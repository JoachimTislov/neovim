vim.pack.add {
  -- Analyze your keymaps
  'https://github.com/meznaric/key-analyzer.nvim',
  -- Guess indentation settings
  'https://github.com/NMAC427/guess-indent.nvim',
}

local keymap = require 'helpers.keymap'

require('guess-indent').setup {}
require('key-analyzer').setup()

keymap.n('<leader>ok', ':KeyAnalyzer ', { desc = '[O]pen KeyAnalyzer' })
