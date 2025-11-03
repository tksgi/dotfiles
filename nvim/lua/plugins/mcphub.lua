---@type LazySpec
local spec = {
  "ravitemer/mcphub.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  build = "npm install -g mcp-hub@latest",   -- Installs `mcp-hub` node binary globally
  opts = {
    auto_approve = true,
    global_env = {
      ALLOWED_DIRECTORY = vim.fn.getcwd(),
      DEFAULT_MINIMUM_TOKENS = "100",
      REPOSITORY_PATH = vim.system({ "git", "rev-parse", "--show-toplevel" }):wait().stdout or vim.fn.getcwd(),
    },
  }
}
return spec
