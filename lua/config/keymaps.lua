--  Is it possible to make this code cleaner?
--  See `<cmd>help vim.keymap.set()`
local utils = require 'utils'
local nmap = utils.nmap
local nvmap = utils.nvmap
local imap = utils.imap
local snoremap = { noremap = true, silent = true }

-- Disable space in normal mode
nmap('<Space>', '<Nop>', snoremap)
nvmap('x', '"_x', snoremap)
nvmap('c', '"_c', snoremap)

-- nmap('D', '0D', { desc = 'Delete line' })

-- Add k or j to the following in order to reset the cursor back to initial position
nmap('oo', 'o<Esc>', snoremap)
nmap('OO', 'O<Esc>', snoremap)

-- Quickfix list navigation
nmap('<M-j>', '<cmd>cnext<cr>')
nmap('<M-k>', '<cmd>cprev<cr>')
nmap('<M-h>', '<cmd>cfirst<cr>')
nmap('<M-l>', '<cmd>clast<cr>')

-- custom gf to open relative paths
-- This was prob a waste of time but its quite nice to use in vue projects
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'vue', 'typescript' },
  callback = function()
    local cwd = vim.fn.getcwd()
    if not cwd:match '/portfolio$' then
      return
    end

    nmap('gf', function()
      local cfile = vim.fn.expand '<cfile>'
      if not cfile:match '/' then
        return
      end
      local current_dir = vim.fn.expand '%:h'

      if cfile:match '^./' then
        cfile = current_dir .. '/' .. cfile:gsub('^./', '')
      end

      while cfile:match '^../' do
        cfile = cfile:gsub('^../', '')
        current_dir = vim.fn.fnamemodify(current_dir, ':h')

        if not cfile:match '^../' then
          cfile = current_dir .. '/' .. cfile
        end
      end

      if cfile:match '^/' then
        -- Assumes the project path is always prefixed with /src
        local src = './src'
        -- handles single router case
        if cfile:match '/router' then
          cfile = src .. '/router/index.ts'
        else
          cfile = src .. cfile
        end
      end

      if vim.fn.filereadable(cfile) == 0 and vim.fn.isdirectory(cfile) == 0 and not cfile:match '%.vue$' then
        -- if there were to ever be reason for two different implicit extensions than good luck
        -- This handles implicit .ts extension
        -- Is naturally only applied if the file isn't found
        cfile = cfile .. '.ts'
      end

      vim.cmd('edit ' .. cfile)
    end, { buffer = true })
  end,
})

nmap('i', function()
  return string.match(vim.api.nvim_get_current_line(), '%g') == nil and 'cc' or 'i'
end, { expr = true, noremap = true })

nmap('<leader>e', '<cmd>q<cr>', { desc = '[E]xit' })
nmap('<leader>qa', '<cmd>qa<cr>', { desc = '[Q]uit [A]ll' })
nmap('<leader>qt', '<cmd>tabc<cr>', { desc = '[Q]uit [T]ab' })
nmap('<leader>qb', '<cmd>bd<cr>', { desc = '[Q]uit [B]uffer' })
nmap('<leader>qf', '<cmd>q!<cr>', { desc = '[Q]uit [F]orce' })

nmap('<leader>w', '<cmd>w<cr>', { desc = '[W]rite to file' })
nmap('<leader>r', '<cmd>source<cr>', { desc = '[R]un - Source file' })
nmap('<leader>m', '<cmd>messages<cr>', { desc = 'View [M]essages' })
nmap('<leader>n', '<cmd>Noice history<cr>', { desc = '[N]oice history' })

nmap('gd', vim.diagnostic.setloclist, { desc = '[D]iagnostic quickfix list' })

nmap('<leader>o', '', { desc = '[O]pen' })
-- Quickfix list
-- See related cmds :copen, :cclose, :cnext, :cprev, :cfirst, :clast
nmap('<leader>oq', '<cmd>copen<cr>', { desc = '[O]pen [Q]uicklist' })
nmap('<leader>on', '<cmd>Neogit<cr>', { desc = '[O]pen [N]eogit' })
nmap('<leader>ot', '<cmd>tabnew<cr>', { desc = '[O]pen [T]ab' })
nmap('<leader>ol', '<cmd>Lazy<cr>', { desc = '[O]pen [L]azy' })
nmap('<leader>om', '<cmd>Mason<cr>', { desc = '[O]pen [M]ason' })
nmap('<leader>ov', '<cmd>vsplit<cr>', { desc = '[O]pen [V]ertical split' })
nmap('<leader>os', '<cmd>split<cr>', { desc = '[O]pen [S]plit (horisontal)' })
nmap('<leader>of', '<cmd>enew<cr>', { desc = '[O]pen [F]ile' })
nmap('<leader>oc', '<cmd>CopilotChatOpen<cr>', { desc = '[O]pen [C]opilot' })
-- https://github.com/meznaric/key-analyzer.nvim?tab=readme-ov-file
nmap('<leader>ok', ':KeyAnalyzer ', { desc = '[O]pen KeyAnalyzer' })
-- nmap('<leader>od', '<cmd>Dashboard<cr>', { desc = '[D]ashboard' })
-- nmap('<leader>ot', '<cmd>terminal<cr>', { desc = '[T]erminal' })

-- Save and load copilot chat on exit and enter
-- vim.api.nvim_create_autocmd('VimLeavePre', {
--   callback = function()
--     vim.cmd 'CopilotChatSave chat'
--   end,
-- })
--
-- vim.api.nvim_create_autocmd('VimEnter', {
--   callback = function()
--     vim.cmd 'CopilotChatLoad chat'
--   end,
-- })

-- Disabled copilot panel as it is not useful and bugs out the folke loader UI
-- nmap('<leader>cP', '<cmd>Copilot panel<cr>', { desc = 'Panel' })
nmap('<leader>ce', '<cmd>Copilot enable<cr>', { desc = 'Enable' })
nmap('<leader>cd', '<cmd>Copilot disable<cr>', { desc = 'Disable' })
nmap('<leader>cp', '<cmd>CopilotChatPrompts<cr>', { desc = 'View/select prompt templates' })
nvmap('<leader>ct', '<cmd>CopilotChatToggle<cr>', { desc = 'Toggle chat window' })
nmap('<leader>cs', '<cmd>CopilotChatStop<cr>', { desc = 'Stop current output' })
nmap('<leader>cm', '<cmd>CopilotChatModels<cr>', { desc = 'View/select available models' })
nmap('<leader>cw', ':CopilotChatSave ', { desc = 'Save chat' })
nmap('<leader>cl', ':CopilotChatLoad ', { desc = 'Load chat' })

-- Remap <Tab> to <S-Tab> for copilot accept to avoid conflict with other plugins
imap('<S-Tab>', 'copilot#Accept("\\<S-Tab>")', { expr = true, replace_keycodes = false })
imap('<C-A-j>', 'copilot#Next()', { expr = true, silent = true, script = true })

-- https://github.com/stevearc/oil.nvim
nmap('<S-h>', '<cmd>Oil<cr>', { desc = 'Open parent directory' })
--  See `<cmd>help hlsearch`
-- Clear highlights on search when pressing <Esc> in normal mode
nmap('<Esc>', '<cmd>nohlsearch<cr>')

-- nmap('<Enter>', ':') conflicts with jumping to sections in README.md file
nvmap('<BS>', '/') -- Start searching with backspace key

-- Exit terminal mode in the builtin terminal with a shortcut
utils.tmap('<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

nmap('<C-d>', '<C-d>zz')
nmap('<C-u>', '<C-u>zz')
nmap('<C-f>', '<C-f>zz')
nmap('<C-b>', '<C-b>zz')

-- TIP<cmd> Disable arrow keys in normal mode
nmap('<left>', '<cmd>echo "Use h to move!!"<cr>')
nmap('<right>', '<cmd>echo "Use l to move!!"<cr>')
nmap('<up>', '<cmd>echo "Use k to move!!"<cr>')
nmap('<down>', '<cmd>echo "Use j to move!!"<cr>')

--  Use CTRL+<hjkl> to switch between windows
--  See `<cmd>help wincmd` for a list of all window commands
nvmap('<C-h>', '<C-w><C-h>', { desc = 'Move focus to the left window' })
nvmap('<C-l>', '<C-w><C-l>', { desc = 'Move focus to the right window' })
nvmap('<C-j>', '<C-w><C-j>', { desc = 'Move focus to the lower window' })
nvmap('<C-k>', '<C-w><C-k>', { desc = 'Move focus to the upper window' })

-- If tmux is running, use the following mappings to navigate between tmux panes and nvim splits seamlessly
nvmap('<C-h>', '<cmd>TmuxNavigateLeft<cr>', { desc = 'Move focus to the left window' })
nvmap('<C-l>', '<cmd>TmuxNavigateRight<cr>', { desc = 'Move focus to the right window' })
nvmap('<C-j>', '<cmd>TmuxNavigateDown<cr>', { desc = 'Move focus to the lower window' })
nvmap('<C-k>', '<cmd>TmuxNavigateUp<cr>', { desc = 'Move focus to the upper window' })

-- Source: https://www.reddit.com/r/neovim/comments/1ftpdt9/comment/lpvh3s8/
-- ignore empty line when deleting or yanking a line
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
