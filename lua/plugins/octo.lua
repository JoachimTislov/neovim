-- Depends on gh-cli

vim.pack.add {
  'https://github.com/nvim-tree/nvim-web-devicons',
  'https://github.com/nvim-telescope/telescope.nvim',
  'https://github.com/pwntester/octo.nvim',
}

require('octo').setup {
  enable_builtin = true,
}

local keymap = require 'helpers.keymap'

keymap.n('<leader>ooi', '<CMD>Octo issue list<CR>', { desc = '[O]pen [I]ssues' })
keymap.n('<leader>oop', '<CMD>Octo pr list<CR>', { desc = '[O]pen [P]ull requests' })
keymap.n('<leader>ood', '<CMD>Octo discussion list<CR>', { desc = '[O]pen [D]iscussions' })
keymap.n('<leader>oon', '<CMD>Octo notification list<CR>', { desc = '[O]pen [N]otifications' })
keymap.n('<leader>oos', function()
  require('octo.utils').create_base_search_command {
    include_current_repo = true,
  }
end, { desc = '[O]pen [S]earch' })
