---@type LazySpec
local spec = {
  'NvChad/nvim-colorizer.lua',
  config = true,
  cmd = {
    'ColorizerAttachToBuffer',
    'ColorizerDetachFromBuffer',
    'ColorizerReloadAllBuffers',
    'ColorizerToggle',
  }
}
return spec
