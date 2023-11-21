local M = {}
M.init = function()
  -- デフォルトマッピングを無効化してZから初まるマッピングに変更
  vim.g['sandwich_no_default_key_mappings'] = 1
end
M.config = function()
  -- add
  vim.keymap.set('n', 'Za', '<Plug>(sandwich-add)')
  vim.keymap.set('x', 'Za', '<Plug>(sandwich-add)')
  vim.keymap.set('o', 'Za', '<Plug>(sandwich-add)')
  -- delete
  vim.keymap.set('n', 'Zd', '<Plug>(sandwich-delete)')
  vim.keymap.set('x', 'Zd', '<Plug>(sandwich-delete)')
  vim.keymap.set('o', 'Zdb', '<Plug>(sandwich-delete-auto)')
  -- replace
  vim.keymap.set('n', 'Zr', '<Plug>(sandwich-replace)')
  vim.keymap.set('x', 'Zr', '<Plug>(sandwich-replace)')
  vim.keymap.set('o', 'Zrb', '<Plug>(sandwich-replace-auto)')
end
return M
