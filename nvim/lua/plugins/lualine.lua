
local config = function ()
  require("lualine").setup({
    -- tabline = {
    --   lualine_a = {
    --     { 'tabs', mode = 2, },
    --   },
    --   lualine_z = {
    --     { function() return vim.api.nvim_exec('pwd', true) end },
    --   },
    -- },
    winbar = {
      lualine_c = {
        { 'filename', path = 1, },
      }
    },
    inactive_winbar = {
      lualine_c = {
        { 'filename', path = 1, },
      }
    },
    sections = {
      lualine_x = {
        {
          require("noice").api.status.message.get_hl,
          cond = require("noice").api.status.message.has,
        },
        {
          require("noice").api.status.command.get,
          cond = require("noice").api.status.command.has,
          color = { fg = "#ff9e64" },
        },
        {
          require("noice").api.status.mode.get,
          cond = require("noice").api.status.mode.has,
          color = { fg = "#ff9e64" },
        },
        {
          require("noice").api.status.search.get,
          cond = require("noice").api.status.search.has,
          color = { fg = "#ff9e64" },
        },
      },
    },
    extensions = { 'quickfix', 'fern', 'aerial', 'lazy' },
  })
end

---@type LazySpec
local spec = {
  'nvim-lualine/lualine.nvim',
  dependencies = {
    'nvim-web-devicons',
    'noice.nvim',
  },
  config = config,
}
return spec
