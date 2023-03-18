vim.cmd [[packadd packer.nvim]]
return require('packer').startup(function(use)
  vim.api.nvim_exec(
    [[
    noremap <Space> <Nop>
    let g:mapleader = "\<Space>"
    let g:maplocalleader = "\\"
    ]], false
  )

  use 'wbthomason/packer.nvim'

  use 'vim-jp/vimdoc-ja'
  use 'Yggdroot/indentLine'
  use 'mbbill/undotree'
  use { 'godlygeek/tabular', cmd = { 'Tabularize' } }
  use { 'simeji/winresizer', keys = { '<c-e>' } }
  use { 'EdenEast/nightfox.nvim', config = function() vim.cmd('colorscheme nordfox') end }
  use {'kevinhwang91/nvim-bqf', ft = 'qf'}
  use {
    'Bakudankun/BackAndForward.vim',
    cmd = { 'Back', 'Forward' },
    setup = function()
      vim.keymap.set("n", "<c-h>", function() vim.cmd('Back') end)
      vim.keymap.set("n", "<c-l>", function() vim.cmd('Forward') end)
    end
  }

  use {
    'tamago324/lir.nvim',
    requires = {
      { 'kyazdani42/nvim-web-devicons' },
      { 'nvim-lua/plenary.nvim' }
    },
    wants = {
      { 'nvim-web-devicons' }
    },
    config = function()
      local actions = require'lir.actions'
      local mark_actions = require 'lir.mark.actions'
      local clipboard_actions = require'lir.clipboard.actions'

      require'lir'.setup {
        show_hidden_files = false,
        ignore = {}, -- { ".DS_Store", "node_modules" } etc.
        devicons = {
          enable = false,
          highlight_dirname = false
        },
        mappings = {
          ['l']     = actions.edit,
          ['<C-s>'] = actions.split,
          ['<C-v>'] = actions.vsplit,
          ['<C-t>'] = actions.tabedit,

          ['h']     = actions.up,
          ['q']     = actions.quit,

          ['K']     = actions.mkdir,
          ['N']     = actions.newfile,
          ['R']     = actions.rename,
          ['@']     = actions.cd,
          ['Y']     = actions.yank_path,
          ['.']     = actions.toggle_show_hidden,
          ['D']     = actions.delete,

          ['J'] = function()
            mark_actions.toggle_mark()
            vim.cmd('normal! j')
          end,
          ['C'] = clipboard_actions.copy,
          ['X'] = clipboard_actions.cut,
          ['P'] = clipboard_actions.paste,
        },
        float = {
          winblend = 0,
          curdir_window = {
            enable = false,
            highlight_dirname = false
          },

          -- -- You can define a function that returns a table to be passed as the third
          -- -- argument of nvim_open_win().
          -- win_opts = function()
          --   local width = math.floor(vim.o.columns * 0.8)
          --   local height = math.floor(vim.o.lines * 0.8)
          --   return {
          --     border = {
          --       "+", "─", "+", "│", "+", "─", "+", "│",
          --     },
          --     width = width,
          --     height = height,
          --     row = 1,
          --     col = math.floor((vim.o.columns - width) / 2),
          --   }
          -- end,
        },
        hide_cursor = true
      }

      vim.api.nvim_create_autocmd({'FileType'}, {
        pattern = {"lir"},
        callback = function()
          -- use visual mode
          vim.api.nvim_buf_set_keymap(
            0,
            "x",
            "J",
            ':<C-u>lua require"lir.mark.actions".toggle_mark("v")<CR>',
            { noremap = true, silent = true }
          )

          -- echo cwd
          vim.api.nvim_echo({ { vim.fn.expand("%:p"), "Normal" } }, false, {})
        end
      })

      -- custom folder icon
      require'nvim-web-devicons'.set_icon({
        lir_folder_icon = {
          icon = "",
          color = "#7ebae4",
          name = "LirFolderNode"
        }
      })
    end
  }

--  use {
--    'lambdalisue/fern.vim',
--    requires = {
--      { 'ryanoasis/vim-devicons' },
--      { 'kyazdani42/nvim-web-devicons' },
--      { 'lambdalisue/fern-git-status.vim' },
--      { 'lambdalisue/fern-mapping-git.vim' },
--      { 'lambdalisue/fern-hijack.vim' },
--      { 'lambdalisue/fern-bookmark.vim' },
--      { 'lambdalisue/fern-mapping-quickfix.vim' },
--      { 'yuki-yano/fern-preview.vim' },
--    },
--    wants = {
--      'fern-git-status.vim',
--      'fern-mapping-git.vim',
--      'fern-hijack.vim',
--      'fern-bookmark.vim',
--      'fern-mapping-quickfix.vim',
--      'fern-preview.vim',
--    },
--    setup = function()
--      vim.api.nvim_create_user_command('Fernr', 'Fern . -reveal=%', {})
--      vim.api.nvim_create_user_command('Fernd', 'Fern %:h', {})
--      vim.api.nvim_create_user_command('Ferndr', 'Fern . -reveal=%', {})
--    end,
--    config = function()
--      vim.api.nvim_exec(
--      [[
--      function! s:fern_settings() abort
--        nmap <silent> <buffer> p     <Plug>(fern-action-preview:toggle)
--        nmap <silent> <buffer> <C-p> <Plug>(fern-action-preview:auto:toggle)
--        nmap <silent> <buffer> <C-d> <Plug>(fern-action-preview:scroll:down:half)
--        nmap <silent> <buffer> <C-u> <Plug>(fern-action-preview:scroll:up:half)
--      endfunction
--
--      augroup fern-settings
--        autocmd!
--        autocmd FileType fern call s:fern_settings()
--      augroup END
--      ]],
--      false)
--    end
--  }

  use {
    'lambdalisue/guise.vim',
    requires = { 'vim-denops/denops.vim' }
  }
  use {
    'numToStr/Comment.nvim',
    config = function()
      require('Comment').setup()
    end
  }
  use { 'plasticboy/vim-markdown', ft = { 'markdown' } }
  use { 'previm/previm', ft = { 'markdown' } }

  use {
    'nvim-treesitter/nvim-treesitter',
    require = {
      'nvim-treesitter/nvim-treesitter-context',
      'haringsrob/nvim_context_vt',
      'RRethy/vim-illuminate'
    },
    run = function()
      local ts_update = require('nvim-treesitter.install').update({ with_sync = true })
      ts_update()
    end,
    config = function()
      require'nvim-treesitter.configs'.setup {
        highlight = {
          enable = true,              -- false will disable the whole extension
          disable = { "ruby", "python" }
        },
        incremental_selection = {
          enable = true,
          keymaps = {
            init_selection = "gnn",
            node_incremental = "grn",
            scope_incremental = "grc",
            node_decremental = "grm",
          },
          disable = { "ruby", "python" }
        },
        indent = {
          enable = true ,
          disable = { "ruby", "python" }
        },
        textobjects = {
          enable = true,
          disable = { "ruby", "python" }
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
  }

  -- builtin LSP
  use {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'neovim/nvim-lspconfig',
    { 'hrsh7th/cmp-nvim-lsp' },
    config = function()
      require('mason').setup({})
      require('mason-lspconfig').setup({})
      local capabilities = require('cmp_nvim_lsp').default_capabilities()
      local custom_attach = function(client, bufnr)
        local bufopts = { noremap=true, silent=true, buffer=bufnr }
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
        vim.api.nvim_buf_create_user_command(bufnr, "LspFormat", vim.lsp.buf.formatting, {})
        vim.api.nvim_buf_create_user_command(bufnr, "LspShowLineDiagnostivs", vim.diagnostic.open_float, {})
        vim.api.nvim_buf_create_user_command(bufnr, "LspAddWorkspaceFolder", function() vim.lsp.buf.add_workspace_folder() end, {})
        vim.api.nvim_buf_create_user_command(bufnr, "LspRemoveWorkspaceFolder", vim.lsp.buf.remove_workspace_folder, {})
        vim.api.nvim_buf_create_user_command(bufnr, "LspListWorkspaceFolder", function() print(vim.inspect(vim.lsp.buf.list_workspace_folders())) end, {})
      end

      require'lspconfig'.solargraph.setup{
        on_attach = custom_attach,
        capabilities = capabilities
      }
      require'lspconfig'.vimls.setup{
        on_attach = custom_attach,
        capabilities = capabilities
      }
      require'lspconfig'.tsserver.setup{
        on_attach = custom_attach,
        capabilities = capabilities
      }
      require'lspconfig'.gopls.setup{
        on_attach = custom_attach,
        capabilities = capabilities
      }
      require'lspconfig'.yamlls.setup{
        on_attach = custom_attach,
        capabilities = capabilities
      }
      require'lspconfig'.dockerls.setup{
        on_attach = custom_attach,
        capabilities = capabilities
      }
    end
  }

  -- nvim-cmp
  use {
    "hrsh7th/nvim-cmp",
    module = { "cmp" },
    requires = {
      { "hrsh7th/cmp-buffer", event = { "InsertEnter" } },
      { "hrsh7th/cmp-emoji", event = { "InsertEnter" } },
      { 'hrsh7th/cmp-path', event = { "InsertEnter", "cmdlineEnter" } },
      { 'hrsh7th/cmp-cmdline', event = { "InsertEnter", "cmdlineEnter" } },
      { 'hrsh7th/cmp-nvim-lua', event = { "InsertEnter" } },
      { 'hrsh7th/cmp-nvim-lsp-document-symbol', event = { "InsertEnter" } },
      { 'petertriho/cmp-git', event = { "InsertEnter" } },
      { 'tzachar/cmp-tabnine', event = { "InsertEnter" }, run = './install.sh' },
      { 'ray-x/cmp-treesitter', event = { "InsertEnter" } },
      { 'hrsh7th/cmp-nvim-lsp' },
      {
        'rinx/cmp-skkeleton',
        event = { "InsertEnter" },
        requires = { {
          'vim-skk/skkeleton',
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
          run = function()
            local dic_path = vim.fn.stdpath('data')..'/skk_dictionary'
            if vim.fn.empty(vim.fn.glob(dic_path)) > 0 then
              vim.fn.system({'git', 'clone', 'https://github.com/skk-dev/dict.git', dic_path})
            end
          end
        },} 
      },
    },
    config = function()
      vim.opt.completeopt = {'menu','menuone','noselect'}
      local cmp = require'cmp'

      cmp.setup {
        mapping = cmp.mapping.preset.insert({
          ['<C-b>'] = cmp.mapping.scroll_docs(-4),
          ['<C-f>'] = cmp.mapping.scroll_docs(4),
          ['<C-Space>'] = cmp.mapping.complete(),
          ['<C-e>'] = cmp.mapping.abort(),
          ['<CR>'] = cmp.mapping.confirm({ select = true }),
        }),
        sources = cmp.config.sources({
          { name = 'nvim_lsp' },
          { name = 'nvim_lsp_document_symbol' },
          { name = 'tabnine' },
          { name = 'skkeleton' },
          { name = 'treesitter' },
          { name = 'buffer' },
          { name = 'path' },
        },{
          { name = 'buffer' }
        }),
      }
      cmp.setup.filetype('gitcommit', {
        sources = cmp.config.sources({
          { name = 'cmp_git' },
        }, {
          { name = 'buffer' },
        })
      })

      cmp.setup.filetype('lua', {
        sources = cmp.config.sources({
          { name = 'nvim_lua' },
        }, {
          { name = 'buffer' },
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
          { name = 'path' },
          {
            name = 'cmdline_history',
            option = { history_type = ':' }
          }
        }, {
          { name = 'cmdline' }
        })
      })
    end
  }

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.1',
    -- module = { 'telescope' },
    requires = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-frecency.nvim', requires = {"kkharji/sqlite.lua"}, wants = {'nvim-web-devicons'} },
      { 'nvim-telescope/telescope-packer.nvim' },
      { 'nvim-telescope/telescope-symbols.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim', run = 'cmake -S. -Bbuild -DCMAKE_BUILD_TYPE=Release && cmake --build build --config Release && cmake --install build --prefix build' },
      -- { 'nvim-telescope/telescope-command-palette.nvim' },
      { 'debugloop/telescope-undo.nvim' },
    },
    wants = {
      'telescope-frecency',
      'telescope-packer',
      'telescope-symbols',
      'telescope-fzf-writer',
      -- 'telescope-command-palette',
    },
    setup = function()
      vim.keymap.set('n', '<leader>T',   '<cmd>Telescope<cr>', keyopts)
      vim.keymap.set('n', '<leader>tf ', '<cmd>Telescope find_files<cr>', keyopts)
      vim.keymap.set('n', '<leader>tlg', '<cmd>Telescope live_grep<cr>', keyopts)
      vim.keymap.set('n', '<leader>tb ', '<cmd>Telescope buffers<cr>', keyopts)
      vim.keymap.set('n', '<leader>to ', '<cmd>Telescope oldfiles<cr>', keyopts)
      vim.keymap.set('n', '<leader>th ', '<cmd>Telescope help_tags<cr>', keyopts)
      vim.keymap.set('n', '<leader>tr ', '<cmd>Telescope lsp_references<cr>', keyopts)
      vim.keymap.set('n', '<leader>tc ', '<cmd>Telescope lsp_code_actions<cr>', keyopts)
      vim.keymap.set('n', '<leader>tgc', '<cmd>Telescope git_commits<cr>', keyopts)
      vim.keymap.set('n', '<leader>tgb', '<cmd>Telescope git_branches<cr>', keyopts)
      vim.keymap.set('n', '<leader>tgs', '<cmd>Telescope git_status<cr>', keyopts)
      vim.keymap.set('n', '<leader>tsp', '<cmd>Telescope spell_suggest<cr>', keyopts)
      vim.keymap.set('n', '<leader><leader>', '<cmd>Telescope frecency workspace=CWD<cr>', keyopts)
      vim.keymap.set('n', '<leader><leader>', '<cmd>Telescope undo undo', keyopts)
    end,
    config = function()
      require('telescope').setup({
        extensions = {
          fzf = {
            fuzzy = true,                    -- false will only do exact matching
            override_generic_sorter = true,  -- override the generic sorter
            override_file_sorter = true,     -- override the file sorter
            case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
            -- the default case_mode is "smart_case"
          },
          undo = {
            side_by_side = true,
            layout_strategy = "vertical",
            layout_config = {
              preview_height = 0.8,
            },
          },
        }
      })
      require"telescope".load_extension("fzf")
      require"telescope".load_extension("frecency")
      require("telescope").load_extension("undo")
    end
  }

  use {
    'folke/todo-comments.nvim',
    wants = 'plenary.nvim',
    config = function()
      require("todo-comments").setup {}
    end
  }

  use({
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
  })

  use {
    'andymass/vim-matchup',
    wants = 'treesitter',
    setup = function()
      vim.g.matchup_matchparen_offscreen = { method = "popup" }
    end
  }
end)
