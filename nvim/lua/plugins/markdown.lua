---@type LazySpec
local spec = {
  'https://github.com/MeanderingProgrammer/render-markdown.nvim',
  dependencies = {
    'nvim-treesitter/nvim-treesitter',
  },
  ft = { 'markdown', 'codecompanion' },
  ---@module 'render-markdown'
  ---@type render.md.UserConfig
  opts = {
    completions = {
      lsp = {
        enabled = true,
      },
    }
  },
}
return spec
