
-- Aerial config
-- local aerial = require'aerial'
--
-- local custom_attach = function(client, bufnr)
--   aerial.on_attach(client)
--   --require'completion'.on_attach()
--
--   -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
--   -- vim.cmd([[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting()]])
--
--   -- Aerial does not set any mappings by default, so you'll want to set some up
--   local mapper = function(mode, key, result)
--     vim.fn.nvim_buf_set_keymap(0, mode, key, result, {noremap = true, silent = true})
--   end
--   -- Toggle the aerial pane with <leader>a
--   mapper('n', '<leader>a', '<cmd>lua require"aerial".toggle(false, ">")<CR>')
--   -- Jump forwards/backwards with '[[' and ']]'
--   mapper('n', '[[', '<cmd>lua require"aerial".prev_item()<CR>zvzz')
--   mapper('v', '[[', '<cmd>lua require"aerial".prev_item()<CR>zvzz')
--   mapper('n', ']]', '<cmd>lua require"aerial".next_item()<CR>zvzz')
--   mapper('v', ']]', '<cmd>lua require"aerial".next_item()<CR>zvzz')
--
--   -- This is a great place to set up all your other LSP mappings
--   aerial.set_filter_kind{
--     'Function',
--     'Class',
--     'Constructor',
--     'Method',
--     'Struct',
--     'Enum',
--     'Field',
--   }
-- end
----------------

-- for flutter installed by flutter repository
-- local dartBin = string.sub(vim.fn.system('which flutter | rev | cut -f 2- -d/ | rev'), 1, -2)
--
-- for flutter installed by asdf 
local dartBin = string.sub(vim.fn.system([[echo "$ASDF_DIR/installs/flutter/$(asdf current flutter | sed -E 's/ +/ /g' | cut -f 2 -d ' ')/bin"]]), 1, -2)

-- $ asdf current flutter | sed -E 's/ +/ /g' | cut -f 2 -d ' '
require'lspconfig'.dartls.setup{
  cmd = {dartBin .. [[/dart]], dartBin .. [[/cache/dart-sdk/bin/snapshots/analysis_server.dart.snapshot]], '--lsp'},
}
-- START lua lsp config
-- local function sumneko_command()
--   local cache_location = vim.fn.stdpath('cache')
--   local bin_location = jit.os
--   if vim.fn.has('mac') then
--     bin_location = 'macOS'
--   end
--
--   return {
--       string.format(
--       "%s/lspconfig/sumneko_lua/lua-language-server/bin/%s/lua-language-server",
--       cache_location,
--         bin_location
--     ),
--       "-E",
--       string.format(
--       "%s/lspconfig/sumneko_lua/lua-language-server/main.lua",
--       cache_location
--     ),
--     }
-- end
--
-- -- To get builtin LSP running, do something like:
-- -- NOTE: This replaces the calls where you would have before done `require('nvim_lsp').sumneko_lua.setup()`
-- -- require('nlua.lsp.nvim').setup(require('lspconfig'), {
-- --   cmd = sumneko_command(),
-- --   on_attach = custom_attach,
-- -- })
-- -- lua lsp end
-- require'lspconfig'.sumneko_lua.setup {
--     settings = {
--         Lua = {
--             runtime = {
--                 -- LuaJITやLua 5.4などのバージョンを設定します。
--                 version = 'LuaJIT',
--                 -- luaのpathを設定します。
--                 path = vim.split(package.path, ';'),
--             },
--             diagnostics = {
--                 -- vimモジュールを設定します。
--                 globals = {'vim'},
--             },
--             workspace = {
--                 -- Neovimのランタイムファイルを設定します。
--                 library = {
--                     [vim.fn.expand('$VIMRUNTIME/lua')] = true,
--                     [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
--                 },
--             },
--         },
--     },
-- }
-- END lua config

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

local on_attach = function(client, bufnr)
  -- START キーマップ追加
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end

  local opts = { noremap=true, silent=true }

  -- helpのexampleキーマップ
  buf_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.declaration()<CR>", opts)
  buf_set_keymap("n", "<c-]>", "<cmd>lua vim.lsp.buf.definition()<CR>", opts)
  buf_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", opts)
  buf_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.implementation()<CR>", opts)
  buf_set_keymap("n", "<c-k>", "<cmd>lua vim.lsp.buf.signature_help()<CR>", opts)
  buf_set_keymap("n", "1gD", "<cmd>lua vim.lsp.buf.type_definition()<CR>", opts)
  buf_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>", opts)
  buf_set_keymap("n", "<leader>c", "<cmd>lua vim.lsp.buf.code_action()<CR>", opts)
  buf_set_keymap("n", "<leader>D", "<cmd>lua vim.lsp.diagnostic.show_line_diagnostics()<CR>", opts)

  -- カスタムキーマップ
  buf_set_keymap("n", "<leader><c-]>", "<cmd>lua vim.lsp.buf.peek_definition()<CR>", opts)

  -- lspsagaのキーマップ
  buf_set_keymap("n", "gr", "<cmd>Lspsaga rename<cr>", opts)
  buf_set_keymap("n", "gx", "<cmd>Lspsaga code_action<cr>", opts)
  buf_set_keymap("n", "gx", ":<c-u>Lspsaga range_code_action<cr>", opts)
  buf_set_keymap("n", "K",  "<cmd>Lspsaga hover_doc<cr>", opts)
  buf_set_keymap("n", "go", "<cmd>Lspsaga show_line_diagnostics<cr>", opts)
  buf_set_keymap("n", "gj", "<cmd>Lspsaga diagnostic_jump_next<cr>", opts)
  buf_set_keymap("n", "gk", "<cmd>Lspsaga diagnostic_jump_prev<cr>", opts)
  buf_set_keymap("n", "<C-u>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<cr>", opts)
  buf_set_keymap("n", "<C-d>", "<cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<cr>", opts)

  -- END キーマップ追加
end

local lsp_installer = require("nvim-lsp-installer")
lsp_installer.on_server_ready(function(server)
  local opts = {}
  opts.on_attach = on_attach

  server:setup(opts)
end)


require"fidget".setup{}
