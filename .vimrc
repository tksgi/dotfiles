" let $TMPDIR = "/Users/tetsu/.vim-tmp"
" setting
"文字コードをUFT-8に設定
set fenc=utf-8
" バックアップファイルを作らない
" set nobackup
" スワップファイルを作らない
set noswapfile
" スワップファイルのディレクトリ設定
set directory=~/.vim/tmp

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
" 折り返し時に表示行単位での移動できるようにする
" nnoremap j gj
" nnoremap k gk
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

""dein.vim設定
""dein scripts-----------------------------
"if &compatible
"  set nocompatible               " be improved
"endif
"
"" required:
"set runtimepath+=/users/tetsu/.vim/bundle/repos/github.com/shougo/dein.vim
"
"" required:
"if dein#load_state('/users/tetsu/.vim/bundle')
"  call dein#begin('/users/tetsu/.vim/bundle')
"
"  " プラグインリスト
"  let s:toml_dir  = $home . '/.vim/dein/userconfig'
"  let s:toml      = s:toml_dir . '/plugin.toml'
"  let s:lazy_toml = s:toml_dir . '/lazy_plugin.toml'
"
"  "tomlをキャッシュしておく
"  call dein#load_toml(s:toml,     {'lazy':0})
"  call dein#load_toml(s:lazy_toml,{'lazy':1})
"
"  " required:
"  call dein#add('/users/tetsu/.vim/bundle/repos/github.com/shougo/dein.vim')
"  " add or remove your plugins here:
"  " call dein#add('shougo/neosnippet.vim')
"  " call dein#add('shougo/neosnippet-snippets')
"  " call dein#add('scrooloose/nerdtree')
"  " call dein#add('tpope/vim-fugitive')
"  " "補完
"  " call dein#add('shougo/neocomplete.vim')
"  " "コメントon/offを手軽に実行
"  " call dein#add('tomtom/tcomment_vim')
"  " "履歴をたどる
"  " call dein#add('shougo/unite.vim')
"  " call dein#add('shougo/neomru.vim')
"  " call dein#add('vim-scripts/grep.vim')
"  "
"  " " you can specify revision/branch/tag.
"  " call dein#add('shougo/vimshell', { 'rev': '3787e5' })
"  "
"  " required:
"  call dein#end()
"  call dein#save_state()
"endif
"
"" required:
"filetype plugin indent on
"syntax enable
"
"" if you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif
"
""end dein scripts-------------------------
"
""neocomplete設定
"highlight pmenu ctermbg=4
"highlight pmenusel ctermbg=1
"highlight pmenusbar ctermbg=4
"
"" 補完ウィンドウの設定
"set completeopt=menuone
"
"" 補完ウィンドウの設定
"set completeopt=menuone
"
"" rsenseでの自動補完機能を有効化
"let g:rsenseuseomnifunc = 1
"" let g:rsensehome = '/usr/local/lib/rsense-0.3'
"
"" auto-ctagsを使ってファイル保存時にtagsファイルを更新
"let g:auto_ctags = 1
"
"" neocomplete設定
"" disable autocomplpop.
"let g:acp_enableatstartup = 0
"" use neocomplete.
"let g:neocomplete#enable_at_startup = 1
"" use smartcase.
"let g:neocomplete#enable_smart_case = 1
"" set minimum syntax keyword length.
"let g:neocomplete#sources#syntax#min_keyword_length = 3
"
"" define dictionary.
"let g:neocomplete#sources#dictionary#dictionaries = {
"    \ 'default' : '',
"    \ 'vimshell' : $home.'/.vimshell_hist',
"    \ 'scheme' : $home.'/.gosh_completions'
"        \ }
"
"" define keyword.
"if !exists('g:neocomplete#keyword_patterns')
"    let g:neocomplete#keyword_patterns = {}
"endif
"let g:neocomplete#keyword_patterns['default'] = '\h\w*'
"
"" plugin key-mappings.
"inoremap <expr><c-g>     neocomplete#undo_completion()
"inoremap <expr><c-l>     neocomplete#complete_common_string()
"
"" recommended key-mappings.
"" <cr>: close popup and save indent.
"inoremap <silent> <cr> <c-r>=<sid>my_cr_function()<cr>
"function! s:my_cr_function()
"  return (pumvisible() ? "\<c-y>" : "" ) . "\<cr>"
"  " for no inserting <cr> key.
"  "return pumvisible() ? "\<c-y>" : "\<cr>"
"endfunction
"" <tab>: completion.
"inoremap <expr><tab>  pumvisible() ? "\<c-n>" : "\<tab>"
"" <c-h>, <bs>: close popup and delete backword char.
"inoremap <expr><c-h> neocomplete#smart_close_popup()."\<c-h>"
"inoremap <expr><bs> neocomplete#smart_close_popup()."\<c-h>"
"" close popup by <space>.
""inoremap <expr><space> pumvisible() ? "\<c-y>" : "\<space>"
"
"" autocomplpop like behavior.
"let g:neocomplete#enable_auto_select = 1
"
"" enable omni completion.
"autocmd filetype css setlocal omnifunc=csscomplete#completecss
"autocmd filetype html,markdown setlocal omnifunc=htmlcomplete#completetags
"autocmd filetype javascript setlocal omnifunc=javascriptcomplete#completejs
"autocmd filetype python setlocal omnifunc=pythoncomplete#complete
"autocmd filetype xml setlocal omnifunc=xmlcomplete#completetags
"
"
"" 補完の設定
"autocmd filetype ruby setlocal omnifunc=rubycomplete#complete
"if !exists('g:neocomplete#force_omni_input_patterns')
"  let g:neocomplete#force_omni_input_patterns = {}
"endif
"let g:neocomplete#force_omni_input_patterns.ruby = '[^.*\t]\.\w*\|\h\w*::'
"
"if !exists('g:neocomplete#keyword_patterns')
"  let g:neocomplete#keyword_patterns = {}
"endif
"let g:neocomplete#keyword_patterns['default'] = '\h\w*'
"
"let g:neocomplete#force_omni_input_patterns.c =
"      \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
"let g:neocomplete#force_omni_input_patterns.cpp =
""      \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'
"
" " 'justmao945/vim-clang' {{{
"
"" disable auto completion for vim-clang
"let g:clang_auto = 0
"let g:clang_complete_auto = 0
"let g:clang_auto_select = 0
"let g:clang_use_library = 1
"" default 'longest' can not work with neocomplete
"let g:clang_c_completeopt   = 'menuone'
"let g:clang_cpp_completeopt = 'menuone'
"
"function! s:get_latest_clang(search_path)
"    let l:filelist = split(globpath(a:search_path, 'clang-*'), '\n')
"    let l:clang_exec_list = []
"    for l:file in l:filelist
"        if l:file =~ '^.*clang-\d\.\d$'
"            call add(l:clang_exec_list, l:file)
"        endif
"    endfor
"    if len(l:clang_exec_list)
"        return reverse(l:clang_exec_list)[0]
"    else
"        return 'clang'
"    endif
"endfunction
"
"function! s:get_latest_clang_format(search_path)
"    let l:filelist = split(globpath(a:search_path, 'clang-format-*'), '\n')
"    let l:clang_exec_list = []
"    for l:file in l:filelist
"        if l:file =~ '^.*clang-format-\d\.\d$'
"            call add(l:clang_exec_list, l:file)
"        endif
"    endfor
"    if len(l:clang_exec_list)
"        return reverse(l:clang_exec_list)[0]
"    else
"        return 'clang-format'
"    endif
"endfunction
"
"let g:clang_exec = s:get_latest_clang('/usr/bin')
"let g:clang_format_exec = s:get_latest_clang_format('/usr/bin')
"
"let g:clang_c_options = '-std=c11'
"let g:clang_cpp_options = '-std=c++11 -stdlib=libc++'
"
"
"" }}}
""括弧の補完
"" imap { {}<left>
"" imap [ []<left>
"" imap ( ()<left>
"" imap " ""<left>
"" imap ' ''<left>
"" imap <% <%%><left>
"
""ctag
"nnoremap <c-h> :vsp<cr> :exe("tjump ".expand('<cword>'))<cr>
"nnoremap <c-k> :split<cr> :exe("tjump ".expand('<cword>'))<cr>
"" unite-tagsの設定
"" autocmd bufenter *
""   if empty(&buftype)
""       nnoremap <buffer> <c-]> :<c-u>unitewithcursorword -immediately tag<cr>
""   endif
"set tags+=.svn/tags
"
""'shougo/unite.vim'
"nnoremap ,ub :<c-u>unite buffer<cr>
"nnoremap ,uc :<c-u>unite file<cr>
"nnoremap ,uh :<c-u>unite file_mru<cr>
"nnoremap ,uf  :<c-u>unitewithbufferdir -buffer-name=files file -direction=botright <cr>
"noremap ,ur     :unite -buffer-name=register register<cr>
"" history/yank を有効化する
"" let g:unite_source_history_yank_enable = 1
"" noremap ,uy     :unite history/yank<cr>
"
""htmlの閉じタグ補完
" augroup myxml
"   autocmd!
"   autocmd filetype xml inoremap <buffer> </ </<c-x><c-o>
"   autocmd filetype html inoremap <buffer> </ </<c-x><c-o>
" augroup end
"
""vimgrep (:vim)用
"" nnoremap [q :cprevious<cr>   " 前へ
"" nnoremap ]q :cnext<cr>       " 次へ
"" nnoremap [q :<c-u>cfirst<cr> " 最初へ
"" nnoremap ]q :<c-u>clast<cr>  " 最後へ
"
"
"" language_client_neovimの設定
"" required for operations modifying multiple buffers like rename.
"set hidden
"
"let g:languageclient_servercommands = {
"    \ 'rust': ['~/.cargo/bin/rustup', 'run', 'stable', 'rls'],
"    \ 'javascript': ['/usr/local/bin/javascript-typescript-stdio'],
"    \ 'javascript.jsx': ['tcp://127.0.0.1:2089'],
"    \ 'python': ['/usr/local/bin/pyls'],
"    \ }
"
"nnoremap <f5> :call languageclient_contextmenu()<cr>
"" or map each action separately
"nnoremap <silent> k :call languageclient#textdocument_hover()<cr>
"nnoremap <silent> gd :call languageclient#textdocument_definition()<cr>
"nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>
