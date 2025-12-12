return { -- Collection of various small independent plugins/modules
  'echasnovski/mini.nvim',
  config = function()
    --  - va)  - [V]isually select [A]round [)]paren
    --  - yinq - [Y]ank [I]nside [N]ext [Q]uote
    --  - ciq  - [C]hange [I]nside [Q]quote
    require('mini.ai').setup { n_lines = 500 }
    require('mini.statusline').setup { use_icons = vim.g.have_nerd_font }
    -- You can configure sections in the statusline by overriding their
    -- default behavior. For example, here we set the section for
    -- cursor location to LINE:COLUMN
    -- statusline.section_diagnostics = function()
    --   return '%2l:%-2v'
    -- end
    --  Check out: https://github.com/echasnovski/mini.nvim
    local misc = require 'mini.misc'
    -- misc.setup_auto_root() TODO: test if project.nvim handles this well enough
    misc.setup_restore_cursor()
  end,
}
