local M = {}

function M.safe_require(path)
  local ok, m = pcall(require, path)
  if not ok then
    return {}
  else
    return m
  end
end

function M.setup_ls(name, config)
  config.capabilities = vim.tbl_deep_extend('force', {}, require('blink.cmp').get_lsp_capabilities(), config.capabilities or {})
  vim.lsp.config(name, config)
  vim.lsp.enable(name)
end

function M.get_repo_paths()
  local lfs = require 'lfs'
  local projects_dir = os.getenv 'HOME' .. '/projects'
  local table = {}

  for dir in lfs.dir(projects_dir) do
    if dir ~= '.' and dir ~= '..' then
      table.insert(projects_dir .. '/' .. dir)
    end
  end

  return table.concat(table, ':')
end

local function k(mode, key, func, opts)
  vim.keymap.set(mode, key, func, opts or {}) -- I don't think opts needs to be handled here
end

M.nvmap = function(...)
  k({ 'n', 'x' }, ...)
end

M.nmap = function(...)
  k('n', ...)
end

M.vmap = function(...)
  k('x', ...)
end

M.imap = function(...)
  k('i', ...)
end

M.tmap = function(...)
  k('t', ...)
end

return M
