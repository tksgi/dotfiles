---@type LazySpec
local spec = {
  'chentoast/marks.nvim',
  config = true,
  opts = {
    builtin_marks = { "'", "<", ">", "." },
    default_mappings = true,
    signs = true,
  }
}
return spec
