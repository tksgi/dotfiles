require('mason').setup({})

-- Aerial config
local aerial = require('aerial')
aerial.setup({})

local saga = require('lspsaga')
saga.init_lsp_saga()

-- diagnosticのマッピング
local keyopts = { noremap=true, silent=true }
vim.keymap.set('n', '<leader>D', vim.diagnostic.open_float, keyopts)
vim.keymap.set('n', '<leader>dn', vim.diagnostic.goto_prev, keyopts)
vim.keymap.set('n', '<leader>dp', vim.diagnostic.goto_next, keyopts)
vim.keymap.set('n', '<leader>dl', vim.diagnostic.setloclist, keyopts) -- locationlistにdiagnosticの

local custom_attach = function(client, bufnr)
  aerial.on_attach(client, bufnr)
  --require'completion'.on_attach()

  -- vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')
  -- vim.cmd([[autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting()]])

  local bufopts = { noremap=true, silent=true, buffer=bufnr }
  --
  -- Aerial does not set any mappings by default, so you'll want to set some up
  -- Toggle the aerial pane with <leader>a
  vim.keymap.set('n', '<leader>a', function() aerial.toggle(false, ">") end, bufopts)
  -- Jump forwards/backwards with '[[' and ']]'
  -- vim.keymap.set('n', '[[', aerial.prev_item, bufopts)
  -- vim.keymap.set('v', '[[', aerial.prev_item, bufopts)
  -- vim.keymap.set('n', ']]', aerial.next_item, bufopts)
  -- vim.keymap.set('v', ']]', aerial.next_item, bufopts)

  -- This is a great place to set up all your other LSP mappings
  -- aerial.set_filter_kind{
  --   'Function',
  --   'Class',
  --   'Constructor',
  --   'Method',
  --   'Struct',
  --   'Enum',
  --   'Field',
  -- }

  -- helpのexampleキーマップ
  vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
  vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', '<c-]>', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gtd', vim.lsp.buf.definition, bufopts)
  vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
  vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
  vim.keymap.set('n', '<c-k>', vim.lsp.buf.signature_help, bufopts)
  vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
  vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)


  -- 追加キーマップ
  -- vim.keymap.set('n', '<leader><c-]>', vim.buf.peek_definition, bufopts)

  -- コマンド追加
  vim.api.nvim_buf_create_user_command(bufnr, "LspDeclaration", vim.lsp.buf.declaration, {})
  vim.api.nvim_buf_create_user_command(bufnr, "LspDefinition", vim.lsp.buf.definition, {})
  -- vim.api.nvim_buf_create_user_command(bufnr, "LspPeekDefinition", vim.lsp.buf.peek_definition, {})
  vim.api.nvim_buf_create_user_command(bufnr, "Lsphover", vim.lsp.buf.hover, {})
  vim.api.nvim_buf_create_user_command(bufnr, "LspImpletentation", vim.lsp.buf.implementation, {})
  vim.api.nvim_buf_create_user_command(bufnr, "LspSignatureHelp", vim.lsp.buf.signature_help, {})
  vim.api.nvim_buf_create_user_command(bufnr, "LspTypeDefinition", vim.lsp.buf.type_definition, {})
  vim.api.nvim_buf_create_user_command(bufnr, "LspReferences", vim.lsp.buf.references, {})
  vim.api.nvim_buf_create_user_command(bufnr, "LspCodeAction", vim.lsp.buf.code_action, {})
  vim.api.nvim_buf_create_user_command(bufnr, "LspRename", vim.lsp.buf.rename, {})
  vim.api.nvim_buf_create_user_command(bufnr, "LspFormat", vim.lsp.buf.formatting, {})
  vim.api.nvim_buf_create_user_command(bufnr, "LspShowLineDiagnostivs", vim.diagnostic.open_float, {})
  vim.api.nvim_buf_create_user_command(bufnr, "LspAddWorkspaceFolder", function() vim.lsp.buf.add_workspace_folder() end, {})
  vim.api.nvim_buf_create_user_command(bufnr, "LspRemoveWorkspaceFolder", vim.lsp.buf.remove_workspace_folder, {})
  vim.api.nvim_buf_create_user_command(bufnr, "LspListWorkspaceFolder", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, {})
end
----------------

-- local dartBin = string.sub(vim.fn.system('which flutter | rev | cut -f 2- -d/ | rev'), 1, -2)
local dartBin = string.sub(vim.fn.system([[echo "$ASDF_DIR/installs/flutter/$(asdf current flutter | sed -E 's/ +/ /g' | cut -f 2 -d ' ')/bin"]]), 1, -2)

-- $ asdf current flutter | sed -E 's/ +/ /g' | cut -f 2 -d ' '
require'lspconfig'.dartls.setup{
  cmd = {dartBin .. [[/dart]], dartBin .. [[/cache/dart-sdk/bin/snapshots/analysis_server.dart.snapshot]], '--lsp'},
  init_options = {
    flags = {allow_incremental_sync = true},
    closingLabels = true,
    outline = true,
    flutterOutline = true,
  },
  on_attach = function(client, bufnr)
    custom_attach(client, bufnr)
--    vim.cmd("command FlutterRestart    lua require('flutter-tools').restart()<CR>")
--    vim.cmd("command FlutterQuit    lua require('flutter-tools').quit()<CR>")
--    vim.cmd("command FlutterDevices    lua require('flutter-tools').devices()<CR>")
--    vim.cmd("command FlutterEmulators    lua require('flutter-tools').emulators()<CR>")
--    vim.cmd("command FlutterOutline    lua require('flutter-tools').open_outline()<CR>")
--    vim.cmd("command FlutterDevTools    lua require('flutter-tools').dev_tools()<CR>")
  end,
  handlers = {
    ['dart/textDocument/publishClosingLabels'] = require('flutter-tools').closing_tags,
    ['dart/textDocument/publishOutline'] = require('flutter-tools').outline,
  },
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
-- require'lspconfig'.pyright.setup{
--   on_attach = custom_attach,
-- }
require'lspconfig'.dockerls.setup{
  on_attach = custom_attach,
}

-- for rust
require('rust-tools').setup({
  on_attach = custom_attach,
  server = {
    cargo = {
      loadOutDirsFromCheck = true
    }
  }
})


-- -- NOTE: This replaces the calls where you would have before done `require('nvim_lsp').sumneko_lua.setup()`
-- require('nlua.lsp.nvim').setup(require('lspconfig'), {
--   on_attach = custom_attach,
--
--   -- Include globals you want to tell the LSP are real :)
--   globals = {
--     -- Colorbuddy
--     "Color", "c", "Group", "g", "s",
--   }
-- })
require'lspconfig'.sumneko_lua.setup({
  on_attach = custom_attach,
    settings = {
        Lua = {
            runtime = {
                -- LuaJITやLua 5.4などのバージョンを設定します。
                version = 'LuaJIT',
                -- luaのpathを設定します。
                -- path = vim.split(package.path, ';'),
            },
            diagnostics = {
                -- vimモジュールを設定します。
                globals = {'vim'},
            },
            workspace = {
                -- Neovimのランタイムファイルを設定します。
                liberary = vim.api.nvim_get_runtime_file("", true)
                -- library = {
                --     [vim.fn.expand('$VIMRUNTIME/lua')] = true,
                --     [vim.fn.expand('$VIMRUNTIME/lua/vim/lsp')] = true,
                -- },
            },
        },
    },
})



