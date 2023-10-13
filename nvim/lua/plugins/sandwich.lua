local M = {}
M.config = function()
  -- デフォルトマッピングを無効化してzから初まるマッピングに変更
  vim.g.sandwich_no_default_key_mappings = 1
  -- add
  vim.keymap.set('n', 'za', '<Plug>(sandwich-add)')
  vim.keymap.set('x', 'za', '<Plug>(sandwich-add)')
  vim.keymap.set('o', 'za', '<Plug>(sandwich-add)')
  -- delete
  vim.keymap.set('n', 'zd', '<Plug>(sandwich-delete)')
  vim.keymap.set('x', 'zd', '<Plug>(sandwich-delete)')
  vim.keymap.set('o', 'zdb', '<Plug>(sandwich-delete-auto)')
  -- replace
  vim.keymap.set('n', 'zr', '<Plug>(sandwich-replace)')
  vim.keymap.set('x', 'zr', '<Plug>(sandwich-replace)')
  vim.keymap.set('o', 'zrb', '<Plug>(sandwich-replace-auto)')
end
return M
