---@type LazySpec
local spec = {
  'L3MON4D3/LuaSnip',
  version = "1.2.*",
  -- build = 'make install_jsregexp',
  dependencies = {
    { 'rafamadriz/friendly-snippets' }
  },
  config = function()
    require("luasnip.loaders.from_vscode").lazy_load()
    require 'luasnip'.filetype_extend("ruby", { "rails" })
  end
}
return spec
