---@type LazySpec
local spec = {
  "ravitemer/mcphub.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  build = "npm install -g mcp-hub@latest",   -- Installs `mcp-hub` node binary globally
  config = true,
}
return spec
