local config = function()
  vim.o.timeout = true
  vim.o.timeoutlen = 300
  require("which-key").setup({})
end

---@type LazySpec
local spec = {
  'folke/which-key.nvim',
  lazy = false,
  config = config,
}
return spec
