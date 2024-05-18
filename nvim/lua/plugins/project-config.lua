---@type LazySpec
local spec = {
  'https://github.com/windwp/nvim-projectconfig',
  config = function()
    require('nvim-projectconfig').setup({
      project_dir = "~/.config/projects-config/",
    })
  end,
}
return spec
