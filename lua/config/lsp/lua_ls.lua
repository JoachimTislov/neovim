return {
  settings = {
    lua = {
      completion = {
        callsnippet = 'replace',
      },
      runtime = {
        -- https://github.com/neovim/nvim-lspconfig/blob/master/lua/lspconfig/configs/lua_ls.lua#L47
        version = 'LuaJIT',
      },
      -- https://reddit.com/r/neovim/comments/1avouc4/lua_why_warning_message_undefined_global_keywords
      -- https://github.com/pynappo/dotfiles/blob/2aa3ff1383fa1f85a0ceff0db1e25cc58f0f91a1/.config/nvim/lua/pynappo/lsp/configs.lua#L14-L45
      -- https://github.com/neovim/neovim/issues/21686
      workspace = {
        checkthirdparty = false,
        library = vim.api.nvim_get_runtime_file('', true),
      },
      -- Do not send telemetry data containing a randomized but unique identifier
      telemetry = { enable = false },
      diagnostics = {
        globals = { 'vim', 'require', 'error', 'string' },
        disable = { 'missing-fields' },
      },
    },
  },
}
