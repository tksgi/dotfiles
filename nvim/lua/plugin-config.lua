

vim.g.completion_plugin = 'cmp' -- set cmp or ddc


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

vim.g.mapleader = ' '
vim.g.maplocalleader = '\\'

require("lazy").setup({
  {
    'EdenEast/nightfox.nvim',
    lazy = false,
    priority = 1000,
    config = function()
      vim.g.default_colorscheme = 'carbonfox'
      vim.g.inactive_colorscheme = 'nordfox'

      -- カラースキームの適用
      vim.cmd.colorscheme(vim.g.default_colorscheme)
    end
  },
  {
    'folke/styler.nvim',
    lazy = false,
    config = function()
      -- 非アクティブウィンドウ向けの関数
      local function inactivate(win)
        -- skip for certain situations
        if not vim.api.nvim_win_is_valid(win) then return end
        if vim.api.nvim_win_get_config(win).relative ~= "" then return end

        -- apply colorscheme if not yet
        if (vim.w[win].theme or {}).colorscheme ~= vim.g.inactive_colorscheme then
          require('styler').set_theme(win, { colorscheme = vim.g.inactive_colorscheme })
        end
      end

      -- autocmdの発行
      vim.api.nvim_create_autocmd(
        { 'WinLeave', 'WinNew' },
        {
          group = vim.api.nvim_create_augroup('styler-nvim-custom', {}),
          callback = function(_)
            local win_event = vim.api.nvim_get_current_win()
            vim.schedule(function()
              local win_pre = vim.fn.win_getid(vim.fn.winnr('#'))
              local win_cursor = vim.api.nvim_get_current_win()

              -- カーソル位置のウィンドウでstyler.nvimを無効化する
              if (vim.w[win_cursor].theme or {}).colorscheme then
                require('styler').clear(win_cursor)
              end

              -- 直前のウィンドウにカーソルがなければinactivate
              if win_pre ~= 0 and win_pre ~= win_cursor then
                inactivate(win_pre)
              end

              -- イベントを発行したウィンドウにカーソルがなければinactivate
              if win_event ~= win_cursor then
                inactivate(win_event)
              end
            end)
          end
        }
      )
    end
  },
  'vim-jp/vimdoc-ja',
  {
    'lukas-reineke/indent-blankline.nvim',
    main = 'ibl',
    config = true,
    opts = {
      exclude = {
        filetypes = {
          'lspinfo',
          'checkhealth',
          'help',
          'man',
          'gitcommit',
          'TelescopePrompt',
          'TelescopeResults',
          'dashboard',
        }
      }
    }
  },
  {
    'mbbill/undotree',
    keys = {
      { "<F5>", "<cmd>UndotreeToggle<cr>", desc = 'undotree toggle' }
    }
  },
  {
    'chentoast/marks.nvim',
    config = true,
  },
  { 'godlygeek/tabular', cmd = { 'Tabularize' } },
  { 'simeji/winresizer', keys = { '<c-e>' } },
  {
    'Bakudankun/BackAndForward.vim',
    keys = {
      { 'gb',         '<cmd>Back<cr>',    noremap = true,         desc = 'Back buffer' },
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
      -- local wk = require("which-key")
    end
  },

  { 'vim-denops/denops.vim', lazy = false },
  {
    'tyru/open-browser.vim',
    lazy = false,
    config = function()
      vim.g.netrw_nogx = 1
      vim.keymap.set('n', 'gx', '<Plug>(openbrowser-open)', {})
      vim.keymap.set('v', 'gx', '<Plug>(openbrowser-open)', {})
    end
  },
  {
    'lambdalisue/guise.vim',
    dependencies = { 'vim-denops/denops.vim' },
  },
  {
    'lambdalisue/gin.vim',
    dependencies = { 'vim-denops/denops.vim' },
  },
  {
    'NeogitOrg/neogit',
    dependencies = {
      'plenary.nvim',
      'telescope.nvim',
      'sindrets/diffview.nvim',
    },
    config = true,
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
      { 'lambdalisue/fern-bookmark.vim' },
      { 'lambdalisue/fern-mapping-quickfix.vim' },
      { 'yuki-yano/fern-preview.vim' },
    },
    init = require'plugins.fern'.init,
    config = require'plugins.fern'.config,
  },
  {
    'folke/noice.nvim',
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      'nvim-notify'
    },
    config = require'plugins.noice'.config,
  },
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = require'plugins.notify'.config,
  },
  {
    'folke/trouble.nvim',
    dependencies = {
      'nvim-web-devicons'
    },
    config = true,
  },
  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      'nvim-web-devicons',
      'noice.nvim',
    },
    config = function()
      require("lualine").setup({
        tabline = {
          lualine_a = {
            { 'tabs', mode = 2, },
          },
          lualine_z = {
            { function() return vim.api.nvim_exec('pwd', true) end },
          }
        },
        winbar = {
          lualine_c = {
            { 'filename', path = 1, },
          }
        },
        inactive_winbar = {
          lualine_c = {
            { 'filename', path = 1, },
          }
        },
        extensions = { 'quickfix', 'fern', 'aerial', 'lazy' },
      })
    end,
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
    'kwkarlwang/bufresize.nvim',
    config = function()
      vim.api.nvim_create_user_command("ResizeWin", require('bufresize').resize, {})
    end
  },
  {
    'glepnir/dashboard-nvim',
    enabled = false,
    event = 'VimEnter',
    config = function()
      require('dashboard').setup {
        -- config
      }
    end,
    dependencies = { { 'nvim-tree/nvim-web-devicons' } }
  },
  {
    'machakann/vim-sandwich',
    lazy = false,
    config = require'plugins.sandwich'.config,
  },
  {
    'NvChad/nvim-colorizer.lua',
    config = true,
    cmd = {
      'ColorizerAttachToBuffer',
      'ColorizerDetachFromBuffer',
      'ColorizerReloadAllBuffers',
      'ColorizerToggle',
    }
  },

  -- filetype plugin
  { 'kevinhwang91/nvim-bqf', ft = 'qf' },
  {
    'ixru/nvim-markdown',
    ft = { 'markdown' },
    config = function()
      vim.g.vim_markdown_no_default_key_mappings = 1
    end
  },
  { 'previm/previm',         ft = { 'markdown' } },
  { 'keith/rspec.vim',       ft = { 'ruby' } },
  {
    'nvim-orgmode/orgmode',
    dependencies = { 'nvim-treesitter', { 'akinsho/org-bullets.nvim', config = true } },
    config = function()
      require('orgmode').setup({
        org_agenda_files = '~/orgfiles/**/*',
        org_default_notes_file = '~/orgfiles/refille.org',
      })
    end,
    run = function()
      local dir_path = '~/orgfiles'
      if vim.fn.empty(vim.fn.glob(dir_path)) > 0 then
        vim.fn.system({ 'mkdir', '-p', dir_path })
        vim.fn.system({ 'mkdir', '-p', dir_path })
      end
    end
  },

  -- treesitter
  {
    'nvim-treesitter/nvim-treesitter',
    dependencies = {
      'nvim-treesitter/nvim-treesitter-context',
      { 'haringsrob/nvim_context_vt', enabled = false },
      'RRethy/vim-illuminate',
      'RRethy/nvim-treesitter-endwise',
      -- "nvim-treesitter/nvim-treesitter-textobjects",
      'orgmode'
    },
    build = ":TSUpdate",
    config = require'plugins.treesitter'.config,
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
  -- Linter
  {
    'mfussenegger/nvim-lint',
    config = function()
      require('lint').linters_by_ft = {
        ruby = { 'rubocop', }
      }
      vim.api.nvim_create_autocmd({ "BufWritePost" }, {
        callback = function()
          require("lint").try_lint()
        end,
      })
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
      -- {
      --   'jose-elias-alvarez/null-ls.nvim',
      --   config = function()
      --     local null_ls = require 'null-ls'
      --
      --     null_ls.setup({
      --       sources = {
      --         null_ls.builtins.diagnostics.rubocop.with({
      --           method = null_ls.methods.DIAGNOSTICS_ON_SAVE,
      --         }),
      --         null_ls.builtins.formatting.prettier,
      --       }
      --     })
      --   end,
      --   dependencies = { 'plenary.nvim' },
      -- },
      { "SmiteshP/nvim-navic", enabled = true },
    },
    config = require'plugins.lspconfig'.config,
  },
  -- dap
  {
    'mfussenegger/nvim-dap',
    dependencies = {
      'mason.nvim',
      'jay-babu/mason-nvim-dap.nvim',
    },
    config = function()
      local dap = require 'dap'
      dap.configurations.typescriptreact = {
        {
          type = "chrome",
          request = "attach",
          program = "${file}",
          cwd = vim.fn.getcwd(),
          sourceMaps = true,
          protocol = "inspector",
          port = 9222,
          webRoot = "${workspaceFolder}"
        }
      }
    end
  },
  -- nvim-cmp
  {
    'vim-skk/skkeleton',
    lazy = false,
    dependencies = { 'vim-denops/denops.vim' },
    config = require'plugins.skkeleton'.config,
    build = require'plugins.skkeleton'.build,
  },
  {
    'Shougo/ddc.vim',
    enabled = vim.g.completion_plugin == 'ddc',
    dependencies = {
      { 'denops.vim' },
      { 'Shougo/pum.vim' },
      { 'Shougo/ddc-ui-pum' },
      { 'Shougo/neco-vim' },
      { 'Shougo/ddc-source-nvim-lsp' },
      { 'Shougo/ddc-zsh' },
      { 'Shougo/ddc-cmdline-history' },
      { 'Shougo/ddc-source-around' },
      { 'Shougo/ddc-source-line' },
      { 'Shougo/ddc-source-cmdline' },
      { 'Shougo/ddc-filter-sorter_rank' },
      { 'Shougo/ddc-filter-matcher_head' },
      { 'tani/ddc-git' },
      { 'tani/ddc-oldfiles' },
      { 'tani/ddc-fuzzy' },
      { 'tani/ddc-path' },
      { 'ippachi/ddc-yank' },
      { 'matsui54/ddc-buffer' },
      { 'matsui54/denops-popup-preview.vim' },
      { 'matsui54/denops-signature_help' },
      { 'LumaKernel/ddc-tabnine' },
      { 'LumaKernel/ddc-source-file' },
      --{'delphinus/ddc-treesitter'},
      { 'octaltree/cmp-look' }, -- complete english word
    },
    config = require 'plugins.ddc'.config,
  },
  {
    'tzachar/cmp-tabnine',
    build = './install.sh',
    lazy = true,
    enabled = false,
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
    enabled = vim.g.completion_plugin == 'cmp',
    event = { "InsertEnter", "CmdlineEnter", },
    dependencies = {
      { 'hrsh7th/cmp-nvim-lsp' },
      { "hrsh7th/cmp-buffer" },
      { 'hrsh7th/cmp-path' },
      { 'hrsh7th/cmp-cmdline' },
      { 'hrsh7th/cmp-nvim-lua' },
      { 'hrsh7th/cmp-nvim-lsp-document-symbol' },
      { 'petertriho/cmp-git' },
      { 'tzachar/cmp-tabnine',                 enabled = false },
      { 'rinx/cmp-skkeleton',                  dependencies = { 'skkeleton' } },
      { "windwp/nvim-autopairs",               config = true, },
      { 'saadparwaiz1/cmp_luasnip',            dependencies = { 'LuaSnip' } },
      { 'orgmode' },
    },
    config = require'plugins.cmp'.config,
  },

  -- snippet
  {
    'L3MON4D3/LuaSnip',
    version = "1.2.*",
    -- build = 'make install_jsregexp',
    dependencies = {
      { 'rafamadriz/friendly-snippets' }
    },
    config = function()
      require("luasnip.loaders.from_vscode").lazy_load()
      require 'luasnip'.filetype_extend("ruby", { "rails" })
    end
  },

  -- Telescope
  {
    'nvim-telescope/telescope.nvim',
    tag = '0.1.4',
    cmd = { "Telescope" },
    dependencies = {
      { 'nvim-lua/plenary.nvim' },
      { 'nvim-telescope/telescope-packer.nvim' },
      { 'nvim-telescope/telescope-symbols.nvim' },
      { 'nvim-telescope/telescope-fzf-native.nvim',  build = 'make' },
      -- { 'nvim-telescope/telescope-command-palette.nvim' },
      { 'debugloop/telescope-undo.nvim' },
      { "nvim-telescope/telescope-file-browser.nvim" },
      { "nvim-telescope/telescope-ghq.nvim" },
      { "benfowler/telescope-luasnip.nvim" },
      { "xiyaowong/telescope-emoji.nvim" },
      { 'folke/trouble.nvim' },
      { "princejoogie/dir-telescope.nvim", confog = true, }
    },
    keys = require'plugins.telescope'.keys,
    config = require 'plugins.telescope'.config,
  },
  -- ddu.vim
  {
    'Shougo/ddu.vim',
    dependencies = {
      { 'denops.vim' },
      { 'Shougo/ddu-commands.vim' },

      -- UI
      { 'Shougo/ddu-ui-ff' },
      -- { 'Shougo/ddu-ui-filer' },

      -- Source
      { 'Shougo/ddu-source-action' },
      { 'Shougo/ddu-source-file' },
      { 'Shougo/ddu-source-file_rec' },
      { 'Shougo/ddu-source-file_old' },
      { 'Shougo/ddu-source-register' },
      { 'shun/ddu-source-buffer' },
      { 'shun/ddu-source-rg' },
      { 'uga-rosa/ddu-source-lsp' },
      { 'matsui54/ddu-vim-ui-select' },
      { 'matsui54/ddu-source-help' },
      { '4513ECHO/ddu-source-ghq' },
      { 'mikanIchinose/ddu-source-markdown' },
      { 'kamecha/ddu-source-jumplist' },

      -- Kind
      { 'Shougo/ddu-kind-file' },

      -- Filter
      { 'Milly/ddu-filter-kensaku' },
      { 'yuki-yano/ddu-filter-fzf' },
    },
    config = require('plugins.ddu').config,
  }
}, {
  custom_keys = {
    ["<localleader>t"] = function(plugin)
      require("lazy.util").float_term(nil, {
        cwd = plugin.dir,
      })
    end,
  }
})
