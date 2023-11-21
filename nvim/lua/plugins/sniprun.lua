local config = function()
  require 'sniprun'.setup({
    display = { "Terminal" },
  })
end

---@type LazySpec
local spec = {
  'michaelb/sniprun',
  build = 'bash ./install.sh',
  config = config,
}
return spec
