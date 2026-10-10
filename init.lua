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
vim.o.autoindent = true
vim.o.smartindent = true
vim.o.expandtab = false
vim.o.confirm = true
vim.o.splitbelow = true
vim.o.scrolloff = 15
vim.o.list = true
vim.o.ignorecase = true
vim.o.smartcase = false
vim.o.cursorline = true
vim.opt.listchars = { tab = '▸ ', trail = '·', nbsp = '␣' }
vim.o.updatetime = 250
-- problematic with some plugins
-- vim.opt.autochdir = true
vim.o.chistory = 100
vim.o.lhistory = 100
vim.o.termguicolors = true

-- Overview: https://github.com/rockerBOO/awesome-neovim

-- TODOs --
-- Doom emacs? https://github.com/doomemacs/doomemacs
-- Use vim.ui.select?
-- Center buffer view ?
-- Utilize terminal buffers more, e.g., for git or lsp output
-- Consider adding something like ThePrimeagen's 99 or otaleghani/dwight.nvim
-- https://github.com/greggh/claude-code.nvim
-- Replace or add telescope in addition to mini.pick
-- fix typescript ts_ls and svelte ls. Not showing refs in svelte files from ts files
--  - https://github.com/neovim/nvim-lspconfig/issues/725
-- Research native functionality
--  - https://www.reddit.com/r/neovim/comments/1q3tnz5/10_builtin_neovim_features_youre_probably_not/
-- https://www.reddit.com/r/neovim/comments/1pd6pg8/comment/ns4yopi/?context=3
-- https://www.reddit.com/r/neovim/comments/1oq0x3o/comment/nnnuvsz/?context=3
-- https://www.reddit.com/r/neovim/comments/1mxeghf/using_as_a_multipurpose_search_tool/
-- Look into https://github.com/Lanjelin/nvim-docker/blob/main/Dockerfile

-- plugins to consider:
-- https://github.com/doom-neovim/doom-nvim
-- db integration:
-- - https://github.com/zongben/dbout.nvim
-- - https://github.com/tpope/vim-dadbod
-- https://github.com/glacambre/firenvim
-- https://github.com/mistweaverco/kulala.nvim
-- https://github.com/stevearc/profile.nvim
-- https://github.com/folke/snacks.nvim/blob/main/docs/gh.md
-- https://github.com/letieu/jira.nvim
-- https://github.com/nemanjamalesija/smart-paste.nvim
-- https://github.com/enochchau/nvim-pretty-ts-errors
-- https://github.com/Caronte995/spotify-player.nvim
-- https://github.com/sahilsehwag/macrobank.nvim
-----------

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
  'https://github.com/nvim-mini/mini.surround', -- Surround
  'https://github.com/nvim-mini/mini.move',
  'https://github.com/neovim/nvim-lspconfig', -- LSP configurations
  'https://github.com/williamboman/mason.nvim', -- Installer UI
  'https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim', -- Auto install packages
  'https://github.com/lewis6991/gitsigns.nvim', -- Git signs in signcolumn
  'https://github.com/NeogitOrg/neogit', -- Git interface
  'https://github.com/sindrets/diffview.nvim', -- Git diff viewer
  'https://github.com/L3MON4D3/LuaSnip', -- Snippet engine
  'https://github.com/nvim-pack/nvim-spectre', -- Search (ripgrep) and replace (sed)
  -- 'https://github.com/ravitemer/mcphub.nvim', -- servers implementing model context protocol. TODO: remove?

  -- Fuzzy completion source
  -- TODO: replace with https://github.com/hrsh7th/nvim-cmp or vim.ui.select?
  'https://github.com/Saghen/blink.cmp',
  'https://github.com/saghen/blink.lib',

  'https://github.com/folke/which-key.nvim', -- Keybinding helper
  'https://github.com/MeanderingProgrammer/render-markdown.nvim', -- Markdown renderer
  'https://github.com/windwp/nvim-autopairs', -- Create pairs like (), {}, []
  'https://github.com/windwp/nvim-ts-autotag', -- Auto close and rename html tags
  'https://github.com/nvim-treesitter/nvim-treesitter', -- Treesitter configurations
  'https://github.com/catgoose/nvim-colorizer.lua', -- Color highlighter

  -- Color scheme
  'https://github.com/vague-theme/vague.nvim',
  'https://github.com/rose-pine/neovim',

  -- testing and debugging
  'https://github.com/mfussenegger/nvim-dap', -- Debug Adapter Protocol client
  'https://github.com/igorlfs/nvim-dap-view', -- Minimal DAP UI
  'https://github.com/leoluz/nvim-dap-go', -- Go adapter
  'https://github.com/nvim-neotest/nvim-nio', -- Async IO
  'https://github.com/nvim-neotest/neotest', -- Testing framework adapter TODO
  'https://github.com/marilari88/neotest-vitest', -- Neotest adapter for Vitest
}
local keymap = require 'helpers.keymap'

-- require 'plugins.nice-to-have'
require('spectre').setup()
require 'plugins.octo'
require 'plugins.copilot'
require 'plugins.typst'

if os.getenv 'NVIM_FLUTTER' then
  require 'plugins.flutter'
end

local function its_linux()
  return vim.uv.os_uname().sysname == 'Linux'
end

if its_linux() then
  vim.pack.add { 'https://github.com/christoomey/vim-tmux-navigator' } -- Tmux navigation
end

require('blink.cmp').setup {
  fuzzy = { implementation = 'lua' },
}
require('mini.icons').setup()
require('mini.surround').setup()
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

require('nvim-treesitter').install {
  'json',
  'markdown',
  'lua',
  'svelte',
  'scss',
  'css',
  'html',
  'typescript',
  'java',
  'dart',
  'kotlin',
}

vim.api.nvim_create_autocmd('FileType', {
  callback = function(event)
    if event.match == 'svelte' then
      vim.treesitter.start(vim.api.nvim_get_current_buf())
    end
  end,
  desc = 'Temp work around to enable svelte treesitter',
})

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
  file_types = { 'markdown' },
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
    'vtsls',
    -- 'typescript-language-server', -- ts_ls
    'eslint-lsp', -- eslint
    'json-lsp', -- jsonls
    'gopls',
    'stylua',
    'css-lsp', -- cssls
    'prettierd',
    'prettier',
    'google-java-format',
    'clangd',
    'pyright',
  },
}

vim.lsp.config('lua_ls', {
  -- cmd = { vim.fn.stdpath 'data' .. '/mason/bin/lua-language-server' },
  settings = {
    Lua = {
      runtime = { version = 'LuaJIT' },
      workspace = {
        checkThirdParty = false,
        library = { vim.env.VIMRUNTIME },
      },
    },
  },
})

vim.lsp.config('vtsls', {
  settings = {
    vtsls = {
      settings = {
        typescript = {
          updateImportsOnFileMove = {
            enabled = 'always',
          },
        },
        javascript = {
          updateImportsOnFileMove = {
            enabled = 'always',
          },
        },
      },
      tsserver = {
        globalPlugins = {
          {
            name = 'typescript-svelte-plugin',
            location = vim.fn.expand '$MASON/packages/svelte-language-server/node_modules/typescript-svelte-plugin',
            enableForWorkspaceTypeScriptVersions = true,
          },
        },
      },
    },
  },
  filetypes = { 'javascript', 'typescript', 'svelte' },
})

vim.lsp.enable { 'lua_ls', 'vtsls', 'svelte', 'eslint', 'jsonls', 'cssls', 'gopls', 'clangd', 'pyright' }

local function autocmd(event, opts)
  vim.api.nvim_create_autocmd(event, opts)
end

keymap.t('<C-BS>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- TODO: Implement simple management of available known plugins
-- vim.pack bindings
-- local p = vim.pack.get()
-- { 'nvim-treesitter' }
-- for i = 1, #p do
--   for key, val in pairs(p[i]) do
--     print(key, val)
--   end
-- end

keymap.n('<leader>nU', function()
  vim.pack.update()
end, { desc = '[N]eovim [U]pdate plugins' })

-- Sync with system clipboard
vim.schedule(function()
  vim.o.clipboard = 'unnamedplus'
end)

require('neotest').setup {
  adapters = {
    require 'neotest-vitest',
  },
}

local neotest_run = require('neotest').run
local function testRunAttach(location)
  neotest_run.run(location)
  neotest_run.attach()
  vim.cmd 'normal! G'
end

keymap.n('<leader>tr', testRunAttach, { desc = '[T]est [R]un nearest' })
keymap.n('<leader>tf', function()
  testRunAttach(vim.fn.expand '%')
end, { desc = '[T]est run [F]ile' })
keymap.n('<leader>ts', function()
  neotest_run.stop()
end, { desc = '[T]est [S]top' })
keymap.n('<leader>td', function()
  neotest_run.run { strategy = 'dap' }
end, { desc = '[T]est [D]ebug nearest' })

local pick = require 'mini.pick'
pick.setup {
  mappings = {
    -- toggle_preview = '<C-Space>', TODO: rebind
    choose_all = {
      char = '<C-q>',
      func = function()
        local mappings = pick.get_picker_opts().mappings
        vim.api.nvim_input(mappings.mark_all .. mappings.choose_marked)
      end,
    },
  },
}

--- [P]ick [P]roject ---
keymap.n('<leader>pp', function()
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
keymap.n('<leader>pd', function()
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

keymap.n('<leader>pt', function()
  -- TODO: Prevent reading too many files... maybe restrict usage to certain directories
  -- probably best to read path and ensure either parent dir or child dir is named something like 'src', 'project', 'workspace', etc. to prevent accidentally reading entire home directory

  local keywords = { 'TODO', 'FIXME', 'HACK', 'NOTE' }
  local pattern = table.concat(keywords, '|')
  local cmd = { 'rg', '--vimgrep', '--no-heading', '-e', pattern }

  local output = vim.fn.systemlist(cmd)
  if vim.v.shell_error ~= 0 or #output == 0 then
    vim.notify('No TODOs found', vim.log.levels.INFO)
    return
  end

  local items = {}
  for _, line in ipairs(output) do
    local file, lnum, col, text = line:match '^(.+):(%d+):(%d+):(.*)$'
    if file then
      table.insert(items, {
        text = string.format('%s:%s:%s %s', file, lnum, col, vim.trim(text)),
        path = file,
        lnum = tonumber(lnum),
        col = tonumber(col),
      })
    end
  end

  pick.start {
    source = {
      items = items,
      name = 'TODOs',
      choose = function(item)
        vim.schedule(function()
          vim.cmd('edit ' .. vim.fn.fnameescape(item.path))
          vim.api.nvim_win_set_cursor(0, { item.lnum, item.col - 1 })
        end)
      end,
    },
  }
end, { desc = '[P]ick [T]ODOs' })

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

require('mini.move').setup {
  mappings = {
    -- Move visual selection in Visual mode. Defaults are Alt (Meta) + hjkl.
    left = '<C-M-h>',
    right = '<C-M-l>',
    down = '<C-M-j>',
    up = '<C-M-k>',

    -- Move current line in Normal mode
    line_left = '<C-M-h>',
    line_right = '<C-M-l>',
    line_down = '<C-M-j>',
    line_up = '<C-M-k>',
  },

  -- Options which control moving behavior
  options = {
    -- Automatically reindent selection during linewise vertical move
    reindent_linewise = true,
  },
}

require('conform').setup {
  format_on_save = {
    timeout_ms = 1000,
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
    zsh = { 'shfmt' },
    kt = { 'ktfmt' },
    c = { 'clang-format' },
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
  styles = {
    transparency = true,
    bold = true,
    italic = false,
  },
}
require('vague').setup {
  transparent = true,
  italic = false,
}

local theme = os.getenv 'NVIM_THEME' or 'vague'
vim.cmd.colorscheme(theme)
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
    { '<leader>d', group = '[D]iffView' },
    { '<leader>l', group = '[L]ist' },
    { '<leader>t', group = '[T]est' },
    { '<leader>c', group = '[C]opilot' },
    { '<leader>g', group = '[G]it Hunk', mode = { 'n', 'v' } },
    { 'gr', group = 'Lsp requests' },
  },
}

--- LuaSnip keymaps ---

local ls = require 'luasnip'

keymap.i('<C-k>', function()
  if ls.expand_or_jumpable() then
    ls.expand_or_jump()
  end
end, { silent = true })
keymap.is('<C-j>', function()
  if ls.jumpable(-1) then
    ls.jump(-1)
  end
end, { silent = true })
keymap.i('<C-l>', function()
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
    keymap.v('<leader>gs', function()
      gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' }
    end, { desc = 'git [s]tage hunk' })
    keymap.v('<leader>gr', function()
      gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' }
    end, { desc = 'git [r]eset hunk' })
    -- normal mode
    keymap.n('<leader>gs', gitsigns.stage_hunk, { desc = 'git [s]tage hunk' })
    keymap.n('<leader>gr', gitsigns.reset_hunk, { desc = 'git [r]eset hunk' })
    keymap.n('<leader>gS', gitsigns.stage_buffer, { desc = 'git [S]tage buffer' })
    keymap.n('<leader>gu', gitsigns.stage_hunk, { desc = 'git [u]ndo stage hunk' })
    keymap.n('<leader>gR', gitsigns.reset_buffer, { desc = 'git [R]eset buffer' })
    keymap.n('<leader>gp', gitsigns.preview_hunk, { desc = 'git [p]review hunk' })
    keymap.n('<leader>gb', gitsigns.blame_line, { desc = 'git [b]lame line' })
    keymap.n('<leader>gd', gitsigns.diffthis, { desc = 'git [d]iff against index' })
    keymap.n('<leader>gD', function()
      --- @diagnostic disable-next-line: param-type-mismatch
      gitsigns.diffthis '@'
    end, { desc = 'git [D]iff against last commit' })
    -- Toggles
    keymap.n('<leader>tb', gitsigns.toggle_current_line_blame, { desc = '[T]oggle git show [b]lame line' })
    keymap.n('<leader>tD', gitsigns.preview_hunk_inline, { desc = '[T]oggle git show [D]eleted' })
  end,
}

-- [Q]uit
keymap.n('<leader>qa', '<cmd>qa<cr>', { desc = '[Q]uit [A]ll' })
keymap.n('<leader>qt', '<cmd>tabc<cr>', { desc = '[Q]uit [T]ab' })
keymap.n('<leader>qb', '<cmd>bd<cr>', { desc = '[Q]uit [B]uffer' })
keymap.n('<leader>qf', '<cmd>q!<cr>', { desc = '[Q]uit [F]orce' })

-- Diff against all changes since previous commit
local dv = require 'diffview'
keymap.n('<leader>DC', function()
  dv.open { 'HEAD~1' }
end, { desc = '[D]iff against previous [C]ommit' })

-- Show all uncommitted changes
keymap.n('<leader>Dc', function()
  dv.open { 'HEAD', '--cache' }
end, { desc = '[D]iff against uncommitted [c]hanges' })

-- Close diffview
keymap.n('<leader>De', '<cmd>DiffviewClose<cr>', { desc = '[D]iff against uncommitted [c]hanges' })

-- [O]pen
keymap.n('<leader>ot', '<cmd>terminal<cr>', { desc = '[O]pen [T]erminal' })
keymap.n('<leader>oT', '<cmd>InspectTree<cr>', { desc = '[O]pen [T]erminal' })
-- map.n('<leader>oH', '<cmd>MCPHub<cr>', { desc = '[O]pen MCP [H]ub' })
keymap.n('<leader>od', '<cmd>DiffviewOpen<cr>', { desc = '[O]pen [D]iffview' })
keymap.n('<leader>oM', '<cmd>Mason<cr>', { desc = '[O]pen [M]ason' })
keymap.n('<leader>on', '<cmd>Neogit<cr>', { desc = '[O]pen [N]eogit' })
keymap.n('<leader>os', '<cmd>split<cr>', { desc = '[O]pen [S]plit' })
keymap.n('<leader>ov', '<cmd>vsplit<cr>', { desc = '[O]pen [V]ertical split' })
keymap.n('<leader>oc', '<cmd>e $MYVIMRC<cr>', { desc = '[O]pen [C]onfig' })
keymap.n('<leader>om', '<cmd>messages<cr>', { desc = '[O]pen [M]essages' })
keymap.n('<leader>oq', '<cmd>copen<cr>', { desc = '[O]pen [Q]uickfix list' })
keymap.nv('<leader>oh', function()
  local word = vim.fn.expand '<cword>'
  print('checking help for ' .. word)
  ---@diagnostic disable-next-line: param-type-mismatch ---supports string, but type is set to table
  local ok = pcall(vim.cmd, 'help ' .. word)
  if not ok then
    vim.notify('No manual entry for ' .. word, vim.log.levels.WARN)
  end
end, { desc = '[O]pen [H]elp for selected/current word' })

-- Mini [P]ick
keymap.n('<leader>pf', pick.builtin.files, { desc = '[P]ick [F]iles' })
keymap.n('<leader>ph', pick.builtin.help, { desc = '[P]ick [H]elp' })
keymap.n('<leader>pb', pick.builtin.buffers, { desc = '[P]ick [B]uffers' })
keymap.n('<leader>pg', pick.builtin.grep_live, { desc = '[P]ick [G]rep' })
keymap.n('<leader>pc', function()
  local cmd = vim.fn.input 'Command to run > '
  if cmd == '' then
    vim.notify('No command provided', vim.log.levels.WARN)
    return
  end
  pick.builtin.cli { command = vim.split(cmd, ' ') }
end, { desc = '[P]ick [C]ommand' })

-- Actions
keymap.v('<BS>', 'y/<c-r>"<cr>', { desc = 'Search with selected text' })
-- keymap.v('<CR>', 'y:<c-r>"<cr>')
keymap.n('<BS>', '/', { desc = 'Search' })
-- map.n('<Enter>', ':', { desc = 'Search' }) INFO: crashes with Quickfix list
keymap.n('<s-h>', '<cmd>Oil<cr>', { desc = 'Oil (File browser)' })
keymap.n('<leader>e', '<cmd>q<cr>', { desc = '[E]xit' })
keymap.n('<leader>w', '<cmd>w<cr>', { desc = 'Write to file' })
keymap.n('<leader>s', ':source<cr>')

-- Clear highlights on search when pressing <Esc> in normal mode
keymap.n('<Esc>', '<cmd>nohlsearch<cr>')

-- Navigate between windows
keymap.nv('<C-j>', '<C-W>j')
keymap.nv('<C-k>', '<C-W>k')
keymap.nv('<C-l>', '<C-W>l')
keymap.nv('<C-h>', '<C-W>h')

-- Center editor view with zz
keymap.nv('<C-d>', '<C-d>zz')
keymap.nv('<C-u>', '<C-u>zz')
keymap.nv('<C-f>', '<C-f>zz')
keymap.nv('<C-b>', '<C-b>zz')

-- Quickfix list navigation
-- Only works for systems respecting alt (meta) key
-- Alt is encoded to Esc on Windows, use ]/[ and q/Q instead to maneuver the qf list
if its_linux() then
  keymap.nv('<M-j>', '<cmd>cnext<cr>')
  keymap.nv('<M-k>', '<cmd>cprev<cr>')
  keymap.nv('<M-h>', '<cmd>cfirst<cr>')
  keymap.nv('<M-l>', '<cmd>clast<cr>')
end

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
local dapgo = require 'dap-go'

dapgo.setup {
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
-- https://igorlfs.github.io/nvim-dap-view/home
local dapview = require 'dap-view'
keymap.n('<leader>dv', dapview.toggle, { desc = 'Debug: Open [v]iew' })
-- restart and run_last are basically the same, but run_last is more usable
keymap.n('<leader>dr', dap.run_last, { desc = 'Debug: Run last' })
-- map.n('<leader>dr', dap.restart, { desc = 'Debug: Restart'})
keymap.n('<leader>dc', dap.continue, { desc = 'Debug: Continue' })
keymap.n('<leader>dd', dap.disconnect, { desc = 'Debug: Disconnect' })
keymap.n('<leader>dx', dap.terminate, { desc = 'Debug: Terminate' })
keymap.n('<leader>dp', dap.pause, { desc = 'Debug: Pause' })
keymap.n('<leader>di', dap.step_into, { desc = 'Debug: Step into' })
keymap.n('<leader>do', dap.step_over, { desc = 'Debug: Step over' })
keymap.n('<leader>de', dap.step_out, { desc = 'Debug: Step out' })
keymap.n('<leader>du', dap.step_back, { desc = 'Debug: Step back' })
keymap.n('<leader>db', dap.toggle_breakpoint, { desc = 'Debug: Toggle breakpoint' })
keymap.n('<leader>dR', dap.clear_breakpoints, { desc = 'Debug: Clear breakpoints' })
keymap.n('<leader>dB', function()
  dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
end, { desc = 'Debug: Set Breakpoint' })
-- TODO: enable these once I start using Go tests. 'dt' conflicts with restart
-- Need better keybind
-- map.n('<leader>dt', require('dap-go').debug_test, { desc = 'Debug: test'})
-- map.n('<leader>dl', require('dap-go').dapgo.debug_last_test, { desc = 'Debug: Last test' })

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
vim.api.nvim_set_hl(0, 'DapBreak', { fg = '#e51400' })
vim.api.nvim_set_hl(0, 'DapStop', { fg = '#ffcc00' })
for type, icon in pairs { Breakpoint = '', BreakpointCondition = '', BreakpointRejected = '⊘', LogPoint = '', Stopped = '' } do
  local tp = 'Dap' .. type
  local hl = (type == 'Stopped') and 'DapStop' or 'DapBreak'
  vim.fn.sign_define(tp, { text = icon, texthl = hl, numhl = hl })
end

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
keymap.n('i', function()
  return string.match(vim.api.nvim_get_current_line(), '%g') == nil and 'cc' or 'i'
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

if vim.fn.has 'win32' == 1 then
  keymap.n('<leader>oc', '<cmd>e $DOTFILES<cr>', { desc = '[O]pen [C]onfig' })
end

if its_linux() then
  -- If tmux is running, use the following mappings to navigate between tmux panes and nvim splits seamlessly
  keymap.nv('<C-h>', '<cmd>TmuxNavigateLeft<cr>')
  keymap.nv('<C-l>', '<cmd>TmuxNavigateRight<cr>')
  keymap.nv('<C-j>', '<cmd>TmuxNavigateDown<cr>')
  keymap.nv('<C-k>', '<cmd>TmuxNavigateUp<cr>')
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

vim.api.nvim_create_autocmd('TextYankPost', {
  desc = 'Highlight when yanking (copying) text',
  group = vim.api.nvim_create_augroup('highlight-yank', { clear = true }),
  callback = function()
    vim.hl.on_yank()
  end,
})

local snoremap = { noremap = true, silent = true }

-- Disable space
keymap.nv('<Space>', '<Nop>', snoremap)

-- Disable deprecate messages
---@diagnostic disable-next-line: duplicate-set-field
vim.deprecate = function() end

-- Omit chars consumed by the x and c operator
keymap.nv('x', '"_x', snoremap)
keymap.nv('c', '"_c', snoremap)

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

keymap.n('yy', function()
  handle_yank_delete 'yy'
end, snoremap)
keymap.n('dd', function()
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
    -- vim.opt_local.cursorline = false
  end,
})
