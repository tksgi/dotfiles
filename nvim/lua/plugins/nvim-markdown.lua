---@type LazySpec
local spec = {
  'ixru/nvim-markdown',
  ft = { 'markdown' },
  config = function()
    vim.g.vim_markdown_no_default_key_mappings = 1
  end
}
return spec
