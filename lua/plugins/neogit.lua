-- https://github.com/NeogitOrg/neogit
return {
  'NeogitOrg/neogit',
  dependencies = {
    'sindrets/diffview.nvim',
  },
  opts = {
    kind = 'floating',
  },
  config = function(_, opts)
    require('neogit').setup(opts)
  end,
}
