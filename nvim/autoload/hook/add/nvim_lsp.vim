function! hook#add#nvim_lsp#load() abort

  lua require'lspconfig'.gopls.setup{}
  lua require'lspconfig'.dartls.setup{}
  lua require'lspconfig'.pyls.setup{}
  lua require'lspconfig'.solargraph.setup{}
  lua require'lspconfig'.vimls.setup{}
  lua require'lspconfig'.tsserver.setup{}
  lua require'lspconfig'.vuels.setup{}
  lua require'lspconfig'.yamlls.setup{}
  lua require'lspconfig'.dockerls.setup{}
  lua require'lspconfig'.sumneko_lua.setup{}

  " helpのexampleキーマップ
  nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>
  nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
  nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
  nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
  nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
  nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
  nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>

  " 追加キーマップ
  nnoremap <silent> <leader><c-]> <cmd>lua vim.lsp.buf.peek_definition()<CR>

  " コマンド追加
  command LspDeclaration    lua vim.lsp.buf.declaration()<CR>
  command LspDefinition     lua vim.lsp.buf.definition()<CR>
  command LspPeekDefinition lua vim.lsp.buf.peek_definition()<CR>
  command Lsphover          lua vim.lsp.buf.hover()<CR>
  command LspImpletentation lua vim.lsp.buf.implementation()<CR>
  command LspSignatureHelp  lua vim.lsp.buf.signature_help()<CR>
  command LspTypeDefinition lua vim.lsp.buf.type_definition()<CR>
  command LspReferences     lua vim.lsp.buf.references()<CR>

endfunction
