function! hook#add#diagnostic_nvim#load() abort
  let g:diagnostic_enable_virtual_text = 1
  let g:diagnostic_insert_delay = 1
  let g:diagnostic_auto_popup_while_jump = 1


  " lua require'nvim_lsp'.dartls.setup{ on_attach=require'diagnostic'.on_attach }
endfunction
