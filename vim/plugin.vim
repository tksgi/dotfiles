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
Plug 'tksgi/vim-orgmode'

" ウィンドウサイズ変更
Plug 'simeji/winresizer'

" LSP
Plug 'prabirshrestha/async.vim'
Plug 'prabirshrestha/vim-lsp'
Plug 'mattn/vim-lsp-settings'

" 補完
Plug 'prabirshrestha/asyncomplete.vim'
Plug 'prabirshrestha/asyncomplete-lsp.vim'

" docker操作
Plug 'skanehira/docker.vim'

Plug 'skanehira/docker-compose.vim'

" ctags生成
Plug 'jsfaint/gen_tags.vim'

" git操作
Plug 'tpope/vim-fugitive'

" ブラウザ操作
Plug 'tyru/open-browser.vim'

" grepプラグイン
Plug 'mileszs/ack.vim'

" goプラグイン
" :Godoc, :Fmt, :Import コマンドのみ追加
Plug 'vim-jp/vim-go-extra'


" ステータスライン
Plug 'itchyny/lightline.vim'

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
nnoremap <leader><C-]> :LspDefinition<CR>


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
autocmd FileType go autocmd BufWritePre <buffer> Fmt

