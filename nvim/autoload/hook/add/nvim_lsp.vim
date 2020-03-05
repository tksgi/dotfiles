function! hook#add#nvim_lsp#load() abort


  lua require'nvim_lsp'.gopls.setup{}
  lua require'nvim_lsp'.dartls.setup{ cmd = { "dart", "/usr/local/Cellar/dart/2.7.1/libexec/bin/snapshots/analysis_server.dart.snapshot", "--lsp" } }
  lua require'nvim_lsp'.pyls.setup{}
  lua require'nvim_lsp'.solargraph.setup{}
  lua require'nvim_lsp'.vimls.setup{}
  lua require'nvim_lsp'.tsserver.setup{}
  lua require'nvim_lsp'.vuels.setup{}
  lua require'nvim_lsp'.yamlls.setup{}
  lua require'nvim_lsp'.dockerls.setup{}

  " docのキーマップ
  nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
  nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
  nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
  nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
  nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
  nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
  nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>

endfunction