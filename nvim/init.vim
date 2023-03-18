" leaderをスペースに設定
noremap <Space> <Nop>
let g:mapleader = "\<Space>"
let g:maplocalleader = "\\"

set fenc=utf-8
set undofile
set cmdheight=2
set backupskip=/tmp/*
set smartindent
set visualbell
set expandtab
set list listchars=tab:\▸\-
set tabstop=2
set shiftwidth=2
set number
set scrolloff=3
set cursorline
set hidden " 編集中でも別bufferを開ける様に

set ignorecase
set smartcase
set incsearch
set wrapscan
set hlsearch

" ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>
" 置換時候補をインタラクティブに表示
set inccommand=split
" vimgrepでquickfixを開く
autocmd QuickFixCmdPost *grep* cwindow

" ターミナル時<C-w>でノーマルモードに戻る
tnoremap <C-w><C-w> <C-\><C-n>
tnoremap <C-w>h <C-\><C-n><C-w>h
tnoremap <C-w>k <C-\><C-n><C-w>k
tnoremap <C-w>j <C-\><C-n><C-w>j
tnoremap <C-w>l <C-\><C-n><C-w>l

" バッファ移動をタブと同じように行なう
nnoremap <silent> gb :b#<CR>

" D<TAB>でカレントディレクトリのパスを展開
cmap <expr> D<TAB> expand('%:h')

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

" Focus floating window with <C-w><C-w> {{{
if has('nvim')
  function! s:focus_floating() abort
    if !empty(nvim_win_get_config(win_getid()).relative)
      wincmd p
      return
    endif
    for winnr in range(1, winnr('$'))
      let winid = win_getid(winnr)
      let conf = nvim_win_get_config(winid)
      if conf.focusable && !empty(conf.relative)
        call win_gotoid(winid)
        return
      endif
    endfor
  endfunction
  nnoremap <silent> <C-w><C-w> :<C-u>call <SID>focus_floating()<CR>
endif

" nvim 0.6.0でmatchitがプリインストールされており、nomalモードでのYコマンドが意図しない挙動になっていたことの対応
nunmap Y


lua require('plugins')
