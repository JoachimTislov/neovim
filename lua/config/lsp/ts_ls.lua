local vue = require 'config.vue'
return {
  on_attach = function(client, bufnr)
    require('workspace-diagnostics').populate_workspace_diagnostics(client, bufnr)
  end,
  init_options = {
    plugins = {
      vue.plugin,
    },
  },
  settings = {
    typescript = {
      tsserver = {
        useSyntaxServer = false,
      },
      inlayHints = {
        includeInlayParameterNameHints = 'all',
        includeInlayParameterNameHintsWhenArgumentMatchesName = true,
        includeInlayFunctionParameterTypeHints = true,
        includeInlayVariableTypeHints = true,
        includeInlayVariableTypeHintsWhenTypeMatchesName = true,
        includeInlayPropertyDeclarationTypeHints = true,
        includeInlayFunctionLikeReturnTypeHints = true,
        includeInlayEnumMemberValueHints = true,
      },
    },
  },
  filetypes = vue.filetypes,
}
