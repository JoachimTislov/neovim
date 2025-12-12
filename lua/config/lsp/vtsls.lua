-- https://dev.to/danwalsh/solved-vue-3-typescript-inlay-hint-support-in-neovim-53ej
local vue = require 'config.vue'
return {
  settings = {
    vtsls = {
      tsserver = {
        globalplugins = {
          vue.plugin,
        },
      },
    },
    typescript = {
      preferences = {
        -- https://github.com/lazyvim/lazyvim/discussions/1124
        includecompletionsformoduleexports = true,
        includecompletionsforimportstatements = true,
        importmodulespecifier = 'non-relative',
      },
    },
  },
  filetypes = vue.filetypes,
}
