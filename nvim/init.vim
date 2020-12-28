" leaderをスペースに設定
noremap <Space> <Nop>
let g:mapleader = "\<Space>"
let g:maplocalleader = "\\"

" windows設定
if has("win64")
  let g:python3_host_prog = 'c:\Users\ttets\AppData\Local\Programs\Python\Python37-32'
endif
" let $TMPDIR = "~/.vim-tmp"
" setting
"文字コードをUFT-8に設定
set fenc=utf-8
" helpを日本語に設定
set helplang=ja,en
" バックアップファイルを作らない
" set nobackup
" スワップファイルを作らない
" set noswapfile
" スワップファイルのディレクトリ設定
set directory=~/.nvim/tmp
" 永続undo
set undofile
if !isdirectory(expand("$HOME/.nvim/undodir"))
  call mkdir(expand("$HOME/.nvim/undodir"), "p")
endif
set undodir=$HOME/.nvim/undodir

" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd
" コマンドウィンドウを2行に設定
set cmdheight=2
" マウスを有効にする
set mouse=a
set backspace=indent,eol,start
" 保存時に行末スペース削除
" augroup HighlightTrailingSpaces
"   autocmd!
"   autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces term=underline guibg=Red ctermbg=Red
"   autocmd VimEnter,WinEnter * match TrailingSpaces /\s\+$/
" augroup END
" tmp ディレクトリではバックアップを行わない
set backupskip=/tmp/*,/private/tmp/*
" :Eでカレントディレクトリを開く
command -nargs=? E Explore <args>

" leaderをスペースに設定
noremap <Space> <Nop>
let g:mapleader = "\<Space>"
let g:maplocalleader = "\\"

" timeoutを設定
" set timeout timeoutlen=3000 ttimeoutlen=100
" augroup FastEscape
"   autocmd!
"   au InsertEnter * set timeoutlen=0
"   au InsertLeave * set timeoutlen=100
" augroup END




" 見た目系
" 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" インデントはスマートインデント
set smartindent
" ビープ音を可視化
set visualbell
" 括弧入力時の対応する括弧を表示
set showmatch
" ステータスラインを常に表示
set laststatus=2
" コマンドラインの補完
set wildmode=list:longest
"カーソルの回り込みができるようになる
set whichwrap=b,s,[,],<,>
"括弧入力時の対応する括弧を表示
set showmatch
set matchtime=1
"コードの色分け
syntax on
set number
"vimdiffの見た目
hi DiffAdd    ctermfg=black ctermbg=2
hi DiffChange ctermfg=black ctermbg=3
hi DiffDelete ctermfg=black ctermbg=6
hi DiffText   ctermfg=black ctermbg=7
set diffopt=filler,context:10000
"Gdiffを縦分割にする
set diffopt+=vertical
" カーソルの上下3行は常に表示
set scrolloff=3
" カーソル行を常にハイライト
set cursorline

" Tab系
" 不可視文字を可視化(タブが「▸-」と表示される)
set list listchars=tab:\▸\-
" Tab文字を半角スペースにする
set expandtab
" 行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=2
" 行頭でのTab文字の表示幅
set shiftwidth=2

""全角スペースをハイライト表示
function! ZenkakuSpace()
  highlight ZenkakuSpace cterm=reverse ctermfg=DarkMagenta gui=reverse guifg=DarkMagenta
endfunction

if has('syntax')
  augroup ZenkakuSpace
    autocmd!
    autocmd ColorScheme       * call ZenkakuSpace()
    autocmd VimEnter,WinEnter * match ZenkakuSpace /　/
  augroup END
  call ZenkakuSpace()
endif


" 検索系
" 検索文字列が小文字の場合は大文字小文字を区別なく検索する
set ignorecase
" 検索文字列に大文字が含まれている場合は区別して検索する
" set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>
" 置換時候補をインタラクティブに表示
set inccommand=split
"vimからファイルを開くときにリストを表示する
set wildmenu wildmode=list:full
" vimgrepでquickfixを開く
autocmd QuickFixCmdPost *grep* cwindow
" grepでgit管理下のファイルのみ検索する
" set grepprg=git\ grep\ -I\ --line-number
if executable('rg')
  set grepprg=rg\ -i\ --vimgrep\ --no-heading
endif
" function! s:gitgrep(query)
"   let l:current_grep = &grepreg " 前回の設定値の保存
"   setlocal grepprg=git\ grep\ -I\ --line-number
"   execute 'silent grep! ' . a:query
"   let &grepprg = l:current_grep
"   redraw!
" endfunction
"
" command! -nargs=? Ggrep call s:gitgrep(<f-args>)
"
" augroup Vimrc
"   autocmd!
"   autocmd QuickFixCmdPost make,*grep* cwindow
" augroup END

" 折りたたみ設定
" let g:vimsyn_folding = 'aflPr'
" set foldmethod=indent
" autocmd BufRead * normal zR

"コマンドのエイリアス設定
command Binary %!xxd

"LSP等の外部ツール置き場
let g:outher_package_path = $HOME . '/tools'

"VIM上のターミナルでもaliasを使えるようにする
" let $ZSH_ENV='~/.zshrc'


"括弧の補完
" inoremap { {}<LEFT>
" inoremap [ []<LEFT>
" inoremap ( ()<LEFT>
" inoremap " ""<LEFT>
" inoremap ' ''<LEFT>
" inoremap <% <%%><LEFT>

"htmlの閉じタグ補完
 augroup MyXML
   autocmd!
   autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
   autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
 augroup END


" ターミナル時<C-[>でノーマルモードに戻る
tnoremap <C-w><C-w> <C-\><C-n>
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>l <C-\><C-n><C-w>l

" 自作のチートシートディレクトリを指定
command CeatSheets :e ~/.config/nvim/how_to_use

" カラースキームを設定
" colorscheme molokai


" バッファ移動をタブと同じように行なう
nnoremap <silent> gb :b#<CR>

" markdownプレビュー
command! MarkdownPreview :silent call system('shiba ' . expand('%') . ' &>/dev/null 2>&1 &') | redraw!

" D<TAB>でカレントディレクトリのパスを展開
cmap <expr> D<TAB> expand('%:h')
cmap <expr> E<SPACE> 'e ' . expand('%:h')


" ずれ確認用
" 0123456789012345678901234567890123456789
" ｱｲｳｴｵｱｲｳｴｵｱｲｳｴｵｱｲｳｴｵｱｲｳｴｵｱｲｳｴｵｱｲｳｴｵｱｲｳｴｵ
" あいうえおあいうえおあいうえおあいうえお
"
"
function! Scouter(file, ...)
  let pat = '^\s*$\|^\s*"'
  let lines = readfile(a:file)
  if !a:0 || !a:1
    let lines = split(substitute(join(lines, "\n"), '\n\s*\\', '', 'g'), "\n")
  endif
  return len(filter(lines,'v:val !~ pat'))
endfunction
command! -bar -bang -nargs=? -complete=file Scouter
\        echo Scouter(empty(<q-args>) ? $MYVIMRC : expand(<q-args>), <bang>0)
command! -bar -bang -nargs=? -complete=file GScouter
\        echo Scouter(empty(<q-args>) ? $MYGVIMRC : expand(<q-args>), <bang>0)




" let g:lsp_settings = {
"     \ 'analysis-server-dart-snapshot': {
"     \     'cmd': [
"     \         'dart',
"     \         '/usr/local/Cellar/dart/2.7.1/libexec/bin/snapshots/analysis_server.dart.snapshot',
"     \         '--lsp'
"     \     ],
"     \ },
" \ }



call plug#begin(stdpath('data') . '/plugged')
Plug 'vim-jp/vimdoc-ja'
Plug 'lambdalisue/fern.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'

Plug 'tpope/vim-fugitive'
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

" fuzzy finder
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim'

" lsp
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/lsp_extensions.nvim' " 閉括弧のhint
Plug 'stevearc/aerial.nvim' " symbol


" better syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'romgrk/nvim-treesitter-context'
" Plug 'ElPiloto/sidekick.nvim'

" completion
Plug 'nvim-lua/completion-nvim'
Plug 'aca/completion-tabnine', { 'do': './install.sh' }
Plug 'steelsojka/completion-buffers'
Plug 'nvim-treesitter/completion-treesitter'

Plug 'norcalli/snippets.nvim'
call plug#end()

" fern
let g:fern#renderer = "nerdfont"

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
nnoremap <leader>ff <cmd>Telescope find_files<cr>
nnoremap <leader>fg <cmd>Telescope live_grep<cr>
nnoremap <leader>fb <cmd>Telescope buffers<cr>
nnoremap <leader>fh <cmd>Telescope help_tags<cr>

" nvim_lspconfig
lua require('nvim-lspconfig')

" colorscheme
colorscheme sonokai

" completion-nvim START
" Use completion-nvim in every buffer
autocmd BufEnter * lua require'completion'.on_attach()

let g:completion_chain_complete_list = {
    \ 'default': [
    \    {'complete_items': ['lsp', 'snippet', 'tabnine', 'buffers', 'ts' ]},
    \    {'mode': '<c-p>'},
    \    {'mode': '<c-n>'}
    \]
\}
" Use <Tab> and <S-Tab> to navigate through popup menu
inoremap <expr> <Tab>   pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" Set completeopt to have a better completion experience
set completeopt=menuone,noinsert,noselect

let g:completion_confirm_key = "\<C-k>"
let g:completion_trigger_character = ['.']

" possible value: 'UltiSnips', 'Neosnippet', 'vim-vsnip', 'snippets.nvim'
let g:completion_enable_snippet = 'snippets.nvim'
" completion-nvim END

" " sidekick.nvim START
" " To actually use sidekick!
" nmap <F8> :call SideKickNoReload()<CR>
"
" let g:sidekick_update_on_buf_write = 1
" " List of which definition types to display:
" " Example: 'function' tells sidekick to display any node found in a ts 'locals' query
" " that is captured in `queries/$LANG/locals.scm` as '@definition.function'.
" let g:sidekick_printable_def_types = ['function', 'class', 'type', 'module', 'parameter', 'method', 'field']
" " Mapping from definition type to the icon displayed for that type in the outline window.
" let g:sidekick_def_type_icons = {
" \    'class': "\uf0e8",
" \    'type': "\uf0e8",
" \    'function': "\uf794",
" \    'module': "\uf7fe",
" \    'arc_component': "\uf6fe",
" \    'sweep': "\uf7fd",
" \    'parameter': "•",
" \    'var': "v",
" \    'method': "\uf794",
" \    'field': "\uf6de",
" \ }
"
" " Indicates which definition types should have their line number displayed in the outline window.
" let g:sidekick_line_num_def_types = {
" \    'class': 1,
" \    'type': 1,
" \    'function': 1,
" \    'module': 1,
" \    'method': 1,
" \ }
"
" " What to display between definition and line number
" let g:sidekick_line_num_separator = " "
" " What to display to the left and right of the line number
" let g:sidekick_line_num_left = "\ue0b2"
" let g:sidekick_line_num_right = "\ue0b0"
" " What to display before outer vs inner definitions
" let g:sidekick_inner_node_icon = "\u251c\u2500\u25B8"
" let g:sidekick_outer_node_icon = "\u2570\u2500\u25B8"
" " What to display to left and right of def_type_icon
" let g:sidekick_left_bracket = "\u27ea"
" let g:sidekick_right_bracket = "\u27eb"
"
" " sidekick.nvim END

" nvim-treesitter
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained", -- one of "all", "maintained" (parsers with maintainers), or a list of languages
  highlight = {
    enable = true,              -- false will disable the whole extension
    -- disable = { "c", "rust" },  -- list of language that will be disabled
  },
}
EOF
"
