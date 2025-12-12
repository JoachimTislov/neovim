vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.copilot_no_tab_map = true
vim.g.have_nerd_font = true -- FiraCode
vim.o.wrap = true
vim.o.winborder = 'rounded'
vim.swapfile = false
vim.o.splitright = true
vim.o.number = true
vim.o.relativenumber = true
vim.o.signcolumn = 'yes'
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.confirm = true
vim.o.splitbelow = true
vim.o.scrolloff = 15
vim.o.list = true
vim.opt.listchars = { tab = '▸ ', trail = '·' }

vim.pack.add {
  'https://github.com/folke/lazydev.nvim',
  'https://github.com/nvim-lua/plenary.nvim', -- dependency of many plugins. Storage of complete lua functions
  'https://github.com/stevearc/oil.nvim',
  'https://github.com/stevearc/conform.nvim',
  'https://github.com/echasnovski/mini.pick',
  'https://github.com/neovim/nvim-lspconfig',
  'https://github.com/williamboman/mason.nvim',
  'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim',
  'https://github.com/NeogitOrg/neogit',
  'https://github.com/sindrets/diffview.nvim',
  'https://github.com/L3MON4D3/LuaSnip',
  'https://github.com/Saghen/blink.cmp',
  'https://github.com/folke/which-key.nvim',
  'https://github.com/CopilotC-Nvim/CopilotChat.nvim',
  'https://github.com/rose-pine/neovim',
  'https://github.com/MeanderingProgrammer/render-markdown.nvim',
  'https://github.com/windwp/nvim-autopairs',
  'https://github.com/windwp/nvim-ts-autotag',
  'https://github.com/nvim-treesitter/nvim-treesitter',
  'https://github.com/catgoose/nvim-colorizer.lua',
  'https://github.com/artemave/workspace-diagnostics.nvim',
  'https://github.com/github/copilot.vim',
  'https://github.com/lewis6991/gitsigns.nvim',
}
require('blink.cmp').setup {
  fuzzy = { implementation = 'lua' },
}

require('colorizer').setup()
require('workspace-diagnostics').setup()
require('nvim-treesitter.configs').setup {
  ensure_installed = { 'markdown', 'lua', 'svelte', 'css', 'html', 'typescript', 'java' },
  auto_install = true,
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
}
require('nvim-treesitter').setup()
require('nvim-autopairs').setup()
require('nvim-ts-autotag').setup()
require('rose-pine').setup {
  styles = {
    bold = true,
    italic = false,
    transparency = true,
  },
}
require('render-markdown').setup {
  file_types = { 'copilot-chat' },
}

require('mason').setup()
require('mason-tool-installer').setup {
  ensure_installed = {
    'lua-language-server', -- lua_ls
    'svelte-language-server', -- svelte
    'typescript-language-server', -- ts_ls
    'eslint-lsp', -- eslint
    'stylua',
    'prettierd',
    'prettier',
    'google-java-format',
  },
}
-- Uses Lspconfig names for servers
vim.lsp.enable { 'lua_ls', 'svelte', 'ts_ls', 'eslint' }

-- Keymaps --
local function k(mode, key, func, opts)
  vim.keymap.set(mode, key, func, opts or {})
end

local function nvmap(...)
  k({ 'n', 'v', 'x' }, ...)
end

local function ismap(...)
  k({ 'i', 's' }, ...)
end

local function nmap(...)
  k('n', ...)
end

local function vmap(...)
  k('v', ...)
end

local function imap(...)
  k('i', ...)
end

-- Sync with system clipboard
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

require('mini.pick').setup()
require('oil').setup {
  columns = {
    'icon',
    'permissions',
    'size',
    'mtime',
  },
  keymaps = {
    ['<C-h>'] = false,
    ['<C-l>'] = false,
    ['<S-l>'] = { 'actions.select', mode = 'n' },
  },
  view_options = {
    show_hidden = true,
    is_hidden_file = function(name)
      local m = name:match '^%.'
      return m ~= nil
    end,
    is_always_hidden = function(name)
      return name == '.git'
    end,
  },
}
require('conform').setup {
  format_on_save = {
    timeout_ms = 500,
    lsp_format = 'fallback', -- "first", "last", "fallback", "prefer", "never"
  },
  notify_on_error = true,
  notify_on_formatters = true,
  formatters_by_ft = {
    lua = { 'stylua' },
    javascript = { 'prettier' },
    typescript = { 'prettier' },
    svelte = { 'prettier' },
    yaml = { 'prettierd' },
    java = { 'google-java-format' },
  },
}
require('neogit').setup {
  kind = 'floating',
}
require('rose-pine').setup {
  -- https://github.com/rose-pine/neovim
  styles = {
    transparency = true,
    bold = true,
    italic = false,
  },
}
vim.cmd.colorscheme 'rose-pine'
vim.cmd ':hi statusline guibg=NONE'

require('which-key').setup {
  delay = 500,
  icons = { mappings = vim.g.have_nerd_font },
  win = {
    no_overlap = false,
  },
  spec = {
    { '<leader>q', group = '[Q]uit' },
    { '<leader>p', group = '[P]ick' },
    { '<leader>o', group = '[O]pen' },
    { '<leader>c', group = '[C]opilot' },
    { '<leader>g', group = '[G]it Hunk', mode = { 'n', 'v' } },
  },
}

require('CopilotChat').setup {
  model = 'claude-sonnet-4',
  temperature = 0, -- Lower = focused, higher = creative
  sticky = {
    '#buffer',
  },
  highlight_headers = false,
  auto_fold = true,
  auto_insert_mode = false,
  mappings = {
    reset = false,
  },
  headers = {
    user = ' ',
    assistant = ' ',
    tool = '󰊳 ',
  },
  separator = '━━',
  window = {
    layout = 'vertical', -- 'vertical', 'horizontal', 'float', 'replace'
    -- width = 0.5, -- 50% of screen width
    border = 'solid', -- 'single', 'double', 'rounded', 'solid'
  },
}

-- Remap <Tab> to <S-Tab> for copilot accept to avoid conflict with other plugins
imap('<S-Tab>', 'copilot#Accept("\\<S-Tab>")', { expr = true, replace_keycodes = false })
imap('<C-A-j>', 'copilot#Next()', { expr = true, silent = true, script = true })

--- LuaSnip keymaps ---

local ls = require 'luasnip'

imap('<C-k>', function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })
ismap('<C-j>', function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })
imap('<C-l>', function()
  if ls.choice_active() then
    ls.change_choice(1)
  end
end)

-----------------------

require('gitsigns').setup {
  signs = {
    add = { text = '+' },
    change = { text = '~' },
    delete = { text = '_' },
    topdelete = { text = '‾' },
    changedelete = { text = '~' },
  },
  on_attach = function(bufnr)
    local gitsigns = require 'gitsigns'

    local function map(mode, l, r, opts)
      opts.buffer = bufnr
      vim.keymap.set(mode, l, r, opts or {})
    end

    -- Navigation
    map('n', ']c', function()
      if vim.wo.diff then
        vim.cmd.normal { ']c', bang = true }
      else
        --- @diagnostic disable-next-line: param-type-mismatch
        gitsigns.nav_hunk 'next'
      end
    end, { desc = 'Jump to next git [c]hange' })

    map('n', '[c', function()
      if vim.wo.diff then
        vim.cmd.normal { '[c', bang = true }
      else
        --- @diagnostic disable-next-line: param-type-mismatch
        gitsigns.nav_hunk 'prev'
      end
    end, { desc = 'Jump to previous git [c]hange' })

    -- Actions
    -- visual mode
    vmap('<leader>gs', function()
      gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
    end, { desc = 'git [s]tage hunk' })
    vmap('<leader>gr', function()
      gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
    end, { desc = 'git [r]eset hunk' })
    -- normal mode
    nmap('<leader>gs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
    nmap('<leader>gr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
    nmap('<leader>gS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
    nmap('<leader>gu', gitsigns.stage_hunk, { desc = 'git [u]ndo stage hunk' })
    nmap('<leader>gR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
    nmap('<leader>gp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
    nmap('<leader>gb', gitsigns.blame_line, { desc = 'git [b]lame line' })
    nmap('<leader>gd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
    nmap('<leader>gD', function()
      --- @diagnostic disable-next-line: param-type-mismatch
      gitsigns.diffthis '@'
    end, { desc = 'git [D]iff against last commit' })
    -- Toggles
    nmap('<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
    nmap('<leader>tD', gitsigns.preview_hunk_inline, { desc = '[T]oggle git show [D]eleted' })
  end,
}

-- [Q]uit
nmap('<leader>qa', '<cmd>qa<cr>', { desc = '[Q]uit [A]ll' })
nmap('<leader>qt', '<cmd>tabc<cr>', { desc = '[Q]uit [T]ab' })
nmap('<leader>qb', '<cmd>bd<cr>', { desc = '[Q]uit [B]uffer' })
nmap('<leader>qf', '<cmd>q!<cr>', { desc = '[Q]uit [F]orce' })

-- [O]pen
nmap('<leader>om', '<cmd>messages<cr>', { desc = '[O]pen [M]essages' })
nmap('<leader>oq', '<cmd>copen<cr>', { desc = '[O]pen [Q]uicklist' })
nmap('<leader>om', '<cmd>Mason<cr>', { desc = '[O]pen [M]ason' })
nmap('<leader>on', '<cmd>Neogit<cr>', { desc = '[O]pen [N]eogit' })
nmap('<leader>os', '<cmd>split<cr>', { desc = '[O]pen [S]plit' })
nmap('<leader>ov', '<cmd>vsplit<cr>', { desc = '[O]pen [V]ertical split' })
nmap('<leader>oc', '<cmd>e $MYVIMRC<cr>', { desc = '[O]pen [C]onfig' })

-- [C]opilot
nmap('<leader>cp', '<cmd>CopilotChatPrompts<cr>', { desc = 'View/select prompt templates' })
nmap('<leader>ct', '<cmd>CopilotChatToggle<cr>', { desc = 'Toggle chat window' })
nmap('<leader>cs', '<cmd>CopilotChatStop<cr>', { desc = 'Stop current output' })
nmap('<leader>cm', '<cmd>CopilotChatModels<cr>', { desc = 'View/select available models' })
nmap('<leader>cw', ':CopilotChatSave ', { desc = 'Save chat' })
nmap('<leader>cl', ':CopilotChatLoad ', { desc = 'Load chat' })

-- [P]ick
nmap('<leader>pf', '<cmd>Pick files<cr>', { desc = '[P]ick [F]iles' })
nmap('<leader>ph', '<cmd>Pick help<cr>', { desc = '[P]ick [H]elp' })
nmap('<leader>pb', '<cmd>Pick buffers<cr>', { desc = '[P]ick [B]uffers' })

-- Actions
nmap('<s-h>', '<cmd>Oil<cr>', { desc = 'Oil (File browser)' })
nmap('<leader>lf', vim.lsp.buf.format, { desc = 'Format file' })
nmap('<leader>e', '<cmd>q<cr>', { desc = '[E]xit' })
nmap('<leader>w', '<cmd>w<cr>', { desc = 'Write to file' })
nmap('<leader>s', ':source<cr>')

-- Copilot
nmap('<leader>ce', '<cmd>Copilot enable<cr>', { desc = 'Enable' })
nmap('<leader>cd', '<cmd>Copilot disable<cr>', { desc = 'Disable' })

-- Clear highlights on search when pressing <Esc> in normal mode
nmap('<Esc>', '<cmd>nohlsearch<cr>')

-- Navigate between windows
nvmap('<C-j>', '<C-W>j')
nvmap('<C-k>', '<C-W>k')
nvmap('<C-l>', '<C-W>l')
nvmap('<C-h>', '<C-W>h')

-- Center editor view with zz
nvmap('<C-d>', '<C-d>zz')
nvmap('<C-u>', '<C-u>zz')
nvmap('<C-f>', '<C-f>zz')
nvmap('<C-b>', '<C-b>zz')

-- Quickfix list navigation
nvmap('<M-j>', '<cmd>cnext<cr>')
nvmap('<M-k>', '<cmd>cprev<cr>')
nvmap('<M-h>', '<cmd>cfirst<cr>')
nvmap('<M-l>', '<cmd>clast<cr>')

------------------------------------
-- Quality of life configurations --
------------------------------------

vim.diagnostic.config {
  severity_sort = true,
  virtual_lines = false,
  float = {
    border = 'rounded',
    source = 'if_many',
  },
  signs = vim.g.have_nerd_font and {
    spacing = 2,
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  } or {},
}

vim.api.nvim_create_autocmd('BufEnter', {
  pattern = 'copilot-*',
  callback = function()
    vim.opt_local.relativenumber = false
    vim.opt_local.number = false
    vim.opt_local.conceallevel = 0
  end,
})

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

local snoremap = { noremap = true, silent = true }

-- Disable space
nvmap('<Space>', '<Nop>', snoremap)

-- Disable deprecate messages
vim.deprecate = function() end

-- Omit chars consumed by the x and c operator
nvmap('x', '"_x', snoremap)
nvmap('c', '"_c', snoremap)

-- ignore empty line when deleting or yanking a line
-- Source: https://www.reddit.com/r/neovim/comments/1ftpdt9/comment/lpvh3s8/
local function handle_yank_delete(key)
  local line = vim.fn.getline '.'
  if key == 'yy' and line ~= '' then
    vim.cmd 'normal! yy'
  elseif key == 'dd' then
    if line:match '^%s*$' then
      vim.api.nvim_feedkeys('"_dd', 'n', false)
    else
      vim.cmd 'normal! dd'
    end
  end
end

nmap('yy', function()
  handle_yank_delete 'yy'
end, snoremap)
nmap('dd', function()
  handle_yank_delete 'dd'
end, snoremap)

-- Override the handler to filter out unwanted diagnostics
local lsp_symbols_filters = {
  lua_ls = {
    global = {
      'vim',
      'error',
      'string',
      'tostring',
      'pcall',
      'os_uname',
      'os',
    },
    field = {
      'fs_stat',
    },
  },
}

vim.lsp.handlers['textDocument/publishDiagnostics'] = function(err, result, ctx)
  local client = vim.lsp.get_client_by_id(ctx.client_id)
  if not result or not client then
    return
  end

  -- Apply filters for certain lsps (mainly for lua_ls)
  if lsp_symbols_filters[client.name] then
    result.diagnostics = vim.tbl_filter(function(diagnostic)
      for kind, symbols in pairs(lsp_symbols_filters[client.name]) do
        for _, name in ipairs(symbols) do
          if diagnostic.message:match(string.format('Undefined %s `%s`', kind, name)) then
            return false
          end
        end
      end
      return true
    end, result.diagnostics)
  end

  -- Use default handler
  vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx)
end
