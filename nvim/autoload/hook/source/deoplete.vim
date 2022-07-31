function! hook#source#deoplete#load() abort
  " deoplete設定
  " Disable AutoComplPop.
  let g:acp_enableAtStartup = 0
  " Use deoplete.
  let g:deoplete#enable_at_startup = 1
  " Use smartcase.
  " let g:deoplete#enable_smart_case = 1
  " Set minimum syntax keyword length.
  " let g:deoplete#sources#syntax#min_keyword_length = 3

  " Define dictionary.
  let g:deoplete#sources#dictionary#dictionaries = {
        \ 'default' : '',
        \ 'vimshell' : $HOME.'/.vimshell_hist',
        \ 'scheme' : $HOME.'/.gosh_completions'
        \ }

  " Define keyword.
  " if !exists('g:deoplete#keyword_patterns')
  "   let g:deoplete#keyword_patterns = {}
  " endif
  " let g:deoplete#keyword_patterns['default'] = '\h\w*'

  " Plugin key-mappings.
  inoremap <expr><C-g>     deoplete#undo_completion()
  inoremap <expr><C-l>     deoplete#complete_common_string()

  " Recommended key-mappings.
  " <CR>: close popup and save indent.
  inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
  function! s:my_cr_function()
    return (pumvisible() ? "\<C-y>" : "" ) . "\<CR>"
    " For no inserting <CR> key.
    "return pumvisible() ? "\<C-y>" : "\<CR>"
  endfunction
  " <TAB>: completion.
  inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
  " <C-h>, <BS>: close popup and delete backword char.
  inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
  inoremap <expr><BS> deoplete#smart_close_popup()."\<C-h>"
  " Close popup by <Space>.
  "inoremap <expr><Space> pumvisible() ? "\<C-y>" : "\<Space>"

  " AutoComplPop like behavior.
  let g:deoplete#enable_auto_select = 1

  " Enable omni completion.
  autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
  autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
  autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
  autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
  autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags


  " 補完の設定
  autocmd FileType ruby setlocal omnifunc=rubycomplete#Complete
  if !exists('g:deoplete#force_omni_input_patterns')
    let g:deoplete#force_omni_input_patterns = {}
  endif
  let g:deoplete#force_omni_input_patterns.ruby = '[^.*\t]\.\w*\|\h\w*::'

  " if !exists('g:deoplete#keyword_patterns')
  "   let g:deoplete#keyword_patterns = {}
  " endif
  " let g:deoplete#keyword_patterns['default'] = '\h\w*'
  "
  " let g:deoplete#force_omni_input_patterns.c =
  "       \ '[^.[:digit:] *\t]\%(\.\|->\)\w*'
  " let g:deoplete#force_omni_input_patterns.cpp =
  "       \ '[^.[:digit:] *\t]\%(\.\|->\)\w*\|\h\w*::\w*'

  " call deoplete#custom#option('auto_refresh_delay': 200)
    call deoplete#custom#option({
    \ 'auto_complete_delay': 200,
    \ 'smart_case': v:true,
    \ })
endfunction
