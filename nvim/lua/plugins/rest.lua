---@type LazySpec
local spec = {
  'https://github.com/rest-nvim/rest.nvim',
  enabled = false,
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
    vim.g.rest_nvim.setup()
  end
}
return spec
