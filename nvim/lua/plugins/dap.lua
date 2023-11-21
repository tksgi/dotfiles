local config = function()
  local dap = require 'dap'
  dap.configurations.typescriptreact = {
    {
      type = "chromium",
      request = "attach",
      program = "${file}",
      cwd = vim.fn.getcwd(),
      sourceMaps = true,
      protocol = "inspector",
      port = 9222,
      webRoot = "${workspaceFolder}"
    }
  }
end

---@type LazySpec
local spec = {
  'mfussenegger/nvim-dap',
  dependencies = {
    'mason.nvim',
    'jay-babu/mason-nvim-dap.nvim',
  },
  config = config,
}
return spec
