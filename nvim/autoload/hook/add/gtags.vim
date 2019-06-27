function! hook#add#gtags#load() abort
  " Options
  let g:Gtags_Auto_Map = 0
  let g:Gtags_OpenQuickfixWindow = 1
  " Keymap
  " Show definetion of function cousor word on quickfix
  nmap <silent> K :<C-u>exe("Gtags ".expand('<cword>'))<CR>
  " Show reference of cousor word on quickfix
  nmap <silent> R :<C-u>exe("Gtags -r ".expand('<cword>'))<CR>
endfunction
