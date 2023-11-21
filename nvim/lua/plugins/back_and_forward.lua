---@type LazySpec
local spec = {
  'Bakudankun/BackAndForward.vim',
  keys = {
    { 'gb',         '<cmd>Back<cr>',    noremap = true,         desc = 'Back buffer' },
    { '<leader>bb', '<cmd>Back<cr>',    desc = 'Back buffer' },
    { '<leader>bf', '<cmd>Forward<cr>', desc = 'Forward buffer' },
  }
}
return spec
