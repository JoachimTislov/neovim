-- https://github.com/CopilotC-Nvim/CopilotChat.nvim
return {
  {
    'CopilotC-Nvim/CopilotChat.nvim',
    dependencies = {
      { 'nvim-lua/plenary.nvim', branch = 'master' },
    },
    build = 'make tiktoken',
    opts = {
      model = 'claude-sonnet-4',
      temperature = 0, -- Lower = focused, higher = creative
      sticky = {
        -- '#buffer',
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
      -- https://github.com/CopilotC-Nvim/CopilotChat.nvim?tab=readme-ov-file#functions
      functions = {},
    },
  },
}
