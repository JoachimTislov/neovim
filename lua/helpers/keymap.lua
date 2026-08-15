local map = {}

-- Keymaps --
local function k(mode, key, func, opts)
  vim.keymap.set(mode, key, func, opts or {})
end

function map.nv(...)
  k({ 'n', 'v', 'x' }, ...)
end

function map.is(...)
  k({ 'i', 's' }, ...)
end

function map.n(...)
  k('n', ...)
end

function map.v(...)
  k('v', ...)
end

function map.i(...)
  k('i', ...)
end

function map.t(...)
  k('t', ...)
end

return map
