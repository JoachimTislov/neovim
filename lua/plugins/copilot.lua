vim.pack.add { 'https://github.com/github/copilot.vim' }

local keymap = require 'helpers.keymap'

-- Remap <Tab> to <S-Tab> for copilot accept to avoid conflict with other plugins
keymap.i('<S-Tab>', 'copilot#Accept("\\<S-Tab>")', { expr = true, replace_keycodes = false })
keymap.i('<C-A-j>', 'copilot#Next()', { expr = true, silent = true, script = true })
keymap.n('<leader>ce', ':Copilot enable<cr>', { desc = '[C]opilot Enable' })
keymap.n('<leader>cd', ':Copilot disable<cr>', { desc = '[C]opilot Disable' })
