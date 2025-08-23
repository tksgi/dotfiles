---@type LazySpec
local spec = {
  'yetone/avante.nvim',
  build = 'make',
  event = 'VeryLazy',
  -- enabled = false,
  dependencies = {
    'github/copilot.vim',
    "plenary.nvim",
    "folke/snacks.nvim",
  },
  ---@module 'avante.config'
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
      },
      ask = {
        start_insert = false,
      },
    },
    mappings = {
      sidebar = {
        switch_windows = '<C-w><Tab>',
      },
    },
    selector = {
      provider = 'telescope',
    },
    system_prompt = function()
        local hub = require("mcphub").get_hub_instance()
        return hub and hub:get_active_servers_prompt() or ""
    end,
    -- Using function prevents requiring mcphub before it's loaded
    custom_tools = function()
        return {
            require("mcphub.extensions.avante").mcp_tool(),
        }
    end,
  },
}
return spec
