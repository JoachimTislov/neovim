return {
  'piersolenski/wtf.nvim',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'MunifTanjim/nui.nvim',
    'nvim-telescope/telescope.nvim', -- Optional: For WtfGrepHistory
  },
  opts = {
    -- Directory for storing chat files
    popup_type = 'popup', -- horizontal, vertical
    provider = 'copilot', -- deepseek, gemini, grok, ollama
    providers = {},
    language = 'english',
    -- additional_instructions = "Start the reply with 'OH HAI THERE'",
    search_engine = 'google', -- duck_duck_go, stack_overflow, github, phind, perplexity
  },
  keys = {
    {
      '<leader>fd',
      mode = { 'n', 'x' },
      function()
        require('wtf').diagnose()
      end,
      desc = 'Debug diagnostic with AI',
    },
    {
      '<leader>ff',
      mode = { 'n', 'x' },
      function()
        require('wtf').fix()
      end,
      desc = 'Fix diagnostic with AI',
    },
    {
      mode = { 'n' },
      '<leader>fs',
      function()
        require('wtf').search()
      end,
      desc = 'Search diagnostic with Google',
    },
    {
      mode = { 'n' },
      '<leader>fp',
      function()
        require('wtf').pick_provider()
      end,
      desc = 'Pick provider',
    },
    {
      mode = { 'n' },
      '<leader>fh',
      function()
        require('wtf').history()
      end,
      desc = 'Populate the quickfix list with previous chat history',
    },
    {
      mode = { 'n' },
      '<leader>fg',
      function()
        require('wtf').grep_history()
      end,
      desc = 'Grep previous chat history with Telescope',
    },
  },
}
