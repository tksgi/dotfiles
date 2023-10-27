local M = {}
M.config = function()
  --require('orgmode').setup_ts_grammar()
  require 'nvim-treesitter.configs'.setup {
    highlight = {
      enable = true, -- false will disable the whole extension
      disable = { "ruby" },
      -- additional_vim_regex_highlighting = { 'org' },
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
    query_linter = {
      enable = true,
      use_virtual_text = true,
      lint_events = { "BufWrite", "CursorHold" }
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
  vim.api.nvim_create_autocmd('BufWrite', {
    pattern = '*.scm',
    callback = function()
      require 'nvim-treesitter.query'.invalidate_query_cache()
    end
  })
  vim.treesitter.query.set('toml', 'injections', [[
  (pair
  (bare_key) @key_string
  (string) @injection.content
  (#any-of? @key_string "lua_add" "lua_depends_update" "lua_done_update" "lua_post_source" "lua_post_update" "lua_sources")
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.language "lua")
  )
  (pair
  (bare_key) @key_string
  (string) @injection.content
  (#any-of? @key_string "hook_add" "hook_depends_update" "hook_done_update" "hook_post_source" "hook_post_update" "hook_sources")
  (#offset! @injection.content 0 1 0 -1)
  (#set! injection.language "vim")
  )
  ]])
end
return M
