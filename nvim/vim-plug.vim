call plug#begin(stdpath('data') . '/plugged')
Plug 'vim-jp/vimdoc-ja'

Plug 'antoinemadec/FixCursorHold.nvim'


" Filer
Plug 'lambdalisue/fern.vim'
Plug 'ryanoasis/vim-devicons'
Plug 'kyazdani42/nvim-web-devicons'
Plug 'lambdalisue/nerdfont.vim'
Plug 'lambdalisue/fern-renderer-nerdfont.vim'
Plug 'lambdalisue/fern-git-status.vim'
Plug 'lambdalisue/fern-mapping-git.vim'
Plug 'lambdalisue/fern-hijack.vim'
Plug 'lambdalisue/fern-bookmark.vim'
Plug 'lambdalisue/fern-mapping-quickfix.vim'
Plug 'yuki-yano/fern-preview.vim'

Plug 'lambdalisue/gina.vim'

Plug 'thinca/vim-quickrun'
Plug 'Yggdroot/indentLine'
Plug 'simeji/winresizer'
Plug 'tpope/vim-rhubarb' " Gbrowse
" Plug 'tyru/eskk.vim'
Plug 'tyru/open-browser.vim'
" Plug 'Shougo/context_filetype.vim' " TreeSitterがあるので
Plug 'godlygeek/tabular'
Plug 'numToStr/Comment.nvim'
Plug 'mbbill/undotree'
Plug 'easymotion/vim-easymotion'
Plug 'sainnhe/sonokai' " colorscheme
Plug 'cohama/lexima.vim'

" 日付等のインクリメント
Plug 'monaqa/dial.nvim'

Plug 'plasticboy/vim-markdown', { 'for': 'markdown' }
Plug 'previm/previm', { 'for': 'markdown' }
" 要サーバー起動
" docker run -d -p 8888:8080 plantuml/plantuml-server:jetty
let g:previm_plantuml_imageprefix = 'http://localhost:8888/png/'


" 言語別設定
Plug 'dart-lang/dart-vim-plugin', { 'for': 'dart' }
let g:dart_format_on_save = 1

Plug 'tpope/vim-rails', { 'for': 'ruby' }
" 言語別設定 END
"

" statusline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'

" fuzzy finder
Plug 'nvim-lua/popup.nvim'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.0' }
Plug 'nvim-telescope/telescope-fzf-native.nvim', { 'do': 'make' }


" lsp
Plug 'neovim/nvim-lspconfig'
Plug 'williamboman/mason.nvim' " auto-installer for lsp
"Plug 'nvim-lua/lsp_extensions.nvim' " 閉括弧のhint
Plug 'stevearc/aerial.nvim' " symbol
Plug 'akinsho/flutter-tools.nvim'

Plug 'glepnir/lspsaga.nvim', { 'branch': 'main' }

" for rust
Plug 'simrat39/rust-tools.nvim' " need rust-analyzer. execute `rustup component add rust-src`

" Plug 'mfussenegger/nvim-dap'

" symbol viewer
Plug 'liuchengxu/vista.vim'


" better syntax highlighting
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
Plug 'romgrk/nvim-treesitter-context'

Plug 'vim-denops/denops.vim'
Plug 'vim-skk/skkeleton'

" completion with ddc
" Plug 'Shougo/ddc.vim'
" Plug 'Shougo/pum.vim'
" Plug 'Shougo/neco-vim'
" Plug 'Shougo/ddc-nvim-lsp'
" Plug 'Shougo/ddc-zsh'
" Plug 'Shougo/ddc-omni'
" Plug 'Shougo/ddc-cmdline-history'
" Plug 'tani/ddc-git'
" Plug 'tani/ddc-oldfiles'
" Plug 'tani/ddc-fuzzy'
" Plug 'ippachi/ddc-yank'
" Plug 'matsui54/ddc-buffer'
" Plug 'LumaKernel/ddc-tabnine'
" Plug 'LumaKernel/ddc-file'
" Plug 'delphinus/ddc-treesitter'

" completion with cmp
Plug 'hrsh7th/cmp-nvim-lsp'
Plug 'hrsh7th/cmp-buffer'
Plug 'hrsh7th/cmp-path'
Plug 'hrsh7th/cmp-cmdline'
Plug 'hrsh7th/cmp-nvim-lua'
Plug 'hrsh7th/cmp-nvim-lsp-document-symbol'
Plug 'petertriho/cmp-git'
Plug 'tzachar/cmp-tabnine', { 'do': './install.sh' }
Plug 'rinx/cmp-skkeleton'
Plug 'ray-x/cmp-treesitter'
Plug 'hrsh7th/nvim-cmp'


Plug 'Shougo/deol.nvim'

" $EDITOR をnvimに設定
Plug 'lambdalisue/edita.vim'

" nvim-lua-api completion
" Plug 'tjdevries/nlua.nvim' " need to run duwnload_sumneko.lua script

" Plug 'notomo/helpeek.vim'

" <c-h>, <c-l>で前後のバッファに移動
Plug 'Bakudankun/BackAndForward.vim'

" tabbarの設定
Plug 'romgrk/barbar.nvim'


" プロジェクト固有設定
Plug 'windwp/nvim-projectconfig'

" Plug 'rmagatti/auto-session', { 'do': 'mkdir -p ~/.cache/nvim/auto-session'}

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

function! s:fern_settings() abort
  nmap <silent> <buffer> p     <Plug>(fern-action-preview:toggle)
  nmap <silent> <buffer> <C-p> <Plug>(fern-action-preview:auto:toggle)
  nmap <silent> <buffer> <C-d> <Plug>(fern-action-preview:scroll:down:half)
  nmap <silent> <buffer> <C-u> <Plug>(fern-action-preview:scroll:up:half)
endfunction

augroup fern-settings
  autocmd!
  autocmd FileType fern call s:fern_settings()
augroup END

" quickrun
call hook#add#quickrun#load()

" vim_airline
call hook#add#vim_airline#load()

" eskk
" let g:eskk#server = {
"   \   'host': 'localhost',
"   \   'port': 55100,
"   \}
" let g:eskk#dictionary = { 'path': "~/skk_dictionary/.skk-jisyo", 'sorted': 0, 'encoding': 'utf-8', }
" let g:eskk#large_dictionary = { 'path': "~/skk_dictionary/SKK-JISYO.L", 'sorted': 1, 'encoding': 'utf-8', }
" let g:eskk#show_candidates_count = 1
" " silent! imap <unique> <C-j>   <cmd>call eskk#enable()<CR>
" autocmd VimEnter * imap <C-j> <Plug>(eskk:enable)
" autocmd VimEnter * cmap <C-j> <Plug>(eskk:enable)

" skkeleton
function! s:skkeleton_init() abort
  call skkeleton#config({
        \ 'globalJisyo': "~/skk_dictionary/SKK-JISYO.L",
        \ 'globalJisyoEncoding': 'utf-8',
        \ 'userJisyo': "~/skk_dictionary/.skk-jisyo",
        \ })
  call skkeleton#register_kanatable('rom', {
        \ "z\<Space>": ["\u3000", ''],
        \ })
endfunction

augroup skkeleton-initialize-pre
  autocmd!
  autocmd User skkeleton-initialize-pre call s:skkeleton_init()
augroup END

imap <C-j> <Plug>(skkeleton-toggle)
cmap <C-j> <Plug>(skkeleton-toggle)

" open-browser 
let g:netrw_nogx = 1 " disable netrw's gx mapping.
nmap gx <Plug>(openbrowser-smart-search)
vmap gx <Plug>(openbrowser-smart-search)

" ack
if executable('ag')
  let g:ackprg = 'ag --vimgrep'
endif

" vim-markdown
let g:vim_markdown_folding_disabled = 1
let g:vim_markdown_conceal_code_blocks = 0
let g:vim_markdown_conceal = 0
let g:vim_markdown_new_list_item_indent = 0

" dial
nmap <C-a> <Plug>(dial-increment)
nmap <C-x> <Plug>(dial-decrement)
vmap <C-a> <Plug>(dial-increment)
vmap <C-x> <Plug>(dial-decrement)
vmap g<C-a> <Plug>(dial-increment-additional)
vmap g<C-x> <Plug>(dial-decrement-additional)

" telescope
lua require'telescope-setting'

" denite
" call hook#add#denite#load()

" nvim_lspconfig
lua require('nvim-lspconfig')

" vim-lsp
" function! s:on_lsp_buffer_enabled() abort
"   setlocal signcolumn=yes
"   " inoremap <expr> <CR> pumvisible() ? "\<C-y>\<CR>" : "\<CR>"
"
"   nmap <buffer> gd <plug>(lsp-definition)
"   nmap <buffer> <leader>pr <plug>(lsp-peek-definition)
"   nmap <buffer> gs <plug>(lsp-document-symbol-search)
"   nmap <buffer> gS <plug>(lsp-workspace-symbol-search)
"   nmap <buffer> gr <plug>(lsp-references)
"   nmap <buffer> gi <plug>(lsp-implementation)
"   " nmap <buffer> gt <plug>(lsp-type-definition)
"   nmap <buffer> <leader>rn <plug>(lsp-rename)
"   nmap <buffer> [g <Plug>(lsp-previous-diagnostic)
"   nmap <buffer> ]g <Plug>(lsp-next-diagnostic)
"   nmap <buffer> K <plug>(lsp-hover)
"   nmap <buffer> <leader>c <plug>(lsp-code-lens)
" endfunction
"
" augroup lsp_install
"   au!
"   autocmd User lsp_buffer_enabled call s:on_lsp_buffer_enabled()
" augroup END
"
" let s:dartBin = trim(system("echo \"$ASDF_DIR/installs/flutter/$(asdf current flutter | sed -E 's/ +/ /g' | cut -f 2 -d ' ')/bin\""), "\n")
" au User lsp_setup call lsp#register_server({
" \ 'name': 'dart-analysis-server',
" \ 'cmd': {server_info->[s:dartBin .. "/dart", s:dartBin .. "/cache/dart-sdk/bin/snapshots/analysis_server.dart.snapshot", "--lsp"]},
" \ 'allowlist': ['dart'],
" \ 'blocklist': ['filetype to blocklist'],
" \ 'config': {},
" \ 'workspace_config': {'param': {'enabled': v:true}},
" \ 'languageId': {server_info->'dart'},
" \ })
"
" let s:solargraph_port = '7658'
" au User lsp_setup call lsp#register_server({
" \ 'name': 'solargraph',
" \ "tcp": { server_info-> "localhost:" . s:solargraph_port },
" \ 'allowlist': ['ruby'],
" \ 'languageId': {server_info->'ruby'},
" \ })
"
" vista.vim
let g:vista_default_executive = 'nvim_lsp'

" colorscheme
colorscheme sonokai

" ddc.vim
" call ddc#custom#patch_global('completionMenu', 'pum.vim')
"   call ddc#custom#patch_global('autoCompleteEvents',
"       \ ['InsertEnter', 'TextChangedI', 'TextChangedP', 'CmdlineChanged'])
"
" call ddc#custom#patch_global('sources', ['skkeleton', 'buffer', 'file', 'line', 'tabnine', 'nvim-lsp'])
" " call ddc#custom#patch_global('sources', ['skkeleton', 'buffer', 'git-file', 'file', 'git-commit', 'git-branch'])
" " call ddc#custom#patch_global('sources', ['skkeleton', 'vim-lsp', 'buffer', 'git-file', 'file', 'git-commit', 'git-branch'])
" call ddc#custom#patch_global('sourceOptions', {
"   \   '_': {
"   \     'matchers': ['matcher_fuzzy'],
"   \     'sorters': ['sorter_fuzzy'],
"   \     'converters': ['converter_fuzzy']
"   \   },
"   \   'zsh': {
"   \     'mark': 'Z',
"   \     'maxCandidates': 10,
"   \   },
"   \   'nvim-lsp': {
"   \     'mark': 'lsp',
"   \     'forceCompletionPattern': '\.\w*|:\w*|->\w*',
"   \     'maxSize': 10,
"   \   },
"   \   'skkeleton': {
"   \     'mark': 'skkeleton',
"   \     'matchers': ['skkeleton'],
"   \     'maxCandidates': 10,
"   \   },
"   \   'buffer': {
"   \     'mark': 'buffer',
"   \     'maxCandidates': 5,
"   \   },
"   \   'file': {
"   \     'mark': 'F',
"   \     'isVolatile': v:true,
"   \     'forceCompletionPattern': '\S/\S*',
"   \     'maxCandidates': 5,
"   \   },
"   \   'git-flie': {
"   \     'mark': 'gitF',
"   \     'maxCandidates': 5,
"   \   },
"   \   'git-commit': {
"   \     'mark': 'gitF',
"   \     'maxCandidates': 5,
"   \   },
"   \   'git-branch': {
"   \     'mark': 'gitF',
"   \     'maxCandidates': 5,
"   \   },
"   \   'necovim': {
"   \     'mark': 'necovim',
"   \     'maxCandidates': 5,
"   \    },
"   \   'tabnine': {
"   \     'mark': 'TN',
"   \     'maxCandidates': 5,
"   \     'isVolatile': v:true,
"   \   },
"   \   'oldfiles': {
"   \     'mark': 'oldfiles',
"   \     'maxCandidates': 5,
"   \   },
"   \   'around': {
"   \     'mark': 'around',
"   \     'maxCandidates': 5,
"   \   },
"   \   'line': {
"   \     'mark': 'line',
"   \     'maxCandidates': 5,
"   \   },
"   \ })
"
" call ddc#custom#patch_filetype(['zsh'], 'sources', ['zsh'])
"
" call ddc#custom#patch_filetype(
"     \ ['ps1', 'dosbatch', 'autohotkey', 'registry'], {
"     \ 'sourceOptions': {
"     \   'file': {
"     \     'forceCompletionPattern': '\S\\\S*',
"     \   },
"     \ },
"     \ 'sourceParams': {
"     \   'file': {
"     \     'mode': 'win32',
"     \   },
"     \ }})
"
" cnoremap <Tab>   <Cmd>call pum#map#insert_relative(+1)<CR>
" cnoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
" cnoremap <C-n>   <Cmd>call pum#map#insert_relative(+1)<CR>
" cnoremap <C-p>   <Cmd>call pum#map#insert_relative(-1)<CR>
" cnoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
" cnoremap <C-e>   <Cmd>call pum#map#cancel()<CR>
" nnoremap :       <Cmd>call CommandlinePre()<CR>:
" inoremap <Tab>   <Cmd>call pum#map#insert_relative(+1)<CR>
" inoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
" inoremap <C-n>   <Cmd>call pum#map#insert_relative(+1)<CR>
" inoremap <C-p>   <Cmd>call pum#map#insert_relative(-1)<CR>
" inoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
" inoremap <C-e>   <Cmd>call pum#map#cancel()<CR>
" inoremap <PageDown> <Cmd>call pum#map#insert_relative_page(+1)<CR>
" inoremap <PageUp>   <Cmd>call pum#map#insert_relative_page(-1)<CR>

" call pum#set_option('border', 'double')

" disable in order to avoid breaking terminal drawing
" function! CommandlinePre() abort
"   " Overwrite sources
"   let s:prev_buffer_config = ddc#custom#get_buffer()
"   call ddc#custom#patch_buffer('sources', ['necovim', 'git-file', 'git-commit', 'git-branch', 'around', 'oldfiles'])
"
"   autocmd CmdlineLeave * ++once call CommandlinePost()
"
"   " Enable command line completion
"   call ddc#enable_cmdline_completion()
" endfunction
" function! CommandlinePost() abort
"   " Restore sources
"   call ddc#custom#set_buffer(s:prev_buffer_config)
" endfunction
"
" call ddc#enable()
" call popup_preview#enable()


" nvim-treesitter
lua require'treesitter'
" 折り畳み設定
" set foldmethod=expr
" set foldexpr=nvim_treesitter#foldexpr()

" deoppet.nvim
" call deoppet#initialize()
" call deoppet#custom#option('snippets',
"       \ map(globpath(&runtimepath, 'neosnippets', 1, 1),
"       \     "{ 'path': v:val }"))
"
" imap <C-k>  <Plug>(deoppet_expand)
" imap <C-f>  <Plug>(deoppet_jump_forward)
" imap <C-b>  <Plug>(deoppet_jump_backward)
" smap <C-f>  <Plug>(deoppet_jump_forward)
" smap <C-b>  <Plug>(deoppet_jump_backward)
"
" let g:neosnippet#enable_snipmate_compatibility = 1
" let g:neosnippet#snippets_directory='~/.local/share/nvim/plugged/vim-snippets/snippets'

" snippets.nvim
" lua require'snippets-setting'



" BackAndForward
nnoremap <C-h> :<C-u>Back<CR>
nnoremap <C-l> :<C-u>Forward<CR>

"
" lualine
" lua require'lualine_setting'

" deol
nnoremap <leader>bt :<C-u>Deol -split=floating -winheight=70 -winwidth=150<CR>
g:deol#enable_ddc_completion = v:true

" auto-session
if !isdirectory(expand("$HOME/.cache/.nvim/auto-session"))
  call mkdir(expand("$HOME/.cache/.nvim/auto-session"), "p")
endif
let g:auto_session_root_dir = expand("$HOME/.cache/nvim/auto-session")



" DDU
" call ddu#custom#patch_global({
"     \ 'ui': 'ff',
"     \ 'uiParams': {
"     \   'ff' : {
"     \     'prompt': '>',
"     \     'split': 'floating',
"     \ }
"     \ }
"     \ })
" call ddu#custom#patch_global({
"       \ 'kindOptions': {
"       \   'readme_viewer': {
"       \     'defaultAction': 'open',
"       \ }}})
" let g:readme_viewer#plugin_manager = 'vim-plug'
"
" call ddu#custom#patch_global({
"     \   'kindOptions': {
"     \     'file': {
"     \       'defaultAction': 'open',
"     \     },
"     \     'action': {
"     \       'defaultAction': 'do',
"     \     },
"     \   }
"     \ })
" call ddu#custom#patch_global({
"     \   'sourceOptions': {
"     \     '_': {
"     \       'matchers': ['matcher_substring'],
"     \     },
"     \   }
"     \ })
" call ddu#custom#patch_global({
"     \   'sourceParams' : {
"     \     'rg' : {
"     \       'args': ['--column', '--no-heading', '--color', 'never'],
"     \     },
"     \   },
"     \ })
" call ddu#custom#patch_global({
"     \   'sourceOptions': {
"     \     'register': {
"       \       'defaultAction': ['append'],
"     \     },
"     \   }
"     \ })
"
" command! DduFzReadme call fzf#run(fzf#wrap(#{
"           \ source: values(map(copy(g:plugs), {k,v-> k.' '.get(split(globpath(get(v,'dir',''), '\creadme.*'), '\n'), 0, '')})),
"           \ options: ['--with-nth=1', '--preview', 'bat --color=always --plain {2}'],
"           \ sink: funcref('s:PlugReadmeFzf')}))
" function s:PlugReadmeFzf(name_and_path) abort
"   execute 'PlugReadme' substitute(a:name_and_path, ' .*', '', '')
" endfunction
"
" autocmd FileType ddu-ff call s:ddu_ff_my_settings()
" function! s:ddu_ff_my_settings() abort
"   nnoremap <buffer> <CR>
"         \ <Cmd>call ddu#ui#ff#do_action('itemAction')<CR>
"   nnoremap <buffer> <Space>
"         \ <Cmd>call ddu#ui#ff#do_action('toggleSelectItem')<CR>
"   nnoremap <buffer> i
"         \ <Cmd>call ddu#ui#ff#do_action('openFilterWindow')<CR>
"   nnoremap <buffer> p
"         \ <Cmd>call ddu#ui#ff#do_action('preview')<CR>
"   nnoremap <buffer> q
"         \ <Cmd>call ddu#ui#ff#do_action('quit')<CR>
"   nnoremap <buffer> E
"         \ <Cmd>call ddu#ui#ff#do_action('chooseAction')<CR>
"         " \ <Cmd>call ddu#ui#ff#do_action('itemAction',
"         " \ {'params': eval(input('params: '))})<CR>
" endfunction
"
" autocmd FileType ddu-ff-filter call s:ddu_filter_my_settings()
" function! s:ddu_filter_my_settings() abort
"   inoremap <buffer> <CR>
"         \ <Esc><Cmd>close<CR>
"   nnoremap <buffer> <CR>
"         \ <Cmd>close<CR>
"   nnoremap <buffer> <Esc>
"         \ <Cmd>close<CR>
"   nnoremap <buffer> q
"         \ <Cmd>close<CR>
" endfunction

" command! DduBuffer call ddu#start({'sources': [{'name': 'buffer'}]})

" projectconfig
lua require('nvim-projectconfig').setup({ autocmd=true, project_dir = "~/.config/projects-config/" })

lua require('Comment').setup()


lua require('cmp-setting')
