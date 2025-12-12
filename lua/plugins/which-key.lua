-- https://github.com/folke/which-key.nvim
return {
  'folke/which-key.nvim',
  event = 'VimEnter',
  opts = {
    delay = 200,
    icons = { mappings = vim.g.have_nerd_font },
    spec = {
      { '<leader>d', group = '[D]ebug' },
      { '<leader>l', group = '[L]aravel' },
      { '<leader>x', group = 'Trouble' },
      { '<leader>q', group = '[Q]uit' },
      { '<leader>c', group = '[C]opilot' },
      { '<leader>f', group = 'Wt[f]' },
      { '<leader>ci', group = '[I]nstructions' },
      { '<leader>s', group = '[S]earch' },
      { '<leader>t', group = '[T]oggle' },
      { '<leader>o', group = '[O]pen' },
      { '<leader>sg', group = '[S]earch by [G]rep' },
      { '<leader>g', group = '[G]it Hunk', mode = { 'n', 'v' } },
    },
    win = {
      no_overlap = false,
    },
  },
}
