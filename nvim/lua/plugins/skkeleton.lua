local M = {}

M.config = function()
  -- local init_pre = vim.api.nvim_create_augroup('skkeleton-initialize-pre', { clear = false })
  -- vim.api.nvim_create_autocmd('User', {
  --   group = init_pre,
  --   callback = function()
  --     local dic_path = vim.fn.stdpath("data") .. '/skk_dictionary/'
  --     vim.fn['skkeleton#config']({
  --       globalDictionaries = { dic_path .. 'SKK-JISYO.L', dic_path .. 'SKK-JISYO.jinmei', dic_path .. 'SKK-JISYO.geo', dic_path .. 'SKK-JISYO.emoji'}
  --     })
  --   end
  -- })
  vim.keymap.set('i', '<C-j>', '<Plug>(skkeleton-enable)', {})
  vim.keymap.set('c', '<C-j>', '<Plug>(skkeleton-enable)', {})
  vim.api.nvim_exec(
    [[
             function! s:skkeleton_init() abort
               let dic_path = stdpath("data") . "/skk_dictionary/"
               call skkeleton#config({
               \ 'globalDictionaries': [dic_path . "SKK-JISYO.L", dic_path . "SKK-JISYO.jinmei", dic_path . "SKK-JISYO.geo", dic_path . "SKK-JISYO.emoji"],
               \ })
             endfunction

             augroup skkeleton-initialize-pre
             autocmd!
             autocmd User skkeleton-initialize-pre call s:skkeleton_init()
             augroup END
             ]],
    false)
end

M.build = function()
  local dic_path = vim.fn.stdpath('data') .. '/skk_dictionary'
  if vim.fn.empty(vim.fn.glob(dic_path)) > 0 then
    vim.fn.system({ 'git', 'clone', 'https://github.com/skk-dev/dict.git', dic_path })
  end
end
return M
