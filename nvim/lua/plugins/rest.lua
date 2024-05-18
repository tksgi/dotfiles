---@type LazySpec
local spec = {
  'https://github.com/rest-nvim/rest.nvim',
  dependencies = {{
    "vhyrro/luarocks.nvim",
    priority = 1000,
    config = true,
    opts = {
      rocks = { "lua-curl", "nvim-nio", "mimetypes", "xml2lua" },
    }
  }},
  ft = "http",
  config = function()
    require("rest-nvim").setup()
  end
}
return spec
