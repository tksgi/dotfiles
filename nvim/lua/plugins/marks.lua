---@type LazySpec
local spec = {
  'chentoast/marks.nvim',
  config = true,
  options = {
    builtin_marks = { "'", "<", ">", "." },
    default_mappings = true,
    signs = true,
  }
}
return spec
