call plug#begin(stdpath('data') . '/plugged')
Plug 'vim-jp/vimdoc-ja'
Plug 'lambdalisue/fern.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'lambdalisue/fern-mapping-git.vim'
Plug 'lambdalisue/fern-hijack.vim'
Plug 'lambdalisue/fern-bookmark.vim'
Plug 'lambdalisue/fern-mapping-quickfix.vim'

"Plug 'tpope/vim-fugitive'
Plug 'lambdalisue/gina.vim'

Plug 'thinca/vim-quickrun'
" Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --all' }
Plug 'junegunn/fzf.vim'
Plug 'Yggdroot/indentLine'
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

" 日付等のインクリメント
Plug 'monaqa/dial.nvim'

Plug 'gabrielelana/vim-markdown', { 'for': 'markdown' }
Plug 'dart-lang/dart-vim-plugin', { 'for': 'dart' }
let g:dart_format_on_save = 1

" statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
" Plug 'glepnir/galaxyline.nvim', {'branch': 'main'}
" Plug 'hoob3rt/lualine.nvim'

" fuzzy finder
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
" Plug 'nvim-telescope/telescope.nvim'

Plug 'Shougo/denite.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neomru.vim'
Plug 'chemzqm/denite-git'
Plug 'delphinus/vim-denite-memo'


" builtin-lsp
" Plug 'neovim/nvim-lspconfig'
" Plug 'anott03/nvim-lspinstall'
"Plug 'nvim-lua/lsp_extensions.nvim' " 閉括弧のhint
" Plug 'stevearc/aerial.nvim' " symbol
" Plug 'akinsho/flutter-tools.nvim'

" vim-lsp
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'


" better syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'romgrk/nvim-treesitter-context'
" Plug 'ElPiloto/sidekick.nvim'

" completion
" Plug 'nvim-lua/completion-nvim'
" Plug 'aca/completion-tabnine', { 'do': './install.sh' }
" Plug 'steelsojka/completion-buffers'
" Plug 'nvim-treesitter/completion-treesitter'

" completion with Shougo ware
Plug 'Shougo/deoplete.nvim'
Plug 'Shougo/neco-syntax'
Plug 'tbodt/deoplete-tabnine', {'do': './install.sh'}
Plug 'deoplete-plugins/deoplete-zsh'
" Plug 'deoplete-plugins/deoplete-lsp'
Plug 'lighttiger2505/deoplete-vim-lsp'

" snippet
Plug 'Shougo/deoppet.nvim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neosnippet.vim', { 'do': ':UpdateRemotePlugins' }
Plug 'Shougo/neosnippet-snippets'
Plug 'honza/vim-snippets'

" Plug 'norcalli/snippets.nvim'
" Plug 'nvim-telescope/telescope-snippets.nvim'

Plug 'Shougo/deol.nvim'

" $EDITOR をnvimに設定
Plug 'lambdalisue/edita.vim'

" nvim-lua-api completion
Plug 'tjdevries/nlua.nvim'

" Plug 'notomo/helpeek.vim'

Plug 'Bakudankun/BackAndForward.vim'
Plug 'romgrk/barbar.nvim'
Plug 'kyazdani42/nvim-web-devicons'

Plug 'rmagatti/auto-session', { 'do': 'mkdir -p ~/.cache/nvim/auto-session'}

call plug#end()

" fern
let g:fern#renderer = "nerdfont"
command Fernr Fern . -reveal=%
command Fernd Fern %:h
command Ferndr Fern %:h -reveal=%
command Fernb Fern bookmark:///

function! s:fern_init() abort
  " Open bookmark:///
  nnoremap <buffer><silent>
        \ <Plug>(fern-my-enter-bookmark)
        \ :<C-u>Fern bookmark:///<CR>
  nmap <buffer><expr><silent>
        \ <C-^>
        \ fern#smart#scheme(
        \   "\<Plug>(fern-my-enter-bookmark)",
        \   {
        \     'bookmark': "\<C-^>",
        \   },
        \ )
endfunction

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

" dial
nmap <C-a> <Plug>(dial-increment)
nmap <C-x> <Plug>(dial-decrement)
vmap <C-a> <Plug>(dial-increment)
vmap <C-x> <Plug>(dial-decrement)
vmap g<C-a> <Plug>(dial-increment-additional)
vmap g<C-x> <Plug>(dial-decrement-additional)

" telescope
" nnoremap <leader>tf <cmd>Telescope find_files<cr>
" nnoremap <leader>tlg <cmd>Telescope live_grep<cr>
" nnoremap <leader>tb <cmd>Telescope buffers<cr>
" nnoremap <leader>to <cmd>Telescope oldfiles<cr>
" nnoremap <leader>th <cmd>Telescope help_tags<cr>
" nnoremap <leader>tr <cmd>Telescope lsp_references<cr>
" nnoremap <leader>tc <cmd>Telescope lsp_code_actions<cr>
" nnoremap <leader>tgc <cmd>Telescope git_commits<cr>
" nnoremap <leader>tgb <cmd>Telescope git_branches<cr>
" nnoremap <leader>tgs <cmd>Telescope git_status<cr>
"
" lua require('telescope').setup()
" lua require('telescope').load_extension('snippets')

" inoremap <C-i> <cmd>Telescope snippets<cr>

" denite
call hook#add#denite#load()

" nvim_lspconfig
" lua require('nvim-lspconfig')

" vim-lsp
function! s:on_lsp_buffer_enabled() abort
  setlocal signcolumn=yes
  inoremap <expr> <CR> pumvisible() ? "\<C-y>\<CR>" : "\<CR>"

  nmap <buffer> gd <plug>(lsp-definition)
  nmap <buffer> <leader>pr <plug>(lsp-peek-definition)
  nmap <buffer> gs <plug>(lsp-document-symbol-search)
  nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
  nmap <buffer> gr <plug>(lsp-references)
  nmap <buffer> gi <plug>(lsp-implementation)
  nmap <buffer> gt <plug>(lsp-type-definition)
  nmap <buffer> <leader>rn <plug>(lsp-rename)
  nmap <buffer> [g <Plug>(lsp-previous-diagnostic)
  nmap <buffer> ]g <Plug>(lsp-next-diagnostic)
  nmap <buffer> K <plug>(lsp-hover)
  nmap <buffer> <leader>c <plug>(lsp-code-lens)
endfunction

augroup lsp_install
  au!
  autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
augroup END

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

" deoplete.nvim
let g:deoplete#enable_at_startup = 1
autocmd FileType TelescopePrompt call deoplete#custom#buffer_option('auto_complete', v:false)

" deoppet.nvim
call deoppet#initialize()
call deoppet#custom#option('snippets',
      \ map(globpath(&runtimepath, 'neosnippets', 1, 1),
      \     "{ 'path': v:val }"))

imap <C-k>  <Plug>(deoppet_expand)
imap <C-f>  <Plug>(deoppet_jump_forward)
imap <C-b>  <Plug>(deoppet_jump_backward)
smap <C-f>  <Plug>(deoppet_jump_forward)
smap <C-b>  <Plug>(deoppet_jump_backward)

let g:neosnippet#enable_snipmate_compatibility = 1
let g:neosnippet#snippets_directory='~/.local/share/nvim/plugged/vim-snippets/snippets'

" snippets.nvim
" lua require'snippets-setting'
"
" fun! CompleteSnippetsList(findstart, base)
"   if a:findstart
"     " 単語の始点を検索する
"     let line = getline('.')
"     let start = col('.') - 1
"     while start > 0 && line[start - 1] =~ '\s\|.'
"       let start -= 1
"     endwhile
"     return start
"   else
"     if !exists('b:snippetsList')
"       " here document
"       lua local ft = vim.bo.filetype; local keys = {}; for k,v in pairs(vim.tbl_extend('force', require'snippets'.snippets._global or {}, require'snippets'.snippets[ft] or {})) do table.insert(keys, k); end; vim.b.snippetsList = keys;
"     endif
"     if empty(a:base)
"       return b:snippetsList
"     else
"       let l:list = []
"       for snip in b:snippetsList
"         if snip =~ a:base
"           call add(l:list, snip)
"         endif
"       endfor
"       return l:list
"     endif
"   endif
" endfun
" autocmd BufEnter * set completefunc=CompleteSnippetsList
"




" helpeek
" nnoremap <leader>K :<C-u>Helpeek<CR>
" " works in command-line mode by using <Cmd>
" if has('nvim')
"   cnoremap <C-y> <Cmd>Helpeek<CR>
" endif

" BackAndForward
nnoremap <C-h> :<C-u>Back<CR>
nnoremap <C-l> :<C-u>Forward<CR>

"
" lualine
" lua require'lualine_setting'

" deol
nnoremap <leader>tt :<C-u>Deol -split=floating -winheight=70 -winwidth=150<CR>

" auto-session
if !isdirectory(expand("$HOME/.cache/.nvim/auto-session"))
  call mkdir(expand("$HOME/.cache/.nvim/auto-session"), "p")
endif
let g:auto_session_root_dir = expand("$HOME/.cache/nvim/auto-session")
