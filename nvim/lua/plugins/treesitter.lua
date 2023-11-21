local M = {}
M.config = function()
  require('orgmode').setup_ts_grammar()
  require 'nvim-treesitter.configs'.setup {
    highlight = {
      enable = true,     -- false will disable the whole extension
      disable = { "ruby" },
      additional_vim_regex_highlighting = false,
    },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "gnn",
        node_incremental = "grn",
        scope_incremental = "grc",
        node_decremental = "grm",
      },
      -- disable = { "ruby", "python" }
    },
    indent = {
      enable = true,
      disable = { "ruby" }
    },
    textobjects = {
      enable = true,
      -- disable = { "ruby", "python" }
    },
    endwise = {
      enable = true
    },
  }
  vim.treesitter.language.register('typescript', 'typescriptreact')
  -- for setting FOLD with treesitter
  -- vim.api.nvim_create_autocmd({'BufEnter','BufAdd','BufNew','BufNewFile','BufWinEnter'}, {
  --   group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
  --   callback = function()
  --     vim.opt.foldmethod     = 'expr'
  --     vim.opt.foldexpr       = 'nvim_treesitter#foldexpr()'
  --   end
  -- })
end
return M
