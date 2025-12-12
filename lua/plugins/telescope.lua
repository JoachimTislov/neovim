-- https://github.com/nvim-telescope/telescope.nvim
-- https://github.com/nvim-telescope/telescope.nvim/wiki/Configuration-Recipes#fused-layout
return { -- Fuzzy Finder (files, lsp, etc)
  'nvim-telescope/telescope.nvim',
  event = 'VimEnter',
  dependencies = {
    'nvim-lua/plenary.nvim',
    {
      -- TODO: Filter the projects manually instead of using exclude_dirs
      -- Note that project.nvim does not integrate with oil.nvim
      'ahmedkhalf/project.nvim',
      config = function()
        require('project_nvim').setup {
          detection_methods = { 'pattern' },
          patterns = { '.git', 'Makefile', 'package.json' },
          show_hidden = true,
          exclude_dirs = { '~/.config/nvim' },
        }
      end,
      --[[
          N   I   Action
          f <c-f> find_project_files
          s <c-s> search_in_project_files
          r <c-r> recent_project_files
          w <c-w> change_working_directory
        ]]
    },
    { -- If encountering errors, see telescope-fzf-native README for installation instructions
      'nvim-telescope/telescope-fzf-native.nvim',
      build = 'make',
      cond = function()
        return vim.fn.executable 'make' == 1
      end,
    },
    { 'nvim-telescope/telescope-ui-select.nvim' },
    { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
  },
  config = function()
    local ivy = {
      theme = 'ivy',
      hidden = true,
      layout_config = {
        height = 0.45,
        preview_width = 0.65,
      },
    }
    require('telescope').setup {
      -- TODO: Set ivy as default theme for all pickers with one line in the settings
      -- This is annoying to repeat for every picker
      pickers = {
        find_files = ivy,
        buffers = ivy,
        builtin = ivy,
        git_files = ivy,
        oldfiles = ivy,
        help_tags = ivy,
        keymaps = ivy,
        live_grep = ivy,
        diagnostics = ivy,
        lsp_document_symbols = ivy,
        lsp_dynamic_workspace_symbols = ivy,
        lsp_definitions = ivy,
        lsp_references = ivy,
        colorscheme = ivy,
      },
      extensions = {
        ['ui-select'] = {
          require('telescope.themes').get_ivy(ivy),
        },
        -- ['projects'] = {
        --   require('telescope.themes').get_ivy(ivy),
        -- },
      },
    }
    pcall(require('telescope').load_extension, 'fzf')
    pcall(require('telescope').load_extension, 'projects')
    pcall(require('telescope').load_extension, 'ui-select')

    local nmap = require('utils').nmap
    local builtin = require 'telescope.builtin'
    local function live_grep(dir, desc, open_files)
      if dir == '' then
        dir = vim.fn.getcwd()
      end
      builtin.live_grep {
        cwd = dir,
        grep_open_files = open_files,
        prompt_title = 'Live grep in ' .. desc,
        additional_args = function()
          return { '--hidden' }
        end,
      }
    end
    local function keymap_grep(dir, key, desc, open_files)
      nmap('<leader>sg' .. key, function()
        live_grep(dir, desc, open_files)
      end, { desc = desc })
    end
    keymap_grep('', 'w', '[W]orking directory')
    keymap_grep('~/dotfiles', 'd', '[D]otfiles')
    keymap_grep('~/.config', 'c', '[C]onfig')
    keymap_grep('~/.config/nvim', 'n', '[N]eovim')
    keymap_grep('', 'o', '[O]pen files', true)

    nmap('<leader>st', function()
      builtin.colorscheme { enable_preview = true, previewer = false }
    end, { desc = '[S]elect [T]heme' })
    nmap('<leader>sb', builtin.buffers, { desc = '[S]earch in current [B]uffers' })
    nmap('<leader>sh', builtin.help_tags, { desc = '[S]earch [H]elp' })
    nmap('<leader>sk', builtin.keymaps, { desc = '[S]earch [K]eymaps' })
    nmap('<leader>ss', builtin.builtin, { desc = '[S]earch [S]elect Telescope' })
    nmap('<leader>sw', builtin.grep_string, { desc = '[S]earch current [W]ord' })
    nmap('<leader>sd', builtin.diagnostics, { desc = '[S]earch [D]iagnostics' })
    nmap('<leader>sr', builtin.resume, { desc = '[S]earch [R]esume' })
    nmap('<leader>s.', builtin.oldfiles, { desc = '[S]earch Recent Files ("." for repeat)' })

    local function find_files(key, dir, desc, hidden)
      nmap(key, function()
        builtin.find_files { cwd = (dir ~= '' and dir) or vim.fn.getcwd(), hidden = hidden }
      end, { desc = desc })
    end
    find_files('<leader>sf', '', '[S]earch [F]iles', true)
    find_files('<leader>sc', '~/dotfiles', '[S]earch in dotfiles')
    find_files('<leader>su', '~', '[S]earch in [U]ser home', true)
    find_files('<leader>sn', vim.fn.stdpath 'config', '[S]earch [N]eovim')
    find_files('<leader>sl', '~/.local/share/nvim/lazy', '[S]earch [L]azy')
    find_files('<leader>sm', vim.fn.expand '$MASON', '[S]earch [M]ason packages')

    nmap('<leader>sp', function()
      require('telescope').extensions.projects.projects {
        layout_config = { height = 0.3, width = 0.4 },
      }
    end, { desc = '[S]earch [P]rojects' })
    -- nmap('<leader>sp', telescope.extensions.projects(), { desc = '[S]earch [P]rojects' })
    -- nmap('<leader>n', '<cmd>Telescope notify<CR>', { desc = 'View past notifications' })

    -- It's also possible to pass additional configuration options.
    --  See `:help telescope.builtin.live_grep()` for information about particular keys
  end,
}
