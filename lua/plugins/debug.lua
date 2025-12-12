return {
  'mfussenegger/nvim-dap',
  dependencies = {
    'mason-org/mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
    'rcarriga/nvim-dap-ui',
    'nvim-neotest/nvim-nio', -- dependency of dap-ui
    'leoluz/nvim-dap-go',
    'jbyuki/one-small-step-for-vimkind',
  },
  lazy = false,
  config = function()
    local dap = require 'dap'
    local dapui = require 'dapui'
    local widgets = require 'dap.ui.widgets'
    local nmap = require('utils').nmap

    require('mason-nvim-dap').setup {
      automatic_installation = true,
      -- You can provide additional configuration to the handlers,
      -- see mason-nvim-dap README for more information
      handlers = {},
      ensure_installed = {
        'delve',
        'local-lua-debugger-vscode',
      },
    }

    nmap('<leader>dl', function()
      require('osv').launch { port = 8086 }
    end, { desc = 'Debug: Launch lua debug server', noremap = true })
    nmap('<leader>dh', widgets.hover, { desc = 'Debug: Hover', noremap = true })
    nmap('<leader>dp', widgets.preview, { desc = 'Debug: Preview', noremap = true })
    nmap('<leader>df', function()
      widgets.centered_float(widgets.frames)
    end, { desc = 'Debug: View Frames', noremap = true })
    nmap('<leader>ds', function()
      widgets.centered_float(widgets.scopes)
    end, { desc = 'Debug: View Scopes', noremap = true })
    nmap('<leader>dc', dap.continue, { desc = 'Debug: Continue', noremap = true })
    nmap('<leader>dd', dap.disconnect, { desc = 'Debug: Disconnect', noremap = true })
    nmap('<leader>dx', dap.terminate, { desc = 'Debug: Terminate', noremap = true })
    nmap('<leader>dp', dap.pause, { desc = 'Debug: Pause', noremap = true })
    nmap('<leader>di', dap.step_into, { desc = 'Debug: Step into', noremap = true })
    nmap('<leader>do', dap.step_over, { desc = 'Debug: Step over', noremap = true })
    nmap('<leader>de', dap.step_out, { desc = 'Debug: Step out', noremap = true })
    nmap('<leader>db', dap.toggle_breakpoint, { desc = 'Debug: Toggle breakpoint', noremap = true })
    nmap('<leader>dr', dap.clear_breakpoints, { desc = 'Debug: Clear breakpoints', noremap = true })
    nmap('<leader>dB', function()
      dap.set_breakpoint(vim.fn.input 'Breakpoint condition: ')
    end, { desc = 'Debug: Set Breakpoint', noremap = true })
    -- Toggle to see last session result. Without this, you can't see session output in case of unhandled exception.
    nmap('<leader>dt', dapui.toggle, { desc = 'Debug: See last session result.', noremap = true })

    -- For more information, see |:help nvim-dap-ui|
    --- @diagnostic disable: missing-fields
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
      delve = {},
    }
  end,
}
