vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function()
  use {'wbthomason/packer.nvim', opt = true}

  use {
    'haorenW1025/completion-nvim',
    event = 'InsertEnter *',
    config = function() 
      vim.cmd('packadd vim-vsnip') 
      vim.cmd('packadd vim-vsnip-integ') 
    end,
    requires = {{'hrsh7th/vim-vsnip', opt = true}, {'hrsh7th/vim-vsnip-integ', opt = true}}
  }
  use {'sainnhe/sonokai', config = 'colorscheme sonokai'}
  use {'nvim-treesitter/nvim-treesitter', run = ':TSUpdate'}

  use {
    {'neovim/nvim-lspconfig', config = function() vim.cmd('call hook#add#nvim_lsp#load()') end},
    {'haorenW1025/diagnostic-nvim'},
  }
    -- {'haorenW1025/diagnostic-nvim', config = function() vim.cmd('call hook#add#diagnostic-nvim#load()') end,},

  use { 'vim-jp/vimdoc-ja'}
  use { 'junegunn/fzf.vim'}
  use { 'tomtom/tcomment_vim'}
  use { 'tyru/open-browser.vim' }
  use { 'lambdalisue/fern.vim'}
  use { 'lambdalisue/fern-renderer-nerdfont.vim', requires = 'lambdalisue/nerdfont.vim', config = 'let g:fern#renderer = "nerdfont"'}
  use { 'lambdalisue/fern-git-status.vim'}
  use { 'simeji/winresizer'}

  use { 'godlygeek/tabular', cmd = 'Tabular'}

  use { 'cespare/vim-toml', ft = 'toml'}
  use { 'gabrielelana/vim-markdown', ft = 'markdown', config = 'let g:markdown_enable_spell_checking = 0'}
  use { 'tpope/vim-rails', ft = 'ruby'}
  use { 'tbodt/deoplete-tabnine', event = 'VimEnter *', run = './install.sh'}
  use { 'dart-lang/dart-vim-plugin', ft = 'dart'}
end)
