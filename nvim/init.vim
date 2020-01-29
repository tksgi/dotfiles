" windows設定
if has("win64")
  let g:python3_host_prog = 'c:\Users\ttets\AppData\Local\Programs\Python\Python37-32'
endif
let g:python_host_prog = "~/.pyenv/versions/2.7.16/bin/python2.7"
" let $TMPDIR = "~/.vim-tmp"
" setting
"文字コードをUFT-8に設定
set fenc=utf-8
" helpを日本語に設定
set helplang=ja,en
" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" スワップファイルのディレクトリ設定
" set directory=~/.vim/tmp

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
"let g:vimsyn_folding = 'r'
"set foldmethod=syntax

"コマンドのエイリアス設定
command Binary %!xxd

"LSP等の外部ツール置き場
let g:outher_package_path = $HOME . '/tools'

"VIM上のターミナルでもaliasを使えるようにする
" let $ZSH_ENV='~/.zshrc'

"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=~/.cache/dein/repos/github.com/Shougo/dein.vim

" Required:
if dein#load_state('~/.cache/dein')
  call dein#begin('~/.cache/dein')

  " Let dein manage dein
  " Required:
  call dein#add('~/.cache/dein/repos/github.com/Shougo/dein.vim')

  " プラグイン管理
  let s:toml_dir  = $HOME . '/.config/nvim/plugins'
  let s:toml = s:toml_dir . '/plugin.toml'
  let s:lazy_toml = s:toml_dir . '/lazy_plugin.toml'

  call dein#load_toml(s:toml, {'lazy': 0})
  call dein#load_toml(s:lazy_toml, {'lazy': 1})


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


"deoplete設定u
highlight Pmenu ctermbg=4
highlight PmenuSel ctermbg=1
highlight PMenuSbar ctermbg=4

" 補完ウィンドウの設定
" set completeopt=menuone


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
colorscheme molokai


" バッファ移動をタブと同じように行なう
nnoremap <silent> gb :b#<CR>

" markdownプレビュー
command! MarkdownPreview :silent call system('shiba ' . expand('%') . ' &>/dev/null 2>&1 &') | redraw!

" D<TAB>でカレントディレクトリのパスを展開
cmap <expr> D<TAB> expand('%:h')
cmap <expr> E<SPACE> 'e ' . expand('%:h')

" leaderをスペースに設定
noremap <Space> <Nop>
let g:mapleader = "\<Space>"
let g:maplocalleader = "\\"


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

