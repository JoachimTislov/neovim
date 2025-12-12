-- setup vue: https://github.com/vuejs/language-tools/wiki/neovim

local M = {}

M.filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' }

M.plugin = {
  name = '@vue/typescript-plugin',
  location = vim.fn.expand '$MASON/packages/vue-language-server/node_modules/@vue/language-server',
  languages = { 'vue' },
  confignamespace = 'typescript',
}

return M
