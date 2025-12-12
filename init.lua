--[[
  https://learnxinyminutes.com/docs/lua/
  :help lua-guide
  :help vim.o - Setting options (for options - :help option-list)
  :help gitsigns to understand what the configuration keys do
  normal autocommands events :help autocmd-events.
  :Telescope help_tags
  See `:help telescope` and `:help telescope.setup()`
]]

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.have_nerd_font = true
vim.g.copilot_no_tab_map = true

-- Poor attempt at resolving avante issues at determining project root
-- Best to open nvim from the project root
-- vim.g.root_spec = { { '.git' }, 'lsp', 'cwd' }

-- Theme is specified by two variables to also enable the actual theme on start up
vim.g.theme = 'rose-pine'
vim.g.themeType = 'rose-pine-moon'

require 'config.options'
require 'config.keymaps'
-- require('notify').ignoreMsgs {
--   msgs = {
--     ['No code actions available'] = 1,
--   },
-- }
-- This does not work well
-- ...e/nvim/lazy/noice.nvim/lua/noice/view/backend/notify.lua:168: attempt to call a table value
-- return {
--   ignoreMsgs = function(ignore_msgs)
--     local original_notify = vim.notify
--     ---@diagnostic disable-next-line: duplicate-set-field
--     vim.notify = function(msg, ...)
--       if ignore_msgs[msg] then
--         return
--       end
--       original_notify(msg, ...)
--     end
--   end,
-- }
require 'config.autocmds.yank-highlight'
require 'config.autocmds.copilotBufEnter'
require 'config.autocmds.vue-autoimport'
require 'config.lazy'

vim.api.nvim_set_hl(0, 'CopilotChatHeader', { fg = '#7C3AED', bold = true })
vim.api.nvim_set_hl(0, 'CopilotChatSeparator', { fg = '#848884' })

vim.cmd.colorscheme(vim.g.themeType or vim.g.theme)
