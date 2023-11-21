local config = function()
  vim.g.default_colorscheme = 'carbonfox'
  vim.g.inactive_colorscheme = 'nordfox'

  -- カラースキームの適用
  vim.cmd.colorscheme(vim.g.default_colorscheme)
end

---@type LazySpec
local spec = {
  'EdenEast/nightfox.nvim',
  lazy = false,
  priority = 1000,
  config = config,
}
return spec
