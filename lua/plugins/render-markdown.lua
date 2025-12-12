return {
  'MeanderingProgrammer/render-markdown.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
    'nvim-mini/mini.nvim',
    -- 'nvim-tree/nvim-web-devicons',
    -- 'nvim-mini/mini.icons',
  },
  ft = { 'markdown', 'copilot-chat' },
  opts = {
    render_modes = true,
  },
}
