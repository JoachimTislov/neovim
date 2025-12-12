---@diagnostic disable: assign-type-mismatch
-- https://github.com/LazyVim/LazyVim/discussions/4103#discussioncomment-10085877
vim.api.nvim_create_autocmd('BufWritePre', {
  group = vim.api.nvim_create_augroup('organise_imports', { clear = true }),
  pattern = { '*.ts', '*.vue' },
  callback = function(args)
    local diagnostics = vim.diagnostic.get(args.buf, { severity = vim.diagnostic.severity.ERROR })
    for _, d in ipairs(diagnostics) do
      if not d.message:match 'Cannot find name' then
        return
      end
    end
    if #diagnostics == 0 then
      return
    end
    vim.lsp.buf.code_action { apply = true, context = { only = { 'source.addMissingImports.ts' }, diagnostics = {} } }
  end,
})
