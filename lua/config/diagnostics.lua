-- Diagnostic Config
-- See :help vim.diagnostic.Opts
vim.diagnostic.config {
  severity_sort = true,
  virtual_lines = false,
  float = {
    border = 'rounded',
    source = 'if_many',
  },
  signs = vim.g.have_nerd_font and {
    spacing = 2,
    text = {
      [vim.diagnostic.severity.ERROR] = '󰅚 ',
      [vim.diagnostic.severity.WARN] = '󰀪 ',
      [vim.diagnostic.severity.INFO] = '󰋽 ',
      [vim.diagnostic.severity.HINT] = '󰌶 ',
    },
  } or {},
  -- virtual_text = {
  --   source = 'if_many',
  --   spacing = 2,
  --   format = function(diagnostic)
  --     local diagnostic_message = {
  --       [vim.diagnostic.severity.ERROR] = diagnostic.message,
  --       [vim.diagnostic.severity.INFO] = diagnostic.message,
  --       [vim.diagnostic.severity.WARN] = diagnostic.message,
  --       [vim.diagnostic.severity.HINT] = diagnostic.message,
  --     }
  --     return diagnostic_message[diagnostic.severity]
  --   end,
  -- },
}

-- [lsp(name)]: –> [scope/type/kind]: symbol
local lsp_symbols_filters = {
  ['lua_ls'] = {
    ['global'] = {
      'require',
      'vim',
      'error',
      'string',
      'tostring',
      'ipairs',
      'pairs',
      'pcall',
      'os_uname',
      'os',
    },
    ['field'] = {
      'fs_stat',
    },
  },
}

-- Override the handler to filter out unwanted diagnostics
vim.lsp.handlers['textDocument/publishDiagnostics'] = function(err, result, ctx)
  local client = vim.lsp.get_client_by_id(ctx.client_id)
  if not result or not client then
    return
  end

  -- Apply filters for certain lsps (mainly for lua_ls)
  if lsp_symbols_filters[client.name] then
    result.diagnostics = vim.tbl_filter(function(diagnostic)
      for kind, symbols in pairs(lsp_symbols_filters[client.name]) do
        for _, name in ipairs(symbols) do
          if diagnostic.message:match(string.format('Undefined %s `%s`', kind, name)) then
            return false
          end
        end
      end
      return true
    end, result.diagnostics)
  end

  -- Use default handler
  vim.lsp.diagnostic.on_publish_diagnostics(err, result, ctx)
end
