-- フォントずれ確認用
-- 0123456789012345678901234567890123456789
-- ｱｲｳｴｵｱｲｳｴｵｱｲｳｴｵｱｲｳｴｵｱｲｳｴｵｱｲｳｴｵｱｲｳｴｵｱｲｳｴｵ
-- あいうえおあいうえおあいうえおあいうえお


vim.opt.fenc = 'utf-8'
vim.opt.undofile = true

vim.opt.cmdheight = 2
vim.opt.backupskip = '/tmp/*'
vim.opt.smartindent = true
vim.opt.visualbell = true
vim.opt.expandtab = true
vim.opt.tabstop = 2
vim.opt.shiftwidth = 2
vim.opt.scrolloff = 3
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.hidden = true -- 編集中でも別bufferを開ける様に
vim.opt.wrap = true

vim.opt.ignorecase = true
vim.opt.smartcase = true
vim.opt.incsearch = true
vim.opt.wrapscan = true
vim.opt.hlsearch = true
vim.opt.inccommand = 'split'

-- vimgrep実行時にquickfixを開く
-- vim.api.nvim_create_autocmd( {'QuickFixCmdPost'}, {
--     -- pattern = { '*grep*' },
--     callback = 'cwindow',
-- })
vim.api.nvim_exec('autocmd QuickFixCmdPost *grep* cwindow', false)

-- ESC連打でハイライト解除
vim.api.nvim_set_keymap("n", "<Esc><Esc>", ':nohlsearch<CR>', {})

--ターミナルで<c-w>でバッファ操作
vim.api.nvim_set_keymap("t", "<C-w><C-w>", '<C-\\><C-n>', { noremap = true, desc = '<C-w>連打でノーマルモード' })
vim.api.nvim_set_keymap("t", "<C-w>h", '<C-\\><C-n><C-w>h', { noremap = true, desc = '<C-w>hでバッファ移動' })
vim.api.nvim_set_keymap("t", "<C-w>j", '<C-\\><C-n><C-w>j', { noremap = true, desc = '<C-w>jでバッファ移動' })
vim.api.nvim_set_keymap("t", "<C-w>k", '<C-\\><C-n><C-w>k', { noremap = true, desc = '<C-w>kでバッファ移動' })
vim.api.nvim_set_keymap("t", "<C-w>l", '<C-\\><C-n><C-w>l', { noremap = true, desc = '<C-w>lでバッファ移動' })


-- D<tab> でカレントディレクトリ展開 → noiceのロード後に設定移動
-- vim.api.nvim_set_keymap("c", "D<TAB>", function() return vim.fn.expand('%:h') end, { desc = 'current dirのパスを展開' })
-- vim.api.nvim_set_keymap("c", "%<TAB>", function() return vim.fn.expand('%') end, { desc = 'current fileのパスを展開' })

-- <C-w><C-w>でフローティングウィンドウにフォーカス
function Focus_floating()
  if vim.api.nvim_win_get_config(vim.fn.win_getid())['relative'] then
    vim.api.nvim_command('wincmd p')
    return
  end
  for winnr = 1, vim.fn.winnr() do
    local winid = vim.fn.win_getid(winnr)
    local conf = vim.api.nvim_win_get_config(winid)
    if conf['focusable'] and conf['relative'] then
      vim.fn.win_gotoid(winid)
      return
    end
  end
end

vim.keymap.set("n", "<C-w><C-w>", Focus_floating, { noremap = true, silent = true, desc = 'フローティングウィンドウにフォーカス' })

vim.api.nvim_del_keymap('n', 'Y')
vim.api.nvim_set_keymap("n", "<F1>", '<cmd>e ~/.config/nvim/init.lua<cr>', { noremap = true, desc = '<F1>でinit.luaを開く' })


-- plugins with lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-- vim.g.mapleader = '<Space>'
-- vim.g.maplocalleader = '\\\\'

require("lazy").setup({
  {
    'EdenEast/nightfox.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.cmd('colorscheme nordfox')
    end
  },
  'vim-jp/vimdoc-ja',
  {
    'lukas-reineke/indent-blankline.nvim',
    config = function()
      vim.opt.list = true
      vim.opt.listchars:append "space:⋅"
      vim.opt.listchars:append "eol:↴"
      vim.opt.listchars:append 'tab:▸-'

      require("indent_blankline").setup {
        space_char_blankline = " ",
        show_current_context = true,
        show_current_context_start = true,
      }
    end
  },
  {
    'mbbill/undotree',
    keys = {
      { "<F5>", "<cmd>UndotreeToggle<cr>", desc = 'undotree toggle' }
    }
  },
  { 'godlygeek/tabular', cmd = { 'Tabularize' } },
  { 'simeji/winresizer', keys = { '<c-e>' } },
  {
    'Bakudankun/BackAndForward.vim',
    keys = {
      { '<leader>bb', '<cmd>Back<cr>',    desc = 'Back buffer' },
      { '<leader>bf', '<cmd>Forward<cr>', desc = 'Forward buffer' },
    }
  },
  {
    'numToStr/Comment.nvim',
    config = true,
  },
  {
    'folke/todo-comments.nvim',
    dependencies = { 'nvim-lua/plenary.nvim' },
    config = true,
  },
  {
    'mvllow/modes.nvim',
    tag = 'v0.2.0',
    config = function()
      require('modes').setup({
        colors = {
          copy = "#f5c359",
          delete = "#c75c6a",
          insert = "#78ccc5",
          visual = "#9745be",
        },
        set_cursore = true,
        set_cursorline = true,
        set_number = true,
      })
    end
  },
  {
    'folke/which-key.nvim',
    lazy = false,
    config = function()
      vim.o.timeout = true
      vim.o.timeoutlen = 300
      require("which-key").setup({})
      local wk = require("which-key")
      -- D<tab> でカレントディレクトリ展開
      -- wk.register({
      --   ['d<TAB>'] = { function() return vim.fn.expand('%:h') end, 'current dirのパスを展開' },
      --   ['%<TAB>'] = { function() return vim.fn.expand('%') end, 'current fileのパスを展開' },
      -- }, { mode = 'c' }
      -- )
    end
  },

  { 'vim-denops/denops.vim',   lazy = false },
  {
    'lambdalisue/guise.vim',
    dependencies = { 'vim-denops/denops.vim' },
  },
  {
    'lambdalisue/gin.vim',
    dependencies = { 'vim-denops/denops.vim' },
  },
  {
    'lambdalisue/fern.vim',
    lazy = false,
    dependencies = {
      { 'lambdalisue/fern-hijack.vim',           lazy = false },
      { 'ryanoasis/vim-devicons' },
      { 'nvim-tree/nvim-web-devicons' },
      { 'lambdalisue/nerdfont.vim' },
      { 'lambdalisue/fern-renderer-nerdfont.vim' },
      { 'lambdalisue/fern-git-status.vim' },
      { 'lambdalisue/fern-mapping-git.vim' },
      { 'lambdalisue/fern-hijack.vim' },
      { 'lambdalisue/fern-bookmark.vim' },
      { 'lambdalisue/fern-mapping-quickfix.vim' },
      { 'yuki-yano/fern-preview.vim' },
    },
    config = function()
      vim.api.nvim_exec(
        [[
        let g:fern#renderer = "nerdfont"
        function! s:fern_settings() abort
          nmap <silent> <buffer> p     <Plug>(fern-action-preview:toggle)
          nmap <silent> <buffer> <C-p> <Plug>(fern-action-preview:auto:toggle)
          nmap <silent> <buffer> <C-d> <Plug>(fern-action-preview:scroll:down:half)
          nmap <silent> <buffer> <C-u> <Plug>(fern-action-preview:scroll:up:half)
        endfunction

        augroup fern-settings
          autocmd!
          autocmd FileType fern call s:fern_settings()
        augroup END
        ]], false
      )
    end
  },
  {
    'folke/noice.nvim',
    config = function()
      require("noice").setup({
        lsp = {
          -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
          override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
            ["vim.lsp.util.stylize_markdown"] = true,
            ["cmp.entry.get_documentation"] = true,
          },
        },
        presets = {
          long_message_to_split = true,
          lsp_doc_border = true,
        },
        messages = {
          view_search = false,
        },
      })
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      'nvim-notify'
    },
  },
  {
    "rcarriga/nvim-notify",
    config = function()
      vim.notify = require("notify")

      vim.notify.setup({
        timeout = 10000,
        top_down = false,
      })

      function Notify_output(command_string, opts)
        local command = {}
        local i = 1
        for s in string.gmatch(command_string, "([^ ]+)") do
          command[i] = s
          i = i + 1
        end
        local output = ""
        local notification
        local notify = function(msg, level)
          local notify_opts = vim.tbl_extend(
            "keep",
            opts or {},
            { title = table.concat(command, " "), replace = notification }
          )
          notification = vim.notify(msg, level, notify_opts)
        end
        local on_data = function(_, data)
          output = output .. table.concat(data, "\n")
          notify(output, "info")
        end
        vim.fn.jobstart(command, {
          on_stdout = on_data,
          on_stderr = on_data,
          on_exit = function(_, code)
            if #output == 0 then
              notify("No output of command, exit code: " .. code, "warn")
            end
          end,
        })
      end
    end
  },
  -- {
  --   'akinsho/toggleterm.nvim',
  --   version = '*',
  --   config = function()
  --     require("toggleterm").setup {
  --       open_mapping = [[<c-t>]]
  --     }
  --   end
  -- },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-web-devicons',
      'noice.nvim',
    },
    config = function()
      require("lualine").setup({
        sections = {
          --lualine_c = {
          --  {
          --    'filename'
          --  },
          --  {
          --    require("noice").api.status.message.get_hl,
          --    cond = require("noice").api.status.message.has,
          --  },
          --},
          lualine_x = {
            {
              require("noice").api.status.command.get,
              cond = require("noice").api.status.command.has,
              color = { fg = "ff9e64" },
            },
            {
              require("noice").api.status.mode.get,
              cond = require("noice").api.status.mode.has,
              color = { fg = "ff9e64" },
            },
            {
              require("noice").api.status.search.get,
              cond = require("noice").api.status.search.has,
              color = { fg = "ff9e64" },
            },
          },
        },
      })
    end,
  },
  {
    'kdheepak/tabline.nvim',
    dependencies = { 'nvim-web-devicons' },
    config = function()
      require 'tabline'.setup {}
    end
  },
  {
    'michaelb/sniprun',
    build = 'bash ./install.sh',
    config = function()
      require 'sniprun'.setup({
        display = { "Terminal" },
      })
    end
  },
  {
    't9md/vim-choosewin',
    keys = {
      { '-', '<cmd>ChooseWin<cr>', desc = 'ウィンドウを選択して移動' }
    },
    config = function()
      vim.api.nvim_exec(
        [[
        let g:choosewin_overlay_enable = 1
        let g:choosewin_overlay_clear_multibyte = 1
      ]], false
      )
    end
  },
  {
    'glepnir/dashboard-nvim',
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {
        -- config
      }
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } }
  },

  -- filetype plugin
  { 'kevinhwang91/nvim-bqf',   ft = 'qf' },
  { 'plasticboy/vim-markdown', ft = { 'markdown' } },
  { 'previm/previm',           ft = { 'markdown' } },
  { 'keith/rspec.vim',         ft = { 'ruby' } },

  -- treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-context',
      'haringsrob/nvim_context_vt',
      'RRethy/vim-illuminate',
      'RRethy/nvim-treesitter-endwise',
      "nvim-treesitter/nvim-treesitter-textobjects",
    },
    build = ":TSUpdate",
    config = function()
      require 'nvim-treesitter.configs'.setup {
        highlight = {
          enable = true, -- false will disable the whole extension
          disable = { "ruby" }
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
          -- disable = { "ruby", "python" }
        },
        indent = {
          enable = true,
          disable = { "ruby" }
        },
        textobjects = {
          enable = true,
          -- disable = { "ruby", "python" }
        },
        endwise = {
          enable = true
        },
      }
      -- for setting FOLD with treesitter
      -- vim.api.nvim_create_autocmd({'BufEnter','BufAdd','BufNew','BufNewFile','BufWinEnter'}, {
      --   group = vim.api.nvim_create_augroup('TS_FOLD_WORKAROUND', {}),
      --   callback = function()
      --     vim.opt.foldmethod     = 'expr'
      --     vim.opt.foldexpr       = 'nvim_treesitter#foldexpr()'
      --   end
      -- })
    end
  },
  {
    'stevearc/aerial.nvim',
    config = function()
      require 'aerial'.setup({
        on_attach = function(bufnr)
          vim.keymap.set('n', '{', '<cmd>AerialPrev<CR>', { buffer = bufnr })
          vim.keymap.set('n', '}', '<cmd>AerialNext<CR>', { buffer = bufnr })
        end
      })

      vim.keymap.set('n', '<leader>a', '<cmd>AerialToggle!<CR>', { noremap = true })
    end
  },

  -- builtin LSP
  { 'williamboman/mason.nvim',           config = true },
  { 'williamboman/mason-lspconfig.nvim', config = true, lazy = true },
  { 'folke/neodev.nvim',                 config = true, lazy = true }, -- lua lsにneovimの補完設定を追加
  {
    'neovim/nvim-lspconfig',
    dependencies = {
      'neodev.nvim',
      {
        'jose-elias-alvarez/null-ls.nvim',
        config = function()
          local null_ls = require 'null-ls'

          null_ls.setup({
            sources = {
              null_ls.builtins.diagnostics.rubocop
            }
          })
        end,
        dependencies = { 'plenary.nvim' },
      },
    },
    config = function()
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local custom_attach = function(_, bufnr)
        local bufopts = { noremap = true, silent = true, buffer = bufnr }
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

        -- Create Command
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
        vim.api.nvim_buf_create_user_command(bufnr, "LspFormat", function() vim.lsp.buf.format({}) end, {})
        vim.api.nvim_buf_create_user_command(bufnr, "LspShowLineDiagnostivs", vim.diagnostic.open_float, {})
        vim.api.nvim_buf_create_user_command(bufnr, "LspAddWorkspaceFolder",
          function() vim.lsp.buf.add_workspace_folder() end, {})
        vim.api.nvim_buf_create_user_command(bufnr, "LspRemoveWorkspaceFolder", vim.lsp.buf.remove_workspace_folder, {})
        vim.api.nvim_buf_create_user_command(bufnr, "LspListWorkspaceFolder",
          function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, {})
      end

      require 'lspconfig'.vimls.setup {
        on_attach = custom_attach,
        capabilities = capabilities
      }
      require 'lspconfig'.tsserver.setup {
        on_attach = custom_attach,
        capabilities = capabilities
      }
      require 'lspconfig'.gopls.setup {
        on_attach = custom_attach,
        capabilities = capabilities
      }
      require 'lspconfig'.yamlls.setup {
        on_attach = custom_attach,
        capabilities = capabilities
      }
      require 'lspconfig'.dockerls.setup {
        on_attach = custom_attach,
        capabilities = capabilities
      }
      require 'lspconfig'.lua_ls.setup({
        on_attach = custom_attach,
        capabilities = capabilities,
        settings = {
          Lua = {
            completion = {
              callSnippet = "Replace",
            },
          },
        },
      })
    end
  },
  -- nvim-cmp
  {
    'vim-skk/skkeleton',
    lazy = false,
    dependencies = { 'vim-denops/denops.vim' },
    config = function()
      vim.api.nvim_exec(
        [[
            function! s:skkeleton_init() abort
              let dic_path = stdpath("data") . "/skk_dictionary/"
              call skkeleton#config({
              \ 'globalDictionaries': [dic_path . "SKK-JISYO.L", dic_path . "SKK-JISYO.jinmei", dic_path . "SKK-JISYO.geo", dic_path . "SKK-JISYO.emoji"],
              \ })
              call skkeleton#register_kanatable('rom', {
              \ "z\<Space>": ["\u3000", ''],
              \ })
            endfunction

            augroup skkeleton-initialize-pre
            autocmd!
            autocmd User skkeleton-initialize-pre call s:skkeleton_init()
            augroup END

            imap <C-j> <Plug>(skkeleton-toggle)
            cmap <C-j> <Plug>(skkeleton-toggle)
            ]],
        false)
    end,
    build = function()
      local dic_path = vim.fn.stdpath('data') .. '/skk_dictionary'
      if vim.fn.empty(vim.fn.glob(dic_path)) > 0 then
        vim.fn.system({ 'git', 'clone', 'https://github.com/skk-dev/dict.git', dic_path })
      end
    end
  },
  {
    'tzachar/cmp-tabnine',
    build = './install.sh',
    lazy = true,
    config = function()
      local tabnine = require('cmp_tabnine.config')

      tabnine:setup({
        max_lines = 1000,
        max_num_results = 20,
        sort = true,
        run_on_every_keystroke = true,
        snippet_placeholder = '..',
        ignored_file_types = {
          -- default is not to ignore
          -- uncomment to ignore in lua:
          -- lua = true
        },
        show_prediction_strength = false
      })
    end
  },
  {
    "hrsh7th/nvim-cmp",
    event = { "InsertEnter", "CmdlineEnter", },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { "hrsh7th/cmp-buffer" },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-cmdline' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'hrsh7th/cmp-nvim-lsp-document-symbol' },
      { 'petertriho/cmp-git' },
      { 'ray-x/cmp-treesitter' },
      { 'tzachar/cmp-tabnine' },
      { 'rinx/cmp-skkeleton',                  dependencies = { 'skkeleton' } },
      { "windwp/nvim-autopairs",               config = true, },
      { 'saadparwaiz1/cmp_luasnip',            dependencies = { 'LuaSnip' } },
    },
    config = function()
      vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require 'cmp'

      cmp.event:on(
        'confirm_done',
        cmp_autopairs.on_confirm_done()
      )
      local buffer_source = {
        name = 'buffer',
        option = {
          get_bufnrs = function()
            -- 表示されているbufferのみ
            local bufs = {}
            for _, win in ipairs(vim.api.nvim_list_wins()) do
              bufs[vim.api.nvim_win_get_buf(win)] = true
            end
            return vim.tbl_keys(bufs)

            -- 全てのbuffer
            -- return vim.api.nvim_list_bufs()
          end
        }
      }


      cmp.setup {
        snippet = {
          expand = function(args)
            require('luasnip').lsp_expand(args.body)
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        mapping = cmp.mapping.preset.insert({
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = false }), -- <cr>で確定。未選択時は何もしない
          ['<C-f>'] = cmp.mapping.complete({ config = {sources = {name = 'path'}} }), -- <cr>で確定。未選択時は何もしない
        }),
        sources = cmp.config.sources({
            {
              name = 'skkeleton',
              view = { entries = 'native' },
            },
          },
          {
            { name = 'nvim_lsp' },
            { name = 'nvim_lsp_document_symbol' },
            { name = 'cmp_tabnine' },
            { name = 'treesitter' },
            buffer_source,
            { name = 'path' },
          }),
      }
      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'cmp_git' },
          { name = 'buffer' },
        })
      })

      cmp.setup.filetype('lua', {
        sources = cmp.config.sources({
          { name = 'nvim_lua' },
          { name = 'luasnip' },
          { name = 'nvim_lsp' },
          { name = 'nvim_lsp_document_symbol' },
          { name = 'cmp_tabnine' },
          { name = 'treesitter' },
          buffer_source,
        })
      })

      -- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline('/', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = {
          { name = 'buffer' },
          {
            name = 'cmdline_history',
            option = { history_type = '/' }
          }
        }
      })

      -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
      cmp.setup.cmdline(':', {
        mapping = cmp.mapping.preset.cmdline(),
        sources = cmp.config.sources({
          {
            name = 'path',
            option = {
              trailing_slash = true,
            }
          },
          {
            name = 'cmdline_history',
            option = { history_type = ':' }
          }
        }, {
          { name = 'cmdline' }
        })
      })

      vim.keymap.set('i', '<c-t>', '<cmd>lua require"cmp".complete({ config = { sources = {{name = "cmp_tabnine"}} } })<cr>')
    end
  },

  -- snippet
  {
    'L3MON4D3/LuaSnip',
    version = "1.2.*",
    build = 'make install_jsregexp',
    dependencies = {
      { 'rafamadriz/friendly-snippets' }
    },
    config = function()
      require 'luasnip'.filetype_extend("ruby", { "rails" })
    end
  },

  -- Telescope
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      {
        'nvim-telescope/telescope-frecency.nvim',
        dependencies = {
          { 'kkharji/sqlite.lua' },
          { 'nvim-tree/nvim-web-devicons' },
        },
      },
      { 'nvim-telescope/telescope-packer.nvim' },
      { 'nvim-telescope/telescope-symbols.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim',  build = 'make' },
      -- { 'nvim-telescope/telescope-command-palette.nvim' },
      { 'debugloop/telescope-undo.nvim' },
      { "nvim-telescope/telescope-file-browser.nvim" },
      { "nvim-telescope/telescope-ghq.nvim" },
      { "benfowler/telescope-luasnip.nvim" },
      { "xiyaowong/telescope-emoji.nvim" },
      {
        'folke/trouble.nvim',
        dependencies = {
          'nvim-web-devicons'
        },
        config = true,
      }
    },
    cmd = { "Telescope" },
    keys = {
      { '<leader>T',  '<cmd>Telescope<cr>',                desc = 'Telescope show default pickers' },
      { '<leader>ff', '<cmd>Telescope find_files<cr>',     desc = 'Telescope find_files' },
      { '<leader>lg', '<cmd>Telescope live_grep<cr>',      desc = 'Telescope live_grep' },
      { '<leader>ls', '<cmd>Telescope buffers<cr>',        desc = 'Telescope buffers' },
      { '<leader>O',  '<cmd>Telescope oldfiles<cr>',       desc = 'Telescope oldfiles' },
      { '<leader>ht', '<cmd>Telescope help_tags<cr>',      desc = 'Telescope help_tags' },
      { '<leader>lr', '<cmd>Telescope lsp_references<cr>', desc = 'Telescope lsp_references' },
      { '<leader>gc', '<cmd>Telescope git_commits<cr>',    desc = 'Telescope git_commits' },
      { '<leader>gb', '<cmd>Telescope git_branches<cr>',   desc = 'Telescope git_branches' },
      { '<leader>gs', '<cmd>Telescope git_status<cr>',     desc = 'Telescope git_status' },
      { '<leader>sp', '<cmd>Telescope spell_suggest<cr>',  desc = 'Telescope spell_suggest' },
      {
        '<leader>o',
        '<cmd>Telescope frecency<cr>',
        desc =
        'Telescope frequentry used files in workspace'
      },
      {
        '<leader><leader>',
        '<cmd>Telescope frecency workspace=CWD<cr>',
        desc =
        'Telescope frequentry used files in workspace'
      },
      { '<leader>u',  '<cmd>Telescope undo<cr>',         desc = 'Telescope undo' },
      { '<leader>fb', '<cmd>Telescope file_browser<cr>', desc = 'Telescope file_browser' },
    },
    config = function()
      local trouble = require("trouble.providers.telescope")

      require('telescope').setup({
        defaults = {
          mappings = {
            i = { ["<c-t>"] = trouble.open_with_trouble },
            n = { ["<c-t>"] = trouble.open_with_trouble },
          },
        },
        extensions = {
          fzf = {
            fuzzy = true,                   -- false will only do exact matching
            override_generic_sorter = true, -- override the generic sorter
            override_file_sorter = true,    -- override the file sorter
            case_mode = "smart_case",       -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          },
          undo = {
            side_by_side = true,
            layout_strategy = "vertical",
            layout_config = {
              preview_height = 0.8,
            },
          },
          file_browser = {
            hijack_netrw = true,
          },
        }
      })
      require "telescope".load_extension("fzf")
      require "telescope".load_extension("frecency")
      require "telescope".load_extension("undo")
      require "telescope".load_extension("file_browser")
      require "telescope".load_extension("ghq")
      require "telescope".load_extension("notify")
      require "telescope".load_extension("noice")
      require "telescope".load_extension("luasnip")
      require "telescope".load_extension("emoji")
    end
  }
})
