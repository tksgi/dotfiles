---@type LazySpec
local spec = {
  "CopilotC-Nvim/CopilotChat.nvim",
  event = "VeryLazy",
  branch = "main",
  dependencies = {
    'github/copilot.vim',
    "plenary.nvim",
  },
  opts = {
    debug = true,
    model = 'claude-sonnet-4',
  },
}
return spec
