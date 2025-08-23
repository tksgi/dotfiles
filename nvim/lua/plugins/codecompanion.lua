---@type LazySpec
local spec = {
  "olimorris/codecompanion.nvim",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-treesitter/nvim-treesitter",
    "ravitemer/mcphub.nvim"
  },
  opts = {
    -- default adapter is copilot
    adapters = {
      copilot = function()
        return require("codecompanion.adapters").extend("copilot", {
          schema = {
            model = {
              default = "claude-sonnet-4",
            },
          },
        })
      end,
    },
    extensions = {
      mcphub = {
        callback = "mcphub.extensions.codecompanion",
        opts = {
          make_vars = true,
          make_slash_commands = true,
          show_result_in_chat = true,
        }
      }
    },
    opts = {
      language = "japanese",
    },
    display = {
      chat = {
        auto_scroll = true,
        show_header_separator = true,
        window = {
          width = 0.2,
        },
      }
    }
  },
  keys = {
    {
      "<Leader>cc",
      ":CodeCompanionChat Toggle<CR>",
      desc = "CodeCompanion Chat Toggle",
      mode = { "n", "v" },
      noremap = true,
      silent = true,
    },
    {
      "ga",
      ":CodeCompanionChat Add<CR>",
      desc = "CodeCompanion Chat Add",
      mode = "v",
      noremap = true,
      silent = true,
    },
  },
}
return spec
