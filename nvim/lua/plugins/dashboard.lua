
---@type LazySpec
local spec = {
  'glepnir/dashboard-nvim',
  enabled = false,
  event = 'VimEnter',
  config = true,
  dependencies = { { 'nvim-tree/nvim-web-devicons' } }
}
return spec
