function! hook#add#vim_airline#load() abort
    " タブラインの表示
    let g:airline#extensions#tabline#enabled = 1
    " （タブが一個の場合）バッファのリストをタブラインに表示する機能をオフ
    " let g:airline#extensions#tabline#show_buffers = 0
    " 0でそのタブで開いてるウィンドウ数、1で左のタブから連番
    let g:airline#extensions#tabline#tab_nr_type = 1
    " パワーラインフォントの使用
    let g:airline_powerline_fonts = 1
    " Do not collapse the status line while having multiple windows
    let g:airline_inactive_collapse = 0
    " tagbarの表示
    " let g:airline#extensions#tagbar#enabled = 1
    let g:airline#extensions#vista#enabled = 1
    " virtualenvを有効
    let g:airline#extensions#virtualenv#enabled = 1
    let g:airline_section_c = airline#section#create(['%t%m'])
    let g:airline_section_z = airline#section#create(['%p%% ☰ %l/%L :%v'])
    " aleの出力をairline表示
    " let g:airline#extensions#ale#enabled = 1
  let g:airline#extensions#lsp#enabled = 0
endfunction
