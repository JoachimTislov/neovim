-- https://github.com/ThePrimeagen/harpoon/tree/harpoon2
return {
  'ThePrimeagen/harpoon',
  branch = 'harpoon2',
  dependencies = { 'nvim-lua/plenary.nvim' },
  opts = {},
  config = function()
    local harpoon = require 'harpoon'
    local nmap = require('utils').nmap

    harpoon:setup {
      settings = {
        save_on_toggle = true,
      },
    }

    -- Initialize
    for i, item in pairs(harpoon:list().items) do
      nmap('<leader>' .. i, function()
        harpoon:list():select(i)
      end, { desc = 'Go to ' .. item.value })
    end

    nmap('<leader>h', function()
      harpoon:list():add()
      local len = harpoon:list():length()
      require('which-key').add {
        lhs = '<leader>' .. len,
        rhs = function()
          harpoon:list():select(len)
        end,
        desc = 'Go to ' .. harpoon:list():get(len).value,
        mode = 'n',
        hidden = false,
      }
    end, { desc = 'Harpoon add' })

    nmap('<C-e>', function()
      local old_list = harpoon:list()
      local old_len = old_list:length()

      harpoon.ui:toggle_quick_menu(old_list)

      local new_list = harpoon:list()
      local new_len = new_list:length()

      -- Ignore if nothing changed
      if new_len == old_len then
        return
      end

      -- Reset keys for files
      for i = 1, old_len do
        require('which-key').add {
          lhs = '<leader>' .. i,
          rhs = function()
            new_list:select(i)
          end,
          mode = 'n',
          hidden = true,
        }
      end
      -- ALTERNATIVE without which-key
      -- if prev_length ~= new_len then
      --   vim.keymap.del('n', '<leader>' .. new_len)
      -- end

      -- Reinitialize
      for i, item in pairs(harpoon:list().items) do
        require('which-key').add {
          lhs = '<leader>' .. i,
          rhs = function()
            harpoon:list():select(i)
          end,
          mode = 'n',
          desc = 'Go to ' .. item.value,
          hidden = false,
        }
      end
    end)
    nmap('<C-S-j>', function()
      harpoon:list():prev()
    end)
    nmap('<C-S-k>', function()
      harpoon:list():next()
    end)
  end,
}
