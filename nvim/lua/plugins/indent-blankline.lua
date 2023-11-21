---@type LazySpec
local spec = {
  'lukas-reineke/indent-blankline.nvim',
  main = 'ibl',
  config = true,
  opts = {
    exclude = {
      filetypes = {
        'lspinfo',
        'checkhealth',
        'help',
        'man',
        'gitcommit',
        'TelescopePrompt',
        'TelescopeResults',
        'dashboard',
      }
    }
  }
}
return spec
