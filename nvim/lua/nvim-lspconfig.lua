-- vim.cmd('packadd nvim-lspconfig')

-- Aerial config
local aerial = require'aerial'

local custom_attach = function(client)
  aerial.on_attach(client)

  -- Aerial does not set any mappings by default, so you'll want to set some up
  local mapper = function(mode, key, result)
    vim.fn.nvim_buf_set_keymap(0, mode, key, result, {noremap = true, silent = true})
  end
  -- Toggle the aerial pane with <leader>a
  mapper('n', '<leader>a', '<cmd>lua require"aerial".toggle(false, ">")<CR>')
  -- Jump forwards/backwards with '[[' and ']]'
  mapper('n', '[[', '<cmd>lua require"aerial".prev_item()<CR>zvzz')
  mapper('v', '[[', '<cmd>lua require"aerial".prev_item()<CR>zvzz')
  mapper('n', ']]', '<cmd>lua require"aerial".next_item()<CR>zvzz')
  mapper('v', ']]', '<cmd>lua require"aerial".next_item()<CR>zvzz')

  -- This is a great place to set up all your other LSP mappings
  aerial.set_filter_kind{
    'Function',
    'Class',
    'Constructor',
    'Method',
    'Struct',
    'Enum',
    'Field',
  }
end
----------------

local dartBin = string.sub(vim.fn.system('which flutter | rev | cut -f 2- -d/ | rev'), 1, -2)
require'lspconfig'.dartls.setup{
  cmd = {dartBin .. [[/dart]], dartBin .. [[/cache/dart-sdk/bin/snapshots/analysis_server.dart.snapshot]], '--lsp'},
  init_options = {
    closingLabels = true,
  },
  -- callbacks = {
  --   ['dart/textDocument/publishClosingLabels'] = require('lsp_extensions.dart.closing_labels').get_callback({highlight = "Special", prefix = " >> "}),
  -- }
  on_attach = custom_attach,
}
require'lspconfig'.gopls.setup{
  on_attach = custom_attach,
}
require'lspconfig'.pyls.setup{
  on_attach = custom_attach,
}
require'lspconfig'.solargraph.setup{
  on_attach = custom_attach,
}
require'lspconfig'.vimls.setup{
  on_attach = custom_attach,
}
require'lspconfig'.tsserver.setup{
  on_attach = custom_attach,
}
require'lspconfig'.vuels.setup{
  on_attach = custom_attach,
}
require'lspconfig'.yamlls.setup{
  on_attach = custom_attach,
}
require'lspconfig'.dockerls.setup{
  on_attach = custom_attach,
}
require'lspconfig'.sumneko_lua.setup{
  on_attach = custom_attach,
}

-- helpのexampleキーマップ
vim.cmd("nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>")
vim.cmd("nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>")
vim.cmd("nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>")
vim.cmd("nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>")
vim.cmd("nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>")
vim.cmd("nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>")
vim.cmd("nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>")
vim.cmd("nnoremap <silent> <leader>.    <cmd>lua vim.lsp.buf.code_action()<CR>")


-- 追加キーマップ
vim.cmd("nnoremap <silent> <leader><c-]> <cmd>lua vim.lsp.buf.peek_definition()<CR>")

-- コマンド追加
vim.cmd("command LspDeclaration    lua vim.lsp.buf.declaration()<CR>")
vim.cmd("command LspDefinition     lua vim.lsp.buf.definition()<CR>")
vim.cmd("command LspPeekDefinition lua vim.lsp.buf.peek_definition()<CR>")
vim.cmd("command Lsphover          lua vim.lsp.buf.hover()<CR>")
vim.cmd("command LspImpletentation lua vim.lsp.buf.implementation()<CR>")
vim.cmd("command LspSignatureHelp  lua vim.lsp.buf.signature_help()<CR>")
vim.cmd("command LspTypeDefinition lua vim.lsp.buf.type_definition()<CR>")
vim.cmd("command LspReferences     lua vim.lsp.buf.references()<CR>")
vim.cmd("command LspCodeAction     lua vim.lsp.buf.code_action()<CR>")
vim.cmd("command LspRename     lua vim.lsp.buf.rename()<CR>")
vim.cmd("command LspFormat     lua vim.lsp.buf.formatting()<CR>")
vim.cmd("command LspShowLineDiagnostivs     lua vim.lsp.diagnostic.show_line_diagnostics()<CR>")

