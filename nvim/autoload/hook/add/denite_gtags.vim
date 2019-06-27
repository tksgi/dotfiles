function! hook#add#denite_gtags#load() abort
  " Prefix key
  nmap [denite] <Nop>
  map <C-j> [denite]
  " Keymap
  nmap <silent> [denite]<C-D> :Denite -buffer-name=gtags_completion gtags_completion<cr>

endfunction
