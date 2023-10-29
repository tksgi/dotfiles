local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)
require("lazy").setup({
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-context',
      { 'haringsrob/nvim_context_vt', enabled = false },
      'RRethy/vim-illuminate',
      'RRethy/nvim-treesitter-endwise',
      -- "nvim-treesitter/nvim-treesitter-textobjects",
    },
    build = ":TSUpdate",
    config = function()
	    require 'nvim-treesitter.configs'.setup {
		    highlight = {
			    enable = true,     -- false will disable the whole extension
			    disable = { "ruby" },
			    additional_vim_regex_highlighting = { 'org' },
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
		    -- query_linter = {
			   --  enable = true,
			   --  use_virtual_text = true,
			   --  lint_events = {"BufWrite", "CursorHold"}
		    -- },
	    }
      vim.api.nvim_create_autocmd('BufWrite', {
        pattern = '*.scm',
        callback = function()
          require'nvim-treesitter.query'.invalidate_query_cache()
        end
      })
    end
  },
  {
    'nvim-treesitter/playground'
  },
});
