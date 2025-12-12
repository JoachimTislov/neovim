return {
  'mfussenegger/nvim-lint',
  event = { 'BufReadPre', 'BufNewFile' },
  config = function()
    local lint = require 'lint'
    lint.linters_by_ft = lint.linters_by_ft or {}
    -- TODO: Add settings for markdownlint
    -- lint.linters_by_ft['markdown'] = { 'markdownlint' }
    lint.linters_by_ft['go'] = { 'golangcilint' }
    lint.linters_by_ft['html'] = { 'htmlhint' }
    lint.linters_by_ft['make'] = { 'checkmake' }
    -- lint.linters_by_ft['vue'] = { 'cspell' }
    -- lint.linters_by_ft['java'] = { 'checkstyle' }

    -- Disable default linters
    lint.linters_by_ft['clojure'] = nil
    lint.linters_by_ft['dockerfile'] = nil
    lint.linters_by_ft['inko'] = nil
    lint.linters_by_ft['janet'] = nil
    lint.linters_by_ft['json'] = nil
    lint.linters_by_ft['rst'] = nil
    lint.linters_by_ft['ruby'] = nil
    lint.linters_by_ft['terraform'] = nil
    lint.linters_by_ft['text'] = nil

    local lint_augroup = vim.api.nvim_create_augroup('lint', { clear = true })
    vim.api.nvim_create_autocmd({ 'BufEnter', 'BufWritePost', 'InsertLeave' }, {
      group = lint_augroup,
      callback = function()
        -- Only run the linter in buffers that you can modify in order to
        -- avoid superfluous noise, notably within the handy LSP pop-ups that
        -- describe the hovered symbol using Markdown.
        if vim.bo.modifiable then
          lint.try_lint(nil, { ignore_errors = true })
        end
      end,
    })
  end,
}
