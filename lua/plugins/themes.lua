-- `:Telescope colorscheme`.
-- https://vimcolorschemes.com/i/trending

local themes = {
  vague = {
    src = 'vague2k/vague.nvim',
  },
  catppuccin = {
    src = 'catppuccin/nvim',
    setup = true,
    opts = {
      transparent_background = true,
      float = {
        transparent = true,
        solid = true,
      },
    },
  },
  tokyonight = {
    src = 'folke/tokyonight.nvim',
    opts = {
      transparent = true,
      styles = {
        sidebars = 'transparent',
        floats = 'transparent',
      },
    },
  },
  ['rose-pine'] = {
    src = 'rose-pine/neovim',
    setup = true,
    opts = {
      styles = {
        transparency = true,
      },
    },
  },
  fox = {
    src = 'EdenEast/nightfox.nvim',
    opts = {
      transparent = true,
    },
  },
  gruvbox = {
    -- https://deepwiki.com/morhetz/gruvbox/4-configuration-options
    src = 'morhetz/gruvbox',
    setup = true,
  },
  silkcircuit = {
    -- https://github.com/hyperb1iss/silkcircuit-nvim
    src = 'hyperb1iss/silkcircuit-nvim',
    setup = true,
    opts = {
      transparent = true,
      variant = 'glow', -- "neon" | "vibrant" | "soft" | "glow"
      integrations = {
        telescope = true,
        notify = true,
        cmp = true,
        mini = false,
        -- See :h silkcircuit-integrations for full list
      },
    },
  },
  kanagawa = {
    src = 'rebelot/kanagawa.nvim',
    overrides = function(colors)
      local theme = colors.theme
      return {
        NormalFloat = { bg = 'none' },
        FloatBorder = { bg = 'none' },
        FloatTitle = { bg = 'none' },
        NormalDark = { fg = theme.ui.fg_dim, bg = theme.ui.bg_m3 },
        LazyNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
        MasonNormal = { bg = theme.ui.bg_m3, fg = theme.ui.fg_dim },
      }
    end,
  },
  solarized = {
    src = 'altercation/vim-colors-solarized',
    setup = true,
  },
}

themes[vim.g.theme].default = true

return (function()
  local list = {}
  for name, config in pairs(themes) do
    local opts = config.opts or require('utils').safe_require('config.themes.' .. name)
    local theme = {
      config.src,
      lazy = not config.default,
      priority = config.default and 1000 or 0,
    }
    if config.setup then
      theme.config = function()
        local ok, m = pcall(require, name)
        if ok then
          m.setup(opts)
        end
      end
    else
      theme.opts = opts
    end
    table.insert(list, theme)
  end
  return list
end)()
