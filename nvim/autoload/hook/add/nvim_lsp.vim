function! hook#add#nvim_lsp#load() abort
  lua vim.cmd('packadd nvim-lsp')

  lua require'nvim_lsp'.gopls.setup{}
  lua require'nvim_lsp'.dartls.setup{ cmd = { "/Users/kasugaitooru/go/src/github.com/flutter/flutter/bin/cache/dart-sdk/bin/dart", "/Users/kasugaitooru/go/src/github.com/flutter/flutter/bin/cache/dart-sdk/bin/snapshots/analysis_server.dart.snapshot", "--lsp" }}
  lua require'nvim_lsp'.pyls.setup{}
  lua require'nvim_lsp'.solargraph.setup{}
  lua require'nvim_lsp'.vimls.setup{}
  lua require'nvim_lsp'.tsserver.setup{}
  lua require'nvim_lsp'.vuels.setup{}
  lua require'nvim_lsp'.yamlls.setup{}
  lua require'nvim_lsp'.dockerls.setup{}

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
