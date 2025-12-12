vim.o.tabstop = 2 -- Number of visual spaces per tab
vim.o.softtabstop = 2 -- Spaces inserted when pressing Tab
vim.o.shiftwidth = 2 -- Spaces used for auto-indent
vim.o.expandtab = true -- Use spaces instead of tab characters
vim.o.winborder = 'rounded'
vim.o.swapfile = false

-- Remove unreadable path for buffers in tabline
-- I think this can be simplified
-- TODO: Remove when tabs are no longer used
function _G.get_tabline()
  local s = ''
  for tabnr = 1, vim.fn.tabpagenr '$' do
    local winnr = vim.fn.tabpagewinnr(tabnr)
    local bufnr = vim.fn.tabpagebuflist(tabnr)[winnr]
    local bufname = vim.api.nvim_buf_get_name(bufnr)
    local short_name = bufname ~= '' and vim.fn.fnamemodify(bufname, ':t') or '[No Name]'
    if tabnr == vim.fn.tabpagenr() then
      s = s .. '%#TabLineSel#' .. short_name .. ' '
    else
      s = s .. '%#TabLine#' .. short_name .. ' '
    end
  end
  s = s .. '%#TabLineFill#'
  return s
end

vim.o.tabline = '%!v:lua.get_tabline()'

vim.o.termguicolors = true -- enabled to use silkcircuit theme on launch
vim.o.background = 'dark'
-- vim.o.filetype

-- Make line numbers default
vim.o.number = true
vim.o.relativenumber = true

-- vim.o.autochdir = false

-- Enable mouse mode, can be useful for resizing splits for example!
vim.o.mouse = 'a'

-- Don't show the mode, since it's already in the status line
vim.o.showmode = false

vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

vim.o.breakindent = true
vim.o.undofile = true

-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
vim.o.ignorecase = true
vim.o.smartcase = true

-- Keep signcolumn on by default
vim.o.signcolumn = 'yes'

-- Decrease update time
-- vim -r *FileName*
vim.o.updatetime = 250

-- Decrease mapped sequence wait time
-- Default 1000
vim.o.timeoutlen = 160

-- Configure how new splits should be opened
vim.o.splitright = true
vim.o.splitbelow = true
-- Sets how neovim will display certain whitespace characters in the editor.
--  See `:help 'list'`
--  and `:help 'listchars'`
--
--  Notice listchars is set using `vim.opt` instead of `vim.o`.
--  It is very similar to `vim.o` but offers an interface for conveniently interacting with tables.
--   See `:help lua-options`
--   and `:help lua-options-guide`
vim.o.list = true
vim.opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' }

-- Preview substitutions live, as you type!
vim.o.inccommand = 'split'

-- Show which line your cursor is on
vim.o.cursorline = true

-- Minimal number of screen lines to keep above and below the cursor.
vim.o.scrolloff = 10

-- if performing an operation that would fail due to unsaved changes in the buffer (like `:q`),
-- instead raise a dialog asking if you wish to save the current file(s)
-- See `:help 'confirm'`
vim.o.confirm = true
