function! session#load_session(file) abort
  execute 'source' join([g:session_path, a:file], s:sep)
endfunction
let g:loaded_session = 1

" command! SessionList call session#sessions()
command! -nargs=1 SessionCreate call session#create_session(<q-args>)
