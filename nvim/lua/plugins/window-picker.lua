local init = function()
  vim.api.nvim_create_user_command("PickWindow", function()
    local winid = require('window-picker').pick_window()

    if winid then
      vim.api.nvim_set_current_win(winid)
    end
  end, {})
  vim.keymap.set('n', '-', '<cmd>PickWindow<cr>', { silent = true })
end

local config = function()
  require('window-picker').setup({
    -- hint = 'floating-big-letter',
    selection_chars = '1234567890ABC',
    -- picker_config = {
    --   use_winbar = 'always'
    -- },
    filter_rules = {
      include_current_win = true,
      bo = {
        buftype = {},
      }
    },
  })
end

---@type LazySpec
local spec = {
  's1n7ax/nvim-window-picker',
  name = 'window_picker',
  event = 'VeryLazy',
  version = '2.*',
  init = init,
  confing = config,
}
return spec
