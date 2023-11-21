local config = function()
    require('modes').setup({
      colors = {
        copy = "#f5c359",
        delete = "#c75c6a",
        insert = "#78ccc5",
        visual = "#9745be",
      },
      set_cursore = true,
      set_cursorline = true,
      set_number = true,
    })
end

---@type LazySpec
local spec = {
  'mvllow/modes.nvim',
  tag = 'v0.2.0',
  config = config,
}
return spec
