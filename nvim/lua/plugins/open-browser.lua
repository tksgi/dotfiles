local config = function()
  vim.g.netrw_nogx = 1
  vim.keymap.set('n', 'gx', '<Plug>(openbrowser-open)', {})
  vim.keymap.set('v', 'gx', '<Plug>(openbrowser-open)', {})
end

---@type LazySpec
local spec = {
  'tyru/open-browser.vim',
  lazy = false,
  config = config,
}
return spec
