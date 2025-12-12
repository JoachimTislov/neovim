return {
  cmd = { 'gopls' },
  filetypes = { 'go', 'gomod', 'gowork', 'gotmpl' },
  settings = {
    gopls = {
      analyses = {
        unusedparams = true,
        gofumpt = true,
      },
      formatOnSave = true,
      sourceOrganizeImports = true,
      staticcheck = false,
      completeUnimported = true,
      usePlaceholder = true,
    },
  },
}
