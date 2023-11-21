local config = function()
  vim.api.nvim_create_user_command("ResizeWin", require('bufresize').resize, {})
end

---@type LazySpec
local spec = {
  'kwkarlwang/bufresize.nvim',
  config = config,
}
return spec
