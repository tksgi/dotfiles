local build = function()
  vim.fn.system({ 'go', 'install', 'github.com/mattn/efm-langserver@latest' })
end

-- local lsp_buf_config = function(ev)
--
--   local bufopts = { noremap = true, silent = true, buffer = ev.buf }
--   -- helpのexampleキーマップ
--   vim.keymap.set('n', 'gD', vim.lsp.buf.declaration, bufopts)
--   vim.keymap.set('n', 'gd', vim.lsp.buf.definition, bufopts)
--   -- vim.keymap.set('n', 'gd', '<cmd>split<cr><cmd>lua vim.lsp.buf.definition()<cr>', bufopts)
--   vim.keymap.set('n', '<c-]>', vim.lsp.buf.definition, bufopts)
--   vim.keymap.set('n', 'gi', vim.lsp.buf.implementation, bufopts)
--   vim.keymap.set('n', 'K', vim.lsp.buf.hover, bufopts)
--   vim.keymap.set('n', '<c-k>', vim.lsp.buf.signature_help, bufopts)
--   vim.keymap.set('n', 'gr', vim.lsp.buf.references, bufopts)
--   vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action, bufopts)
--   vim.keymap.set('n', '<leader>=', vim.lsp.buf.format, bufopts)
--
--   -- Create Command
--   vim.api.nvim_buf_create_user_command(ev.buf, "LspDeclaration", vim.lsp.buf.declaration, {})
--   vim.api.nvim_buf_create_user_command(ev.buf, "LspDefinition", vim.lsp.buf.definition, {})
--   -- vim.api.nvim_buf_create_user_command(ev.buf, "LspPeekDefinition", vim.lsp.buf.peek_definition, {})
--   vim.api.nvim_buf_create_user_command(ev.buf, "Lsphover", vim.lsp.buf.hover, {})
--   vim.api.nvim_buf_create_user_command(ev.buf, "LspImpletentation", vim.lsp.buf.implementation, {})
--   vim.api.nvim_buf_create_user_command(ev.buf, "LspSignatureHelp", vim.lsp.buf.signature_help, {})
--   vim.api.nvim_buf_create_user_command(ev.buf, "LspTypeDefinition", vim.lsp.buf.type_definition, {})
--   vim.api.nvim_buf_create_user_command(ev.buf, "LspReferences", vim.lsp.buf.references, {})
--   vim.api.nvim_buf_create_user_command(ev.buf, "LspCodeAction", function() vim.lsp.buf.code_action() end, {})
--   vim.api.nvim_buf_create_user_command(ev.buf, "LspRename", vim.lsp.buf.rename, {})
--   vim.api.nvim_buf_create_user_command(ev.buf, "LspFormat", function() vim.lsp.buf.format({}) end, {})
--   vim.api.nvim_buf_create_user_command(ev.buf, "LspShowLineDiagnostics", vim.diagnostic.open_float, {})
--   vim.api.nvim_buf_create_user_command(ev.buf, "LspAddWorkspaceFolder",
--     function() vim.lsp.buf.add_workspace_folder() end, {})
--   vim.api.nvim_buf_create_user_command(ev.buf, "LspRemoveWorkspaceFolder", vim.lsp.buf.remove_workspace_folder, {})
--   vim.api.nvim_buf_create_user_command(ev.buf, "LspListWorkspaceFolder",
--     function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, {})
-- end

-- local config = function()
--   -- 基本的な診断設定
--   vim.diagnostic.config({
--     virtual_text = true,
--     signs = true,
--     underline = true,
--     update_in_insert = false,
--     severity_sort = false,
--   })
--   local  lspconfig = require('lspconfig')
--   local default_config = vim.tbl_extend(
--     "force",
--     lspconfig.util.default_config,
--     {
--       on_attach = function(client, bufnr)
--         require("nvim-navic").attach(client, bufnr)
--       end,
--     }
--   )
--
--   if vim.g.completion_plugin == 'ddc' then
--     local capabilities = require("ddc_source_lsp").make_client_capabilities()
--     default_config['capabilities'] = capabilities
--   end
--
--   lspconfig.util.default_config = default_config
--
--   lspconfig.vimls.setup { }
--   lspconfig.ts_ls.setup {
--     -- -- autostart = false,
--     -- settings = {
--     --   typescript = {
--     --     inlayHints = {
--     --       includeInlayParameterNameHints = 'all',
--     --       includeInlayParameterNameHintsWhenArgumentMatchesName = false,
--     --       includeInlayFunctionParameterTypeHints = true,
--     --       includeInlayVariableTypeHints = true,
--     --       includeInlayVariableTypeHintsWhenTypeMatchesName = false,
--     --       includeInlayPropertyDeclarationTypeHints = true,
--     --       includeInlayFunctionLikeReturnTypeHints = true,
--     --       includeInlayEnumMemberValueHints = true,
--     --     }
--     --   },
--     --   javascript = {
--     --     inlayHints = {
--     --       includeInlayParameterNameHints = 'all',
--     --       includeInlayParameterNameHintsWhenArgumentMatchesName = false,
--     --       includeInlayFunctionParameterTypeHints = true,
--     --       includeInlayVariableTypeHints = true,
--     --       includeInlayVariableTypeHintsWhenTypeMatchesName = false,
--     --       includeInlayPropertyDeclarationTypeHints = true,
--     --       includeInlayFunctionLikeReturnTypeHints = true,
--     --       includeInlayEnumMemberValueHints = true,
--     --     }
--     --   }
--     -- }
--   }
--
--   lspconfig.gopls.setup { }
--   lspconfig.yamlls.setup { }
--   lspconfig.dockerls.setup { }
--   lspconfig.lua_ls.setup({
--     settings = {
--       Lua = {
--         completion = {
--           callSnippet = "Replace",
--         },
--         hint = { enable = true },
--         format = { enable = true },
--         runtime = { checkThirdParty = true },
--         workspace = { library = vim.api.nvim_get_runtime_file("", true) },
--       },
--     },
--   })
--
--   vim.api.nvim_create_autocmd('LspAttach', {
--     group = vim.api.nvim_create_augroup('UserLspConfig', {}),
--     callback = lsp_buf_config,
--   })
--
--   vim.keymap.set('n', '<space>e', vim.diagnostic.open_float)
--   vim.keymap.set('n', '[d', vim.diagnostic.goto_prev)
--   vim.keymap.set('n', ']d', vim.diagnostic.goto_next)
--   vim.keymap.set('n', '<space>q', vim.diagnostic.setloclist)
-- end


local config = function()
  -- 基本的な診断設定
  vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = false,
  })

  -- LSPアタッチ時の設定
  vim.api.nvim_create_autocmd('LspAttach', {
    group = vim.api.nvim_create_augroup('UserLspConfig', { clear = true }),
    callback = function(args)
      local client = vim.lsp.get_client_by_id(args.data.client_id)
      local bufnr = args.buf

      -- nvim-navicの設定
      if client then
        require("nvim-navic").attach(client, bufnr)
      end

      -- カスタムキーマップの設定
      local opts = { buffer = bufnr, silent = true, noremap = true }

      -- Neovim 0.10+のデフォルトキーマップに加えて、カスタムキーマップを追加
      vim.keymap.set('n', 'gD', vim.lsp.buf.declaration,
        vim.tbl_extend('force', opts, { desc = 'LSP: Go to Declaration' }))
      vim.keymap.set('n', 'gd', vim.lsp.buf.definition,
        vim.tbl_extend('force', opts, { desc = 'LSP: Go to Definition' }))
      -- vim.keymap.set('n', '<c-]>', vim.lsp.buf.definition,
      --   vim.tbl_extend('force', opts, { desc = 'LSP: Go to Definition' }))
      vim.keymap.set('n', 'gi', vim.lsp.buf.implementation,
        vim.tbl_extend('force', opts, { desc = 'LSP: Go to Implementation' }))
      vim.keymap.set('n', 'K', vim.lsp.buf.hover,
        vim.tbl_extend('force', opts, { desc = 'LSP: Hover Documentation' }))
      vim.keymap.set('n', '<c-k>', vim.lsp.buf.signature_help,
        vim.tbl_extend('force', opts, { desc = 'LSP: Signature Help' }))
      vim.keymap.set('n', 'gr', vim.lsp.buf.references,
        vim.tbl_extend('force', opts, { desc = 'LSP: References' }))
      vim.keymap.set('n', '<leader>ca', vim.lsp.buf.code_action,
        vim.tbl_extend('force', opts, { desc = 'LSP: Code Action' }))
      vim.keymap.set('n', '<leader>=', vim.lsp.buf.format,
        vim.tbl_extend('force', opts, { desc = 'LSP: Format Buffer' }))

      -- カスタムコマンドの作成
      local commands = {
        LspDeclaration = vim.lsp.buf.declaration,
        LspDefinition = vim.lsp.buf.definition,
        LspHover = vim.lsp.buf.hover,
        LspImplementation = vim.lsp.buf.implementation,
        LspSignatureHelp = vim.lsp.buf.signature_help,
        LspTypeDefinition = vim.lsp.buf.type_definition,
        LspReferences = vim.lsp.buf.references,
        LspCodeAction = vim.lsp.buf.code_action,
        LspRename = vim.lsp.buf.rename,
        LspFormat = function() vim.lsp.buf.format({}) end,
        LspShowLineDiagnostics = vim.diagnostic.open_float,
        LspAddWorkspaceFolder = vim.lsp.buf.add_workspace_folder,
        LspRemoveWorkspaceFolder = vim.lsp.buf.remove_workspace_folder,
        LspListWorkspaceFolder = function()
          print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
        end,
      }

      for cmd_name, cmd_func in pairs(commands) do
        vim.api.nvim_buf_create_user_command(bufnr, cmd_name, cmd_func, {})
      end
    end,
  })
  local servers = {
    'vimls',
    'ts_ls',
    'gopls',
    'yamlls',
    'dockerls',
    'lua_ls',
  }

  vim.lsp.config('*', {})
  vim.lsp.enable(servers)
end

---@type LazySpec
local spec = {
  'neovim/nvim-lspconfig',
  dependencies = {
    'neodev.nvim',
    { "SmiteshP/nvim-navic",     enabled = true },
    { 'simrat39/rust-tools.nvim' },
    -- { 'https://github.com/lvimuser/lsp-inlayhints.nvim', config = true },
    {
      'Shougo/ddc-source-lsp',
      enabled = vim.g.completion_plugin == 'ddc',
    },
  },
  build = build,
  config = config,
}
return spec
