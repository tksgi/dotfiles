local M = {}
M.config = function()
  -- local capabilities = require('cmp_nvim_lsp').default_capabilities()
  local custom_attach = function(client, bufnr)
    require("nvim-navic").attach(client, bufnr)

    local bufopts = { noremap = true, silent = true, buffer = bufnr }
    -- helpのexampleキーマップ
    vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
    vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
    -- vim.keymap.set('n', 'gd', '<cmd>split<cr><cmd>lua vim.lsp.buf.definition()<cr>', bufopts)
    vim.keymap.set('n', '<c-]>', vim.lsp.buf.definition, bufopts)
    vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
    vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
    vim.keymap.set('n', '<c-k>', vim.lsp.buf.signature_help, bufopts)
    vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
    vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)

    -- Create Command
    vim.api.nvim_buf_create_user_command(bufnr, "LspDeclaration", vim.lsp.buf.declaration, {})
    vim.api.nvim_buf_create_user_command(bufnr, "LspDefinition", vim.lsp.buf.definition, {})
    -- vim.api.nvim_buf_create_user_command(bufnr, "LspPeekDefinition", vim.lsp.buf.peek_definition, {})
    vim.api.nvim_buf_create_user_command(bufnr, "Lsphover", vim.lsp.buf.hover, {})
    vim.api.nvim_buf_create_user_command(bufnr, "LspImpletentation", vim.lsp.buf.implementation, {})
    vim.api.nvim_buf_create_user_command(bufnr, "LspSignatureHelp", vim.lsp.buf.signature_help, {})
    vim.api.nvim_buf_create_user_command(bufnr, "LspTypeDefinition", vim.lsp.buf.type_definition, {})
    vim.api.nvim_buf_create_user_command(bufnr, "LspReferences", vim.lsp.buf.references, {})
    vim.api.nvim_buf_create_user_command(bufnr, "LspCodeAction", function() vim.lsp.buf.code_action() end, {})
    vim.api.nvim_buf_create_user_command(bufnr, "LspRename", vim.lsp.buf.rename, {})
    vim.api.nvim_buf_create_user_command(bufnr, "LspFormat", function() vim.lsp.buf.format({}) end, {})
    vim.api.nvim_buf_create_user_command(bufnr, "LspShowLineDiagnostics", vim.diagnostic.open_float, {})
    vim.api.nvim_buf_create_user_command(bufnr, "LspAddWorkspaceFolder",
      function() vim.lsp.buf.add_workspace_folder() end, {})
    vim.api.nvim_buf_create_user_command(bufnr, "LspRemoveWorkspaceFolder", vim.lsp.buf.remove_workspace_folder, {})
    vim.api.nvim_buf_create_user_command(bufnr, "LspListWorkspaceFolder",
      function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, {})
  end

  require 'lspconfig'.vimls.setup {
    on_attach = custom_attach,
    -- capabilities = capabilities
  }
  require 'lspconfig'.tsserver.setup {
    on_attach = custom_attach,
    -- capabilities = capabilities
  }
  require 'lspconfig'.gopls.setup {
    on_attach = custom_attach,
    -- capabilities = capabilities
  }
  require 'lspconfig'.yamlls.setup {
    on_attach = custom_attach,
    -- capabilities = capabilities
  }
  require 'lspconfig'.dockerls.setup {
    on_attach = custom_attach,
    -- capabilities = capabilities
  }
  require 'lspconfig'.lua_ls.setup({
    on_attach = custom_attach,
    -- capabilities = capabilities,
    settings = {
      Lua = {
        completion = {
          callSnippet = "Replace",
        },
      },
    },
  })
end
return M
