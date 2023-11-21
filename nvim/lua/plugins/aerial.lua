local config = function()
  require 'aerial'.setup({
    on_attach = function(bufnr)
      vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
      vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
    end
  })

  vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle!<CR>', { noremap = true })
end

---@type LazySpec
local spec = {
  'stevearc/aerial.nvim',
  config = config,
}
return spec
