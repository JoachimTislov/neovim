-- https://github.com/catgoose/nvim-colorizer.lua
return {
  'catgoose/nvim-colorizer.lua',
  event = 'BufReadPre',
  opts = {
    user_default_options = {
      names = false,
    },
  },
}
