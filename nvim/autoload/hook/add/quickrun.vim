function! hook#add#quickrun#load() abort
  let g:quickrun_config = {}
  let g:quickrun_config['markdown'] = {
        \ 'type': 'markdown/pandoc',
        \ 'cmdopt': '-s',
        \ 'outputter': 'browser'
        \ }
endfunction
