---@type LazySpec
local spec = {
  'yetone/avante.nvim',
  build = 'make',
  event = 'VeryLazy',
  enabled = false,
  dependencies = {
    'github/copilot.vim',
    "plenary.nvim",
    "folke/snacks.nvim",
  },
  ---@module 'avante'
  ---@type avante.Config
  opts = {
    provider = 'copilot',
    providers = {
      copilot = {
        model = 'claude-sonnet-4',
      },
    },
    windows = {
      edit = {
        start_insert = false,
      }
    }
  },
}
return spec
