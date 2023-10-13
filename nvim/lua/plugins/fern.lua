local M = {}
M.init = function()
  vim.api.nvim_create_user_command(
    'Fernr',
    function(opts)
      local path = #opts.args ~= 0 and opts.args or '.'     -- 三項演算子
      vim.api.nvim_command('Fern ' .. path .. ' -reveal=%')
    end,
    { nargs = '?', complete = 'dir' }
  )
end
M.config = function()
  vim.g['fern#renderer'] = 'nerdfont'
  vim.api.nvim_create_autocmd('FileType', {
    pattern = 'fern',
    callback = function()
      local opt = { buffer = true, silent = true }
      vim.keymap.set('n', 'p', '<Plug>(fern-action-preview:toggle)', opt)
      vim.keymap.set('n', '<C-p>', '<Plug>(fern-action-preview:auto:toggle)', opt)
      vim.keymap.set('n', '<C-d>', '<Plug>(fern-action-preview:scroll:down:half)', opt)
      vim.keymap.set('n', '<C-u>', '<Plug>(fern-action-preview:scroll:up:half)', opt)
      vim.keymap.set('n', 'D', '<Plug>(fern-action-remove)', opt)
    end
  })
end

return M
