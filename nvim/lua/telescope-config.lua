
local trouble = require("trouble.providers.telescope")

require('telescope').setup({
  defaults = {
    mappings = {
      i = { ["<c-t>"] = trouble.open_with_trouble },
      n = { ["<c-t>"] = trouble.open_with_trouble },
    },
  },
  extensions = {
    fzf = {
      fuzzy = true,                   -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true,    -- override the file sorter
      case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
    undo = {
      side_by_side = true,
      layout_strategy = "vertical",
      layout_config = {
        preview_height = 0.8,
      },
    },
  }
})
require "telescope".load_extension("fzf")
-- require "telescope".load_extension("frecency")
require "telescope".load_extension("undo")
require "telescope".load_extension("file_browser")
require "telescope".load_extension("ghq")
require "telescope".load_extension("notify")
require "telescope".load_extension("noice")
require "telescope".load_extension("luasnip")
require "telescope".load_extension("emoji")
require "telescope".load_extension("dir")
