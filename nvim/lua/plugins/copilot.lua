---@type LazySpec
-- local spec = {
--   'github/copilot.vim',
-- }
local spec = {
  "zbirenbaum/copilot.lua",
  requires = {
    "copilotlsp-nvim/copilot-lsp", -- (optional) for NES functionality
  },
}
return spec
