local keyopts = { noremap=true, silent=true }

vim.keymap.set('n', '<leader>T',   '<cmd>Telescope<cr>', keyopts)
vim.keymap.set('n', '<leader>tf ', '<cmd>Telescope find_files<cr>', keyopts)
vim.keymap.set('n', '<leader>tlg', '<cmd>Telescope live_grep<cr>', keyopts)
vim.keymap.set('n', '<leader>tb ', '<cmd>Telescope buffers<cr>', keyopts)
vim.keymap.set('n', '<leader>to ', '<cmd>Telescope oldfiles<cr>', keyopts)
vim.keymap.set('n', '<leader>th ', '<cmd>Telescope help_tags<cr>', keyopts)
vim.keymap.set('n', '<leader>tr ', '<cmd>Telescope lsp_references<cr>', keyopts)
vim.keymap.set('n', '<leader>tc ', '<cmd>Telescope lsp_code_actions<cr>', keyopts)
vim.keymap.set('n', '<leader>tgc', '<cmd>Telescope git_commits<cr>', keyopts)
vim.keymap.set('n', '<leader>tgb', '<cmd>Telescope git_branches<cr>', keyopts)
vim.keymap.set('n', '<leader>tgs', '<cmd>Telescope git_status<cr>', keyopts)
vim.keymap.set('n', '<leader>tsp', '<cmd>Telescope spell_suggest<cr>', keyopts)
--
require('telescope').setup({
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    }
  }
})
-- To get fzf loaded and working with telescope, you need to call
-- load_extension, somewhere after setup function:
require('telescope').load_extension('fzf')

-- lua require('telescope').load_extension('snippets')

-- inoremap <C-i> <cmd>Telescope snippets<cr>

