local config = function()
  vim.g.gin_proxy_apply_without_confirm = 1
end

---@type LazySpec
local spec = {
  'lambdalisue/gin.vim',
  dependencies = { 'vim-denops/denops.vim' },
  config = config,
}
return spec
