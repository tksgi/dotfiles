local config = function()
  vim.api.nvim_exec(
    [[
        let g:choosewin_overlay_enable = 1
        let g:choosewin_overlay_clear_multibyte = 1
      ]], false
  )
end

---@type LazySpec
local spec = {
  't9md/vim-choosewin',
  keys = {
    { '-', '<cmd>ChooseWin<cr>', desc = 'ウィンドウを選択して移動' }
  },
  config = config,
  enabled = false,
}
return spec
