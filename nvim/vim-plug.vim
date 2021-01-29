call plug#begin(stdpath('data') . '/plugged')
Plug 'vim-jp/vimdoc-ja'
Plug 'lambdalisue/fern.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'

"Plug 'tpope/vim-fugitive'
Plug 'lambdalisue/gina.vim'

Plug 'thinca/vim-quickrun'
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'Yggdroot/indentLine'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'jacoborus/tender.vim'
Plug 'simeji/winresizer'
Plug 'tpope/vim-rhubarb' " Gbrowse
Plug 'tyru/eskk.vim'
Plug 'tyru/open-browser.vim'
Plug 'Shougo/context_filetype.vim'
Plug 'godlygeek/tabular'
Plug 'tomtom/tcomment_vim'
Plug 'mbbill/undotree'
Plug 'mileszs/ack.vim'
Plug 'easymotion/vim-easymotion'
Plug 'sainnhe/sonokai' " colorscheme

Plug 'gabrielelana/vim-markdown', { 'for': 'markdown' }
Plug 'dart-lang/dart-vim-plugin', { 'for': 'dart' }
let g:dart_format_on_save = 1

" fuzzy finder
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" lsp
Plug 'neovim/nvim-lspconfig'
"Plug 'nvim-lua/lsp_extensions.nvim' " 閉括弧のhint
Plug 'stevearc/aerial.nvim' " symbol
Plug 'akinsho/flutter-tools.nvim'

" lsp install
" Plug 'mattn/vim-lsp-settings'


" better syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'romgrk/nvim-treesitter-context'
" Plug 'ElPiloto/sidekick.nvim'

" completion
" Plug 'nvim-lua/completion-nvim'
" Plug 'aca/completion-tabnine', { 'do': './install.sh' }
" Plug 'steelsojka/completion-buffers'
" Plug 'nvim-treesitter/completion-treesitter'

Plug 'norcalli/snippets.nvim'
Plug 'nvim-telescope/telescope-snippets.nvim'

Plug 'lambdalisue/gina.vim'

" nvim-lua-api completion
Plug 'tjdevries/nlua.nvim'

Plug 'notomo/helpeek.vim'

call plug#end()

" fern
let g:fern#renderer = "nerdfont"
command Fernr Fern . -reveal=%
command Fernd Fern %:h
command Ferndr Fern %:h -reveal=%

" quickrun
call hook#add#quickrun#load()

" vim_airline
call hook#add#vim_airline#load()

" eskk
let g:eskk#server = {
  \   'host': 'localhost',
  \   'port': 55100,
  \}
let g:eskk#dictionary = { 'path': "~/.skk/.skk-jisyo", 'sorted': 0, 'encoding': 'utf-8', }
let g:eskk#large_dictionary = { 'path': "~/.skk/SKK-JISYO.L", 'sorted': 1, 'encoding': 'utf-8', }
let g:eskk#show_candidates_count = 1
" silent! imap <unique> <C-j>   <cmd>call eskk#enable()<CR>
autocmd VimEnter * imap <C-j> <Plug>(eskk:enable)
autocmd VimEnter * cmap <C-j> <Plug>(eskk:enable)

" open-browser 
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

" ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" vim-markdown
let g:markdown_enable_spell_checking = 0

" telescope
nnoremap <leader>tf <cmd>Telescope find_files<cr>
nnoremap <leader>tlg <cmd>Telescope live_grep<cr>
nnoremap <leader>tb <cmd>Telescope buffers<cr>
nnoremap <leader>to <cmd>Telescope oldfiles<cr>
nnoremap <leader>th <cmd>Telescope help_tags<cr>
nnoremap <leader>tr <cmd>Telescope lsp_references<cr>
nnoremap <leader>tc <cmd>Telescope lsp_code_actions<cr>
nnoremap <leader>tgc <cmd>Telescope git_commits<cr>
nnoremap <leader>tgb <cmd>Telescope git_branches<cr>
nnoremap <leader>tgs <cmd>Telescope git_status<cr>

lua require('telescope').setup()
lua require('telescope').load_extension('snippets')

inoremap <C-i> <cmd>Telescope snippets<cr>

" nvim_lspconfig
lua require('nvim-lspconfig')

" colorscheme
colorscheme sonokai

" completion-nvim START
" Use completion-nvim in every buffer
" autocmd BufEnter * lua require'completion'.on_attach()

"let g:completion_chain_complete_list = {
"    \ 'default': [
"    \    {'complete_items': ['lsp', 'snippet', 'tabnine', 'buffers', 'ts' ]},
"    \    {'mode': '<c-p>'},
"    \    {'mode': '<c-n>'}
"    \]
"\}
" let g:completion_chain_complete_list = {
"     \ 'default': [
"     \    {'complete_items': ['lsp']},
"     \    {'mode': '<c-p>'},
"     \    {'mode': '<c-n>'}
"     \]
" \}
" " Use <Tab> and <S-Tab> to navigate through popup menu
" inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
" inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" " Set completeopt to have a better completion experience
" set completeopt=menuone,noinsert,noselect
" 
" let g:completion_confirm_key = "\<C-k>"
" let g:completion_trigger_character = ['.']
" 
" imap <leader><c-j> <Plug>(completion_next_source) "use <c-j> to switch to previous completion
" imap <leader><c-k> <Plug>(completion_prev_source) "use <c-k> to switch to next completion
" 
" " possible value: 'UltiSnips', 'Neosnippet', 'vim-vsnip', 'snippets.nvim'
" let g:completion_enable_snippet = 'snippets.nvim'
" completion-nvim END

" nvim-treesitter
lua require'treesitter'
" 折り畳み設定
" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()

" snippets.nvim
lua require'snippets-setting'

fun! CompleteSnippetsList(findstart, base)
  if a:findstart
    " 単語の始点を検索する
    let line = getline('.')
    let start = col('.') - 1
    while start > 0 && line[start - 1] =~ '\s\|.'
      let start -= 1
    endwhile
    return start
  else
    if !exists('b:snippetsList')
      " here document
      lua local ft = vim.bo.filetype; local keys = {}; for k,v in pairs(vim.tbl_extend('force', require'snippets'.snippets._global or {}, require'snippets'.snippets[ft] or {})) do table.insert(keys, k); end; vim.b.snippetsList = keys;
    endif
    if empty(a:base)
      return b:snippetsList
    else
      let l:list = []
      for snip in b:snippetsList
        if snip =~ a:base
          call add(l:list, snip)
        endif
      endfor
      return l:list
    endif
  endif
endfun
autocmd BufEnter * set completefunc=CompleteSnippetsList





" helpeek
nnoremap <leader>K :<C-u>Helpeek<CR>
" works in command-line mode by using <Cmd>
if has('nvim')
  cnoremap <C-y> <Cmd>Helpeek<CR>
endif
