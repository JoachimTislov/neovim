vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.g.copilot_no_tab_map = true
vim.g.have_nerd_font = true
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
vim.o.expandtab = false
vim.o.confirm = true
vim.o.splitbelow = true
vim.o.scrolloff = 15
vim.o.list = true
vim.o.ignorecase = true
vim.o.smartcase = true
vim.o.cursorline = true
vim.opt.listchars = { tab = '▸ ', trail = '·', nbsp = '␣' }
vim.o.updatetime = 250
-- problematic with some plugins
-- vim.opt.autochdir = true
vim.o.chistory = 100
vim.o.lhistory = 100

-- Base url for github isn't abstracted away to allow 'gx'
-- e.g., local url_github = ...
vim.pack.add {
  -- Dependencies of many plugins
  'https://github.com/nvim-lua/plenary.nvim', -- Storage of complete lua functions
  'https://github.com/nvim-mini/mini.icons',

  -- Plugins
  'https://github.com/stevearc/oil.nvim', -- File explorer
  'https://github.com/stevearc/conform.nvim', -- Code formatter
  'https://github.com/nvim-mini/mini.pick', -- Fuzzy picker
  'https://github.com/neovim/nvim-lspconfig', -- LSP configurations
  'https://github.com/williamboman/mason.nvim', -- Installer UI
  'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim', -- Auto install packages
  'https://github.com/lewis6991/gitsigns.nvim', -- Git signs in signcolumn
  'https://github.com/NeogitOrg/neogit', -- Git interface
  'https://github.com/sindrets/diffview.nvim', -- Git diff viewer
  'https://github.com/L3MON4D3/LuaSnip', -- Snippet engine
  'https://github.com/Saghen/blink.cmp', -- Fuzzy completion source
  'https://github.com/folke/which-key.nvim', -- Keybinding helper
  'https://github.com/github/copilot.vim', -- GitHub Copilot
  'https://github.com/CopilotC-Nvim/CopilotChat.nvim', -- AI chat assistant
  'https://github.com/rose-pine/neovim', -- Color scheme
  'https://github.com/MeanderingProgrammer/render-markdown.nvim', -- Markdown renderer
  'https://github.com/windwp/nvim-autopairs', -- Create pairs like (), {}, []
  'https://github.com/windwp/nvim-ts-autotag', -- Auto close and rename html tags
  'https://github.com/nvim-treesitter/nvim-treesitter', -- Treesitter configurations
  'https://github.com/kylechui/nvim-surround', -- Surround text objects
  'https://github.com/catgoose/nvim-colorizer.lua', -- Color highlighter
  'https://github.com/christoomey/vim-tmux-navigator', -- Tmux navigation
  'https://github.com/mfussenegger/nvim-dap', -- Debug Adapter Protocol client
  'https://github.com/igorlfs/nvim-dap-view', -- Minimal DAP UI TODO: Test this
  'https://github.com/rcarriga/nvim-dap-ui', -- UI for nvim-dap
  'https://github.com/nvim-neotest/nvim-nio', -- dependency of nvim-dap-ui
  'https://github.com/leoluz/nvim-dap-go', -- Go adapter

  -- not important but can be nice to have
  'https://github.com/artemave/workspace-diagnostics.nvim', -- Loads diagnostics for all files in workspace
  'https://github.com/j-hui/fidget.nvim', -- LSP status
  'https://github.com/meznaric/key-analyzer.nvim', -- Analyze your keymaps
  'https://github.com/NMAC427/guess-indent.nvim', -- Guess indentation settings
}
require('blink.cmp').setup {
  fuzzy = { implementation = 'lua' },
}
require('fidget').setup()
require('nvim-surround').setup {}
require('mini.icons').setup()
require('guess-indent').setup {}
require('colorizer').setup {
  user_default_options = {
    names = false,
    css = true,
  },
}
-- TODO: Test these two ...
-- require('lspconfig').lua_ls.setup {
--   on_attach = function(client, bufnr)
--     require('workspace-diagnostics').populate_workspace_diagnostics(client, bufnr)
--   end,
-- }
-- Future alternative to workspace-diagnostics.nvim ?
-- vim.lsp.config.ts_ls.on_attach = function(client, bufnr)
--   require('workspace-diagnostics').populate_workspace_diagnostics(client, bufnr)
-- end
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
  file_types = { 'copilot-chat', 'markdown' },
  render_modes = true, -- n, c, t,
  completions = {
    lsp = { enabled = true },
    blink = { enabled = true },
  },
  code = {
    language = false,
  },
}
require('mason').setup()
require('mason-tool-installer').setup {
  ensure_installed = {
    'lua-language-server', -- lua_ls
    'svelte-language-server', -- svelte
    'typescript-language-server', -- ts_ls
    'eslint-lsp', -- eslint
    'json-lsp', -- jsonls
    'gopls',
    'stylua',
    'prettierd',
    'prettier',
    'google-java-format',
  },
}
-- Uses Lspconfig names for servers
vim.lsp.enable { 'lua_ls', 'svelte', 'ts_ls', 'eslint', 'jsonls', 'gopls' }

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

local function autocmd(event, opts)
  vim.api.nvim_create_autocmd(event, opts)
end

-- Sync with system clipboard
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

require('key-analyzer').setup()
nmap('<leader>ok', ':KeyAnalyzer ', { desc = '[O]pen KeyAnalyzer' })

local pick = require 'mini.pick'
pick.setup {
  mappings = {
    toggle_preview = '<Space>',
  },
}

--- [P]ick [P]roject ---
nmap('<leader>pp', function()
  local projects = {}
  local projects_path = vim.fn.expand '~/projects'
  if vim.fn.isdirectory(projects_path) == 1 then
    local dirs = vim.fn.readdir(projects_path)
    for _, dir in ipairs(dirs) do
      table.insert(projects, dir)
    end
  end
  if #projects == 0 then
    vim.notify('No projects found', vim.log.levels.WARN)
    return
  end
  pick.start {
    source = {
      items = projects,
      name = 'Projects',
      choose = function(item)
        vim.cmd('cd ' .. vim.fn.fnameescape(projects_path .. '/' .. item))
        vim.schedule(pick.builtin.files)
      end,
    },
  }
end, { desc = '[P]ick [P]roject' })

--- [P]ick [D]iagnostics ---
nmap('<leader>pd', function()
  local diagnostics = vim.diagnostic.get()
  if #diagnostics == 0 then
    vim.notify('No diagnostics found', vim.log.levels.INFO)
    return
  end

  local items = {}
  for _, diag in ipairs(diagnostics) do
    local filename = vim.fn.fnamemodify(vim.api.nvim_buf_get_name(diag.bufnr), ':.')
    local severity = vim.diagnostic.severity[diag.severity]
    table.insert(items, {
      text = string.format('%s:%d:%d [%s] %s', filename, diag.lnum + 1, diag.col + 1, severity, diag.message),
      bufnr = diag.bufnr,
      lnum = diag.lnum + 1,
      col = diag.col + 1,
    })
  end

  pick.start {
    source = {
      items = items,
      name = 'Diagnostics',
      choose = function(item)
        vim.schedule(function()
          vim.api.nvim_set_current_buf(item.bufnr)
          vim.api.nvim_win_set_cursor(0, { item.lnum, item.col - 1 })
        end)
      end,
    },
  }
end, { desc = '[P]ick [D]iagnostics' })

require('oil').setup {
  columns = {
    'icon',
    'permissions',
    'size',
    'mtime',
  },
  skip_confirm_for_simple_edits = true,
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
      return name == '.git' or name:lower():match 'ntuser'
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
local neogit = require 'neogit'
neogit.setup {
  kind = 'floating',
  integrations = {
    diffview = true,
    mini_pick = true,
  },
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
    { '<leader>d', group = '[D]ebug' },
    { '<leader>l', group = '[L]ist' },
    { '<leader>t', group = '[T]oggle' },
    { '<leader>c', group = '[C]opilot' },
    { '<leader>g', group = '[G]it Hunk', mode = { 'n', 'v' } },
    { '<leader>gr', group = 'Lsp requests' },
  },
}

require('CopilotChat').setup {
  model = 'claude-sonnet-4',
  temperature = 0, -- Lower = focused, higher = creative
  sticky = {
    '#buffer',
    "Don't bullshit me. Be concise. Do not repeat existing code.",
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
imap('<S-Tab>', 'copilot#Accept("\\<CR>")', { expr = true, replace_keycodes = false })
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
nmap('<leader>od', '<cmd>DiffviewOpen<cr>', { desc = '[O]pen [D]iffview' })
nmap('<leader>oM', '<cmd>Mason<cr>', { desc = '[O]pen [M]ason' })
nmap('<leader>on', '<cmd>Neogit<cr>', { desc = '[O]pen [N]eogit' })
nmap('<leader>os', '<cmd>split<cr>', { desc = '[O]pen [S]plit' })
nmap('<leader>ov', '<cmd>vsplit<cr>', { desc = '[O]pen [V]ertical split' })
nmap('<leader>oc', '<cmd>e $MYVIMRC<cr>', { desc = '[O]pen [C]onfig' })
nmap('<leader>om', '<cmd>messages<cr>', { desc = '[O]pen [M]essages' })
nmap('<leader>oq', '<cmd>copen<cr>', { desc = '[O]pen [Q]uickfix list' })
nvmap('<leader>oh', function()
  local word = vim.fn.expand '<cword>'
  print('checking help for ' .. word)
  local ok = pcall(vim.cmd, 'help ' .. word)
  if not ok then
    vim.notify('No manual entry for ' .. word, vim.log.levels.WARN)
  end
end, { desc = '[O]pen [H]elp for selected/current word' })

-- [C]opilot
local copilot_chat = require 'CopilotChat'
nmap('<leader>cp', copilot_chat.select_prompt, { desc = 'View/select [p]rompt templates' })
nvmap('<leader>ct', copilot_chat.toggle, { desc = '[T]oggle chat window' })
nmap('<leader>cs', copilot_chat.stop, { desc = '[S]top current output' })
nmap('<leader>cr', copilot_chat.reset, { desc = '[R]eset chat' })
nmap('<leader>cm', copilot_chat.select_model, { desc = 'View/select available models' })

-- Mini [P]ick
nmap('<leader>pf', pick.builtin.files, { desc = '[P]ick [F]iles' })
nmap('<leader>ph', pick.builtin.help, { desc = '[P]ick [H]elp' })
nmap('<leader>pb', pick.builtin.buffers, { desc = '[P]ick [B]uffers' })
nmap('<leader>pg', pick.builtin.grep_live, { desc = '[P]ick [G]rep' })
nmap('<leader>pc', function()
  local cmd = vim.fn.input 'Command to run > '
  if cmd == '' then
    vim.notify('No command provided', vim.log.levels.WARN)
    return
  end
  pick.builtin.cli { command = vim.split(cmd, ' ') }
end, { desc = '[P]ick [C]ommand' })

-- Actions
vmap('<BS>', 'y/<c-r>"<cr>', { desc = 'Search with selected text' })
nmap('<BS>', '/', { desc = 'Search' })
nmap('<s-h>', '<cmd>Oil<cr>', { desc = 'Oil (File browser)' })
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

-- If tmux is running, use the following mappings to navigate between tmux panes and nvim splits seamlessly
nvmap('<C-h>', '<cmd>TmuxNavigateLeft<cr>')
nvmap('<C-l>', '<cmd>TmuxNavigateRight<cr>')
nvmap('<C-j>', '<cmd>TmuxNavigateDown<cr>')
nvmap('<C-k>', '<cmd>TmuxNavigateUp<cr>')

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

--------------------------
--- Lsp configurations ---
--------------------------

vim.api.nvim_create_autocmd('LspAttach', {
  group = vim.api.nvim_create_augroup('lsp-attach', { clear = true }),
  callback = function(event)
    local map = function(keys, func, desc, mode)
      vim.keymap.set(mode or 'n', keys, func, { buffer = event.buf, desc = desc })
    end
    map('grn', vim.lsp.buf.rename, '[R]e[n]ame')
    map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })
    map('grr', vim.lsp.buf.references, '[G]oto [R]eferences')
    map('gri', vim.lsp.buf.implementation, '[G]oto [I]mplementation')
    map('grd', vim.lsp.buf.definition, '[G]oto [D]efinition')
    map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')
    map('grs', vim.lsp.buf.document_symbol, '[G]oto Document [S]ymbols')
    map('grS', vim.lsp.buf.workspace_symbol, '[G]oto Workspace [S]ymbols')
    map('grw', vim.lsp.buf.workspace_diagnostics, '[G]oto [W]orkspace diagnostics')
    map('grt', vim.lsp.buf.type_definition, '[G]oto [T]ype Definition')
    map('grh', vim.lsp.buf.typehierarchy, '[G]oto Type [H]ierarchy')
  end,
})

---------------------------------------------
--- Debug Adapter Protocol configurations ---
---------------------------------------------

local dap = require 'dap'
local dapui = require 'dapui'
local widgets = require 'dap.ui.widgets'

nmap('<leader>dh', widgets.hover, { desc = 'Debug: Hover' })
nmap('<leader>dp', widgets.preview, { desc = 'Debug: Preview' })
nmap('<leader>df', function()
  widgets.centered_float(widgets.frames)
end, { desc = 'Debug: View Frames' })
nmap('<leader>ds', function()
  widgets.centered_float(widgets.scopes)
end, { desc = 'Debug: View Scopes' })
-- restart and run_last are basically the same, but run_last is more usable
nmap('<leader>dr', dap.run_last, { desc = 'Debug: Run last' })
-- nmap('<leader>dr', dap.restart, { desc = 'Debug: Restart'})
nmap('<leader>dc', dap.continue, { desc = 'Debug: Continue' })
nmap('<leader>dd', dap.disconnect, { desc = 'Debug: Disconnect' })
nmap('<leader>dx', dap.terminate, { desc = 'Debug: Terminate' })
nmap('<leader>dp', dap.pause, { desc = 'Debug: Pause' })
nmap('<leader>di', dap.step_into, { desc = 'Debug: Step into' })
nmap('<leader>do', dap.step_over, { desc = 'Debug: Step over' })
nmap('<leader>de', dap.step_out, { desc = 'Debug: Step out' })
nmap('<leader>du', dap.step_back, { desc = 'Debug: Step back' })
nmap('<leader>db', dap.toggle_breakpoint, { desc = 'Debug: Toggle breakpoint' })
nmap('<leader>dR', dap.clear_breakpoints, { desc = 'Debug: Clear breakpoints' })
nmap('<leader>dB', function()
  dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
end, { desc = 'Debug: Set Breakpoint' })
-- TODO: enable these once I start using Go tests. dt conflicts with restart
-- Need better keybind
-- nmap('<leader>dt', require('dap-go').debug_test, { desc = 'Debug: test'})
-- nmap('<leader>dl', require('dap-go').dapgo.debug_last_test, { desc = 'Debug: Last test' })

-- For more information, see |:help nvim-dap-ui|
dapui.setup {
  icons = { expanded = '▾', collapsed = '▸', current_frame = '*' },
  controls = {
    icons = {
      pause = '⏸',
      play = '▶',
      step_into = '⏎',
      step_over = '⏭',
      step_out = '⏮',
      step_back = 'b',
      run_last = '▶▶',
      terminate = '⏹',
      disconnect = '⏏',
    },
  },
}

dap.configurations.lua = {
  {
    type = 'nlua',
    request = 'attach',
    name = 'Attach to running Neovim instance',
  },
}

dap.adapters.nlua = function(callback, config)
  callback { type = 'server', host = config.host or '127.0.0.1', port = config.port or 8086 }
end

-- Change breakpoint icons
-- vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
-- vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
-- local breakpoint_icons = vim.g.have_nerd_font
--     and { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '', LogPoint = '', Stopped = '' }
--   or { Breakpoint = '●', BreakpointCondition = '⊜', BreakpointRejected = '⊘', LogPoint = '◆', Stopped = '⭔' }
-- for type, icon in pairs(breakpoint_icons) do
--   local tp = 'Dap' .. type
--   local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
--   vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
-- end

dap.listeners.after.event_initialized['dapui_config'] = dapui.open
dap.listeners.before.event_terminated['dapui_config'] = dapui.close
dap.listeners.before.event_exited['dapui_config'] = dapui.close

require('dap-go').setup {
  dap_configurations = {
    {
      type = 'go',
      name = 'Debug Main',
      request = 'launch',
      program = 'main.go',
    },
  },
  delve = {},
}

--------------------------------------
--- Quality of life configurations ---
--------------------------------------

-- insert with indentation on empty lines
nmap('i', function()
  return string.match(vim.api.nvim_get_current_line(), '%g') == nil and 'S' or 'i'
end, { expr = true, noremap = true })

--- wsl, forward copy to windows clipboard ---
--- Note: It does not update the powertools clipboard
--- source: https://www.reddit.com/r/bashonubuntuonwindows/comments/be2q3l/how_do_i_copy_whole_text_from_vim_to_clipboard_at/el2vx7u/?utm_source=share&utm_medium=web2x
local clip = '/mnt/c/Windows/System32/clip.exe'
if vim.fn.executable(clip) == 1 then
  vim.api.nvim_create_augroup('WSLYank', { clear = true })
  vim.api.nvim_create_autocmd('TextYankPost', {
    group = 'WSLYank',
    callback = function()
      if vim.v.event.operator == 'y' then
        vim.fn.system(clip, vim.fn.getreg '0')
      end
    end,
  })
end

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

--- prevent auto inserting comment prefix on new line ---
autocmd('FileType', {
  group = vim.api.nvim_create_augroup('format-options', { clear = true }),
  callback = function()
    vim.opt_local.formatoptions:remove 'o'
  end,
})

--- restore cursor position when reopening files ---
autocmd('BufReadPost', {
  group = vim.api.nvim_create_augroup('restore-cursor', { clear = true }),
  callback = function(args)
    local mark = vim.api.nvim_buf_get_mark(args.buf, '"')
    local lcount = vim.api.nvim_buf_line_count(args.buf)
    if mark[1] > 0 and mark[1] <= lcount then
      if pcall(vim.api.nvim_win_set_cursor, 0, mark) then
        return
      end
      vim.schedule(function()
        vim.cmd 'normal! zz'
      end)
    end
  end,
})

-- equalize window sizes when resizing Neovim window ---
autocmd('VimResized', {
  group = vim.api.nvim_create_augroup('resize-windows', { clear = true }),
  command = 'wincmd =',
})

--- activate dosini treesitter for .env files ---
autocmd('BufRead', {
  group = vim.api.nvim_create_augroup('dotenv-ft', { clear = true }),
  pattern = { '.env.*', '.env' },
  callback = function()
    vim.bo.filetype = 'dosini'
  end,
})

--- enable cursorline ---
autocmd({ 'WinEnter', 'BufEnter' }, {
  group = vim.api.nvim_create_augroup('active-cursorline', { clear = true }),
  callback = function()
    vim.opt_local.cursorline = true
  end,
})

--- disable cursorline
autocmd({ 'WinLeave', 'BufLeave' }, {
  group = vim.api.nvim_create_augroup('inactive-cursorline', { clear = true }),
  callback = function()
    vim.opt_local.cursorline = false
  end,
})
