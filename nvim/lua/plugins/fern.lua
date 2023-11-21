local init = function()
  vim.api.nvim_create_user_command(
    'Fernr',
    function(opts)
      local path = #opts.args ~= 0 and opts.args or '.'     -- 三項演算子
      vim.api.nvim_command('Fern ' .. path .. ' -reveal=%')
    end,
    { nargs = '?', complete = 'dir' }
  )
end
local config = function()
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

      vim.api.nvim_exec2(
        [[
        augroup my-glyph-palette
        autocmd! *
        autocmd FileType fern call glyph_palette#apply()
        autocmd FileType nerdtree,startify call glyph_palette#apply()
        augroup END

        ]], {}
      )
    end
  })
end


---@type LazySpec
local spec = {
  'lambdalisue/fern.vim',
  lazy = false,
  dependencies = {
    { 'lambdalisue/fern-hijack.vim',           lazy = false },
    { 'ryanoasis/vim-devicons' },
    { 'nvim-tree/nvim-web-devicons' },
    { 'lambdalisue/nerdfont.vim' },
    { 'lambdalisue/fern-renderer-nerdfont.vim' },
    { 'lambdalisue/glyph-palette.vim' },
    { 'lambdalisue/fern-git-status.vim' },
    { 'lambdalisue/fern-mapping-git.vim' },
    { 'lambdalisue/fern-bookmark.vim' },
    { 'lambdalisue/fern-mapping-quickfix.vim' },
    { 'yuki-yano/fern-preview.vim' },
  },
  init = init,
  config = config,
}
return spec
