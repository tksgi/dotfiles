local init = function()
  vim.g['deol#custom_map'] = {
    edit = 'e',
    start_insert = 'i',
    start_insert_first = 'I',
    start_append = 'a',
    start_append_last = 'A',
    execute_line = '<CR>',
    previous_prompt = '<C-p>',
    next_prompt = '<C-n>',
    paste_prompt = '<C-y>',
    bg = '<C-z>',
    quit = 'q',
  }
end

---@type LazySpec
local spec = {
  'Shougo/deol.nvim',
  init = init,
}
return spec
