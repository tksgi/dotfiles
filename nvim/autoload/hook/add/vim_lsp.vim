function! hook#add#vim_lsp#load() abort
  " let g:lsp_async_completion = 1
  let g:lsp_preview_float = 1
  set foldmethod=expr
        \ foldexpr=lsp#ui#vim#folding#foldexpr()
        \ foldtext=lsp#ui#vim#folding#foldtext()

  " gem install solargraph solargraph-rails
  if executable('solargraph')
    au User lsp_setup call lsp#register_server({
          \ 'name': 'ruby-lsp',
          \ 'cmd': {server_info->['solargraph', 'stdio']},
          \ 'whitelist': ['ruby'],
          \ })
  endif

  " go get golang.org/x/tools/gopls@latest
  if executable('gopls')
    au User lsp_setup call lsp#register_server({
          \ 'name': 'gopls',
          \ 'cmd': {server_info->['gopls', '-mode', 'stdio']},
          \ 'whitelist': ['go'],
          \ })
  endif

  let g:lsp_log_verbose = 1
  let g:lsp_log_file = expand('~/vim-lsp.log')
endfunction
