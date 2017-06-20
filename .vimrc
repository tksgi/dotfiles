" setting
"文字コードをUFT-8に設定
set fenc=utf-8
" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" 編集中のファイルが変更されたら自動で読み直す
set autoread
" バッファが編集中でもその他のファイルを開けるように
set hidden
" 入力中のコマンドをステータスに表示する
set showcmd
" マウスを有効にする
set mouse=a
set backspace=indent,eol,start
" 保存時に行末スペース削除
augroup HighlightTrailingSpaces
  autocmd!
  autocmd VimEnter,WinEnter,ColorScheme * highlight TrailingSpaces term=underline guibg=Red ctermbg=Red
  autocmd VimEnter,WinEnter * match TrailingSpaces /\s\+$/
augroup END
" tmp ディレクトリではバックアップを行わない
set backupskip=/tmp/*,/private/tmp/*
" :Eでカレントディレクトリを開く
command -nargs=? E Explore <args>

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
" 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk
"カーソルの回り込みができるようになる
set whichwrap=b,s,[,],<,>
"括弧入力時の対応する括弧を表示
set showmatch
set matchtime=1
"コードの色分け
syntax on
"set number
set statusline=%F%{fugitive#statusline()}
set statusline+=%=
set statusline+=%l-%v/%L
"vimdiffの見た目
hi DiffAdd    ctermfg=black ctermbg=2
hi DiffChange ctermfg=black ctermbg=3
hi DiffDelete ctermfg=black ctermbg=6
hi DiffText   ctermfg=black ctermbg=7
set diffopt=filler,context:10000
"Gdiffを縦分割にする
set diffopt+=vertical

" Tab系
" 不可視文字を可視化(タブが「▸-」と表示される)
set list listchars=tab:\▸\-
" Tab文字を半角スペースにする
set expandtab
" 行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=2
" 行頭でのTab文字の表示幅
set shiftwidth=2
"タブ、空白、改行の可視化
"set list
"set listchars=tab:>.,trail:_,eol:↲,extends:>,precedes:<,nbsp:%
"
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
set smartcase
" 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" 検索時に最後まで行ったら最初に戻る
set wrapscan
" 検索語をハイライト表示
set hlsearch
" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>
"vimからファイルを開くときにリストを表示する
set wildmenu wildmode=list:full

"Dein.vim設定
"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/Users/tetsu/.vim/bundle/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('/Users/tetsu/.vim/bundle')
  call dein#begin('/Users/tetsu/.vim/bundle')

  " Let dein manage dein
  " Required:
  call dein#add('/Users/tetsu/.vim/bundle/repos/github.com/Shougo/dein.vim')

  " Add or remove your plugins here:
  call dein#add('Shougo/neosnippet.vim')
  call dein#add('Shougo/neosnippet-snippets')
  call dein#add('scrooloose/nerdtree')
  call dein#add('tpope/vim-fugitive')
  "補完
  call dein#add('Shougo/neocomplete.vim')
  "コメントON/OFFを手軽に実行
  call dein#add('tomtom/tcomment_vim')
  "履歴をたどる
  call dein#add('Shougo/unite.vim')
  call dein#add('Shougo/neomru.vim')
  call dein#add('vim-scripts/grep.vim')

  " You can specify revision/branch/tag.
  call dein#add('Shougo/vimshell', { 'rev': '3787e5' })

  " Required:
  call dein#end()
  call dein#save_state()
endif

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
if dein#check_install()
  call dein#install()
endif

"End dein Scripts-------------------------

"neocomplete設定
highlight Pmenu ctermbg=4
highlight PmenuSel ctermbg=1
highlight PMenuSbar ctermbg=4

" 補完ウィンドウの設定
set completeopt=menuone

" 補完ウィンドウの設定
set completeopt=menuone

" rsenseでの自動補完機能を有効化
let g:rsenseUseOmniFunc = 1
" let g:rsenseHome = '/usr/local/lib/rsense-0.3'

" auto-ctagsを使ってファイル保存時にtagsファイルを更新
let g:auto_ctags = 1

" 起動時に有効化
let g:neocomplcache_enable_at_startup = 1

" 大文字が入力されるまで大文字小文字の区別を無視する
let g:neocomplcache_enable_smart_case = 1

" _(アンダースコア)区切りの補完を有効化
let g:neocomplcache_enable_underbar_completion = 1

let g:neocomplcache_enable_camel_case_completion  =  1

" 最初の補完候補を選択状態にする
let g:neocomplcache_enable_auto_select = 1

" ポップアップメニューで表示される候補の数
let g:neocomplcache_max_list = 20

" シンタックスをキャッシュするときの最小文字長
let g:neocomplcache_min_syntax_length = 3

 " 補完の設定
autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
if !exists('g:neocomplete#force_omni_input_patterns')
  let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.ruby = '[^.*\t]\.\w*\|\h\w*::'

if !exists('g:neocomplete#keyword_patterns')
         let g:neocomplete#keyword_patterns = {}
 endif
 let g:neocomplete#keyword_patterns['default'] = '\h\w*'

"括弧の補完
" imap { {}<LEFT>
" imap [ []<LEFT>
" imap ( ()<LEFT>
" imap " ""<LEFT>
" imap ' ''<LEFT>
" imap <% <%%><LEFT>

"ctag
nnoremap <C-h> :vsp<CR> :exe("tjump ".expand('<cword>'))<CR>
nnoremap <C-k> :split<CR> :exe("tjump ".expand('<cword>'))<CR>
" unite-tagsの設定
" autocmd BufEnter *
"   if empty(&buftype)
"       nnoremap <buffer> <C-]> :<C-u>UniteWithCursorWord -immediately tag<CR>
"   endif
set tags+=.svn/tags

"'Shougo/unite.vim'
nnoremap ,ub :<C-u>Unite buffer<CR>
nnoremap ,uc :<C-u>Unite file<CR>
nnoremap ,uh :<C-u>Unite file_mru<CR>
nnoremap ,uf  :<c-u>UniteWithBufferDir -buffer-name=files file -direction=botright <cr>
noremap ,ur     :Unite -buffer-name=register register<CR>
" history/yank を有効化する
" let g:unite_source_history_yank_enable = 1
" noremap ,uy     :Unite history/yank<CR>

"htmlの閉じタグ補完
 augroup MyXML
   autocmd!
   autocmd Filetype xml inoremap <buffer> </ </<C-x><C-o>
   autocmd Filetype html inoremap <buffer> </ </<C-x><C-o>
 augroup END

