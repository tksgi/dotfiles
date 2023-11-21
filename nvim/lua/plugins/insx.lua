
---@type LazySpec
local spec = {
  'hrsh7th/nvim-insx',
  config = function()
    require('insx.preset.standard').setup({ fast_wrap = { enabled = true } })
  end,
}
return spec
