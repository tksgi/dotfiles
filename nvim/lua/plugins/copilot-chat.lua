---@type LazySpec
local spec = {
  "CopilotC-Nvim/CopilotChat.nvim",
  version = "v2.10.1",
  event = "VeryLazy",
  dependencies = {
    'github/copilot.vim',
    "plenary.nvim",
  },
  opts = {
    debug = true
  },
}
return spec
