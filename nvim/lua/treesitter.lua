require'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true,              -- false will disable the whole extension
    disable = { "ruby", "python" }
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = "gnn",
      node_incremental = "grn",
      scope_incremental = "grc",
      node_decremental = "grm",
    },
    disable = { "ruby", "python" }
  },
  indent = {
    enable = true ,
    disable = { "ruby", "python" }
  },
  textobjects = {
    enable = true,
    disable = { "ruby", "python" }
  },
}
