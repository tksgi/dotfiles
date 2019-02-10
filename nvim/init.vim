" windows設定
if has("win64")
	let g:python3_host_prog = 'c:\Users\ttets\AppData\Local\Programs\Python\Python37-32'
endif
" let $TMPDIR = "~/.vim-tmp"
" setting
"文字コードをUFT-8に設定
set fenc=utf-8
" バックアップファイルを作らない
" set nobackup
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
" set virtualedit=onemore
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
"set number
"set statusline=%F%{fugitive#statusline()}
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
" set list
" set listchars=tab:>.,trail:_,eol:↲,extends:>,precedes:<,nbsp:%

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

" タグファイルを探して読み込む
set tags=./tags

"コマンドのエイリアス設定
:command Binary %!xxd

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
  let s:toml_dir  = $HOME . '/.config/nvim/dein'
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
set completeopt=menuone

" 補完ウィンドウの設定
set completeopt=menuone

 " 'justmao945/vim-clang' {{{

" disable auto completion for vim-clang
let g:clang_auto = 0
let g:clang_complete_auto = 0
let g:clang_auto_select = 0
let g:clang_use_library = 1
" default 'longest' can not work with deoplete
let g:clang_c_completeopt   = 'menuone'
let g:clang_cpp_completeopt = 'menuone'

function! s:get_latest_clang(search_path)
    let l:filelist = split(globpath(a:search_path, 'clang-*'), '\n')
    let l:clang_exec_list = []
    for l:file in l:filelist
        if l:file =~ '^.*clang-\d\.\d$'
            call add(l:clang_exec_list, l:file)
        endif
    endfor
    if len(l:clang_exec_list)
        return reverse(l:clang_exec_list)[0]
    else
        return 'clang'
    endif
endfunction

function! s:get_latest_clang_format(search_path)
    let l:filelist = split(globpath(a:search_path, 'clang-format-*'), '\n')
    let l:clang_exec_list = []
    for l:file in l:filelist
        if l:file =~ '^.*clang-format-\d\.\d$'
            call add(l:clang_exec_list, l:file)
        endif
    endfor
    if len(l:clang_exec_list)
        return reverse(l:clang_exec_list)[0]
    else
        return 'clang-format'
    endif
endfunction

let g:clang_exec = s:get_latest_clang('/usr/bin')
let g:clang_format_exec = s:get_latest_clang_format('/usr/bin')

let g:clang_c_options = '-std=c11'
let g:clang_cpp_options = '-std=c++11 -stdlib=libc++'


" }}}
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

"vimgrep (:vim)用
" nnoremap [q :cprevious<CR>   " 前へ
" nnoremap ]q :cnext<CR>       " 次へ
" nnoremap [Q :<C-u>cfirst<CR> " 最初へ
"  nnoremap ]Q :<C-u>clast<CR>  " 最後へ



" ターミナル時<C-[>でノーマルモードに戻る
" tnoremap <C-[> <C-\><C-n>

" 自作のチートシートディレクトリを指定
command CeatSheets :e ~/.config/nvim/how_to_use

" カラースキームを設定
colorscheme vim-monokai-tasty
