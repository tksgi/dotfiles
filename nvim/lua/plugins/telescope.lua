local keys = {
  { '\\T',   '<cmd>Telescope<cr>',                desc = 'Telescope show default pickers' },
  { '\\ff',  '<cmd>Telescope find_files<cr>',     desc = 'Telescope find_files' },
  { '\\lg',  '<cmd>Telescope live_grep<cr>',      desc = 'Telescope live_grep' },
  { '\\ls',  '<cmd>Telescope buffers<cr>',        desc = 'Telescope buffers' },
  { '\\o',   '<cmd>Telescope oldfiles<cr>',       desc = 'Telescope oldfiles' },
  { '\\ht',  '<cmd>Telescope help_tags<cr>',      desc = 'Telescope help_tags' },
  { '\\lr',  '<cmd>Telescope lsp_references<cr>', desc = 'Telescope lsp_references' },
  { '\\gc',  '<cmd>Telescope git_commits<cr>',    desc = 'Telescope git_commits' },
  { '\\gb',  '<cmd>Telescope git_branches<cr>',   desc = 'Telescope git_branches' },
  { '\\gs',  '<cmd>Telescope git_status<cr>',     desc = 'Telescope git_status' },
  { '\\sp',  '<cmd>Telescope spell_suggest<cr>',  desc = 'Telescope spell_suggest' },
  { '\\dlg', '<cmd>Telescope live_grep<cr>',      desc = 'Telescope live_grep' },
  { '\\u',   '<cmd>Telescope undo<cr>',           desc = 'Telescope undo' },
  { '\\fb',  '<cmd>Telescope file_browser<cr>',   desc = 'Telescope file_browser' },
}

local config = function()
  local trouble = require("trouble.providers.telescope")

  require('telescope').setup({
    defaults = {
      mappings = {
        i = { ["<c-t>"] = trouble.open_with_trouble },
        n = { ["<c-t>"] = trouble.open_with_trouble },
      },
    },
    extensions = {
      fzf = {
        fuzzy = true,                   -- false will only do exact matching
        override_generic_sorter = true, -- override the generic sorter
        override_file_sorter = true,    -- override the file sorter
        case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
        -- the default case_mode is "smart_case"
      },
      undo = {
        side_by_side = true,
        layout_strategy = "vertical",
        layout_config = {
          preview_height = 0.8,
        },
      },
    }
  })
  require "telescope".load_extension("fzf")
  -- require "telescope".load_extension("frecency")
  require "telescope".load_extension("undo")
  require "telescope".load_extension("file_browser")
  require "telescope".load_extension("ghq")
  require "telescope".load_extension("notify")
  require "telescope".load_extension("noice")
  require "telescope".load_extension("luasnip")
  require "telescope".load_extension("emoji")
  require "telescope".load_extension("dir")
end

---@type LazySpec
local spec = {
  'nvim-telescope/telescope.nvim',
  tag = '0.1.4',
  cmd = { "Telescope" },
  dependencies = {
    { 'nvim-lua/plenary.nvim' },
    { 'nvim-telescope/telescope-symbols.nvim' },
    { 'nvim-telescope/telescope-fzf-native.nvim',  build = 'make' },
    -- { 'nvim-telescope/telescope-command-palette.nvim' },
    { 'debugloop/telescope-undo.nvim' },
    { "nvim-telescope/telescope-file-browser.nvim" },
    { "nvim-telescope/telescope-ghq.nvim" },
    { "benfowler/telescope-luasnip.nvim" },
    { "xiyaowong/telescope-emoji.nvim" },
    { 'folke/trouble.nvim' },
    { "princejoogie/dir-telescope.nvim",           confog = true, }
  },
  keys = keys,
  config = config,
}
return spec
