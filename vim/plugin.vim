" if !filereadable('~/.vim/autoload/plug.vim')
"   !curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
" endif

" プラギン設定
call plug#begin('~/.vim/plugged')

" vim8.2 game
Plug 'vim/killersheep'

" 日本語入力
Plug 'tyru/eskk.vim'

" markdown
Plug 'gabrielelana/vim-markdown'
Plug 'shime/vim-livedown'

" help日本語化
Plug 'vim-jp/vimdoc-ja'

" 横揃え
Plug 'godlygeek/tabular'

" その場で実行
Plug 'thinca/vim-quickrun'

" File Tree Viewer
Plug 'lambdalisue/fern.vim'

" ファイルicon
Plug 'ryanoasis/vim-devicons'

Plug 'lambdalisue/fern-renderer-devicons.vim'

Plug 'lambdalisue/fern-bookmark.vim'

" Org Mode
" Plug 'tksgi/vim-orgmode'
" Plug 'hsitz/VimOrganizer'

" ウィンドウサイズ変更
Plug 'simeji/winresizer'

" LSP
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'
" Plug 'tksgi/vim-lsp-settings'

" 補完
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

" snippet
" Plug 'SirVer/ultisnips'
" Plug 'honza/vim-snippets'
" Plug 'prabirshrestha/asyncomplete-ultisnips.vim'

" asyncomplete関連
Plug 'prabirshrestha/asyncomplete-ultisnips.vim'
Plug 'prabirshrestha/asyncomplete-tags.vim'

" 補完
" Plug 'Shougo/deoplete.nvim'
" Plug 'roxma/nvim-yarp'
" Plug 'roxma/vim-hug-neovim-rpc'
" Plug 'lighttiger2505/deoplete-vim-lsp'

" Plug 'Shougo/neosnippet.vim'
" Plug 'Shougo/neosnippet-snippets'
" Plug 'thomasfaingnaert/vim-lsp-snippets'
" Plug 'thomasfaingnaert/vim-lsp-neosnippet'

" docker操作
" Plug 'skanehira/docker.vim'
" 
" Plug 'skanehira/docker-compose.vim'

" ctags生成
Plug 'jsfaint/gen_tags.vim'

" git操作
" Plug 'tpope/vim-fugitive'
Plug 'lambdalisue/gina.vim'

" ブラウザ操作
Plug 'tyru/open-browser.vim'

" grepプラグイン
Plug 'mileszs/ack.vim'

" goプラグイン
" :Godoc, :Fmt, :Import コマンドのみ追加
Plug 'vim-jp/vim-go-extra'


" ステータスライン
Plug 'itchyny/lightline.vim'

" カラースキーム
Plug 'patstockwell/vim-monokai-tasty'
Plug 'tomasr/molokai'

" dartシンタックス
Plug 'dart-lang/dart-vim-plugin'

" easymotion
Plug 'easymotion/vim-easymotion'
call plug#end()






" eskk設定
let g:eskk#server = {
  \   'host': 'localhost',
  \   'port': 55100,
  \}
let g:eskk#dictionary = { 'path': "~/.skk/.skk-jisyo", 'sorted': 0, 'encoding': 'utf-8', }
let g:eskk#large_dictionary = { 'path': "~/.skk/SKK-JISYO.L", 'sorted': 1, 'encoding': 'utf-8', }
let g:eskk#show_candidates_count = 1

" vim-markdown設定
let g:markdown_enable_spell_checking = 0

" Fern設定
let g:fern#renderer = "devicons"

" LSP設定
let g:lsp_preview_autoclose = 1
let g:lsp_virtual_text_enabled = 0
let g:lsp_diagnostics_echo_cursor = 1
nnoremap <leader><C-]> :LspDefinition<CR>

" let g:lsp_settings = {
"     \ 'analysis-server-dart-snapshot': {
"     \     'cmd': [
"     \         '/usr/local/Cellar/dart/2.7.2/bin/dart',
"     \         '/usr/local/Cellar/dart/2.7.2/libexec/bin/snapshots/analysis_server.dart.snapshot',
"     \         '--lsp'
"     \     ],
"     \ },
" \ }

" asyncomplete設定
" snippet設定
let g:UltiSnipsExpandTrigger="<c-k>"

call asyncomplete#register_source(asyncomplete#sources#ultisnips#get_source_options({
      \ 'name': 'ultisnips',
      \ 'whitelist': ['*'],
      \ 'completor': function('asyncomplete#sources#ultisnips#completor'),
      \ }))

au User asyncomplete_setup call asyncomplete#register_source(asyncomplete#sources#tags#get_source_options({
    \ 'name': 'tags',
    \ 'whitelist': ['*'],
    \ 'completor': function('asyncomplete#sources#tags#completor'),
    \ 'config': {
    \    'max_file_size': 50000000,
    \  },
    \ }))

" deoplete設定
" let g:deoplete#enable_at_startup = 1

" vim-hug-neovim-rpc設定
let g:neovim_rpc#py = 'python3'
" let s:pyeval = function('py3eval')

" neosnippet設定
" imap <C-k> <Plug>(neosnippet_expand_or_jump)
" smap <C-k> <Plug>(neosnippet_expand_or_jump)

" gen_tags設定
let g:gen_tags#statusline = 1

" open_browser設定
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

" ack.vim 設定
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" vim-go-extra設定
" 保存時にファイルをフォーマット
autocmd FileType go autocmd BufWritePre <buffer> Fmt

" dart-vim-plugin設定
" let g:dart_format_on_save = 1

" colorscheme vim-monokai-tasty
colorscheme molokai
