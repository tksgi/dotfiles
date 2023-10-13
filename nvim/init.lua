-- フォントずれ確認用
-- 0123456789012345678901234567890123456789
-- ｱｲｳｴｵｱｲｳｴｵｱｲｳｴｵｱｲｳｴｵｱｲｳｴｵｱｲｳｴｵｱｲｳｴｵｱｲｳｴｵ
-- あいうえおあいうえおあいうえおあいうえお


vim.opt.fenc = 'utf-8'
vim.opt.undofile = true
vim.opt.termguicolors = true

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

vim.opt.list = true
vim.opt.listchars:append "space:⋅"
vim.opt.listchars:append "eol:↴"
vim.opt.listchars:append 'tab:▸-'

vim.api.nvim_exec('autocmd QuickFixCmdPost *grep* cwindow', false)

-- ESC連打でハイライト解除
vim.api.nvim_set_keymap("n", "<Esc><Esc>", '<CMD>nohlsearch<CR>', { silent = true })

--ターミナルで<c-w>でバッファ操作
vim.api.nvim_set_keymap("t", "<C-w><C-w>", '<C-\\><C-n>', { noremap = true, desc = '<C-w>連打でノーマルモード' })
vim.api.nvim_set_keymap("t", "<C-w>h", '<C-\\><C-n><C-w>h', { noremap = true, desc = '<C-w>hでバッファ移動' })
vim.api.nvim_set_keymap("t", "<C-w>j", '<C-\\><C-n><C-w>j', { noremap = true, desc = '<C-w>jでバッファ移動' })
vim.api.nvim_set_keymap("t", "<C-w>k", '<C-\\><C-n><C-w>k', { noremap = true, desc = '<C-w>kでバッファ移動' })
vim.api.nvim_set_keymap("t", "<C-w>l", '<C-\\><C-n><C-w>l', { noremap = true, desc = '<C-w>lでバッファ移動' })


-- vim.keymap.set("c", "P<TAB>", function() return vim.fn.expand('%:h') end, { desc = 'current dirのパスを展開' })
-- vim.keymap.set("c", "%<TAB>", function() return vim.fn.expand('%') end, { desc = 'current fileのパスを展開' })
vim.api.nvim_exec(
  [[
  cmap <expr> P<TAB> expand('%:h')
  cmap <expr> %<TAB> expand('%')
  ]], false
)


-- : Ter コマンドでBufferにterminalがあればそれを表示、なければ:terコマンド実行
function Ter()
  local buflist = vim.fn.getbufinfo({ buflisted = 1 })
  local termBufList = {}
  local msg = 'select listed terminal buffer or type N to open new terminal'
  local choices = ''
  for _, bufinfo in ipairs(buflist) do
    if string.find(bufinfo['name'], '^term://') then
      table.insert(termBufList, bufinfo)
      choices = choices ..
          '&' .. tostring(table.maxn(termBufList)) .. string.gsub(bufinfo['name'], 'term:.-:', '') .. '\n'
    end
  end
  choices = choices .. 'Type &N to open new terminal'
  if table.maxn(termBufList) == 0 then
    vim.api.nvim_cmd({ cmd = 'terminal' }, {})
  else
    local choice = vim.fn.confirm(msg, choices, 0, "General")
    if choice > table.maxn(termBufList) then
      vim.api.nvim_cmd({ cmd = 'terminal' }, {})
    elseif choice ~= 0 then
      vim.cmd({ cmd = 'buffer', args = { tostring(termBufList[choice]['bufnr']) } })
    end
  end
end

vim.api.nvim_create_user_command("Ter", function() Ter() end, {})


-- Terminal内でenter押したタイミングでbuffer名をupdate
vim.api.nvim_exec(
  [[
    function! s:set_title(prompt_pattern, max_length) abort
        let path = nvim_buf_get_name(0)
        let shell = split(fnamemodify(path, ':t'), ':')[0]
        let term_path = printf('%s/%s', fnamemodify(path, ':h'), shell)

        let prompt_line = getline(search(a:prompt_pattern, 'nbcW'))
        let prompt = matchstr(prompt_line, a:prompt_pattern)
        let cmd = prompt_line[strlen(prompt) : a:max_length]
        let cmd = substitute(cmd, '/', '\\', 'g') " fnamemodify(path, ':t') の邪魔なので置き換えちゃう

        call nvim_buf_set_name(0, printf('%s:%s', term_path, cmd))
        redrawtabline " nvim_buf_set_name()は`:file {name}`と異なり純粋にバッファ名を変えるだけなので必要に応じて
    endfunction

    tnoremap <CR> <Cmd>call <SID>set_title('^\$ ', 24)<CR><CR>
  ]], false
)

vim.api.nvim_del_keymap('n', 'Y')
vim.api.nvim_set_keymap("n", "<F1>", '<cmd>e ~/.config/nvim/init.lua<cr>', { noremap = true, desc = '<F1>でinit.luaを開く' })


-- Neovide用の設定
function NeovideConfig()
  if vim.g.neovide then
    vim.o.guifont = "Cica:h12"
    vim.g.neovide_cursor_animation_length = 0.0
    vim.g.neovide_scroll_animation_length = 0.1
    vim.g.neovide_hide_mouse_when_typing = true
    vim.g.neovide_refresh_rate = 120

    vim.keymap.set('n', '<D-s>', ':w<CR>')      -- Save
    vim.keymap.set('v', '<D-c>', '"+y')         -- Copy
    vim.keymap.set('n', '<D-v>', '"+P')         -- Paste normal mode
    vim.keymap.set('v', '<D-v>', '"+P')         -- Paste visual mode
    vim.keymap.set('c', '<D-v>', '<C-R>+')      -- Paste command mode
    vim.keymap.set('i', '<D-v>', '<ESC>l"+Pli') -- Paste insert mode
    -- Allow clipboard copy paste in neovim
    vim.api.nvim_set_keymap('', '<D-v>', '+p<CR>', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('!', '<D-v>', '<C-R>+', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('t', '<D-v>', '<C-R>+', { noremap = true, silent = true })
    vim.api.nvim_set_keymap('v', '<D-v>', '<C-R>+', { noremap = true, silent = true })

    vim.g.neovide_scale_factor = 1.0
    Change_scale_factor = function(delta)
      vim.g.neovide_scale_factor = vim.g.neovide_scale_factor * delta
    end
    vim.keymap.set("n", "<C-=>", function() Change_scale_factor(1.25) end)
    vim.keymap.set("n", "<C-->", function() Change_scale_factor(1/1.25) end)
  end
end

-- neovim server へ neovide から接続したときに設定を適用する
vim.api.nvim_create_autocmd({ "UIEnter" }, {
  pattern = "*",
  callback = NeovideConfig,
})





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
      vim.cmd.colorscheme('carbonfox')
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
    init = function()
      vim.api.nvim_create_user_command(
        'Fernr',
        function(opts)
          local path = #opts.args ~= 0 and opts.args or '.' -- 三項演算子
          vim.api.nvim_command('Fern ' .. path .. ' -reveal=%')
        end,
        { nargs = '?', complete = 'dir' }
      )
    end,
    config = function()
      vim.g['fern#renderer'] = 'nerdfont'
      vim.api.nvim_create_autocmd('FileType', {
        pattern = 'fern',
        callback = function()
          local opt = { buffer = true, silent = true }
          vim.keymap.set('n', 'p', '<Plug>(fern-action-preview:toggle)', opt)
          vim.keymap.set('n', '<C-p>', '<Plug>(fern-action-preview:auto:toggle)', opt)
          vim.keymap.set('n', '<C-d>', '<Plug>(fern-action-preview:scroll:down:half)', opt)
          vim.keymap.set('n', '<C-u>', '<Plug>(fern-action-preview:scroll:up:half)', opt)
          vim.keymap.set('n', 'D', '<Plug>(fern-action-remove)', opt)
        end
      })
    end
  },
  {
    'folke/noice.nvim',
    event = "VeryLazy",
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
        routes = {
          {
            filter = { event = 'msg_show', find = '%d+L, %d+B' },
            view = 'mini',
          },
          {
            filter = { event = 'msg_show', find = 'Hunk %d+ of %d+' },
            view = 'mini',
          },
          {
            filter = { event = 'msg_show', find = '%d+ more lines' },
            opts = { skip = true },
          },
          {
            filter = { event = 'msg_show', find = '%d+ lines yanked' },
            opts = { skip = true },
          },
          {
            filter = { event = 'msg_show', kind = 'quickfix' },
            view = 'mini',
          },
          {
            filter = { event = 'msg_show', kind = 'search_count' },
            view = 'mini',
          },
          {
            filter = { event = 'msg_show', kind = 'wmsg' },
            view = 'mini',
          },
        }
      })
      vim.keymap.set('n', '<C-n>', function()
        require'notify'.dismiss({})
        require'noice'.cmd('dismiss')
      end, {})
    end,
    dependencies = {
      "MunifTanjim/nui.nvim",
      'nvim-notify'
    },
  },
  {
    "rcarriga/nvim-notify",
    event = "VeryLazy",
    config = function()
      vim.notify = require("notify")

      vim.notify.setup({
        timeout = 10000,
        top_down = false,
      })

      vim.api.nvim_create_user_command('NotifyDismiss', function() require'notify'.dismiss({}) end, {})

      -- function Notify_output(command_string, opts)
      --   local command = {}
      --   local i = 1
      --   for s in string.gmatch(command_string, "([^ ]+)") do
      --     command[i] = s
      --     i = i + 1
      --   end
      --   local output = ""
      --   local notification
      --   local notify = function(msg, level)
      --     local notify_opts = vim.tbl_extend(
      --       "keep",
      --       opts or {},
      --       { title = table.concat(command, " "), replace = notification }
      --     )
      --     notification = vim.notify(msg, level, notify_opts)
      --   end
      --   local on_data = function(_, data)
      --     output = output .. table.concat(data, "\n")
      --     notify(output, "info")
      --   end
      --   vim.fn.jobstart(command, {
      --     on_stdout = on_data,
      --     on_stderr = on_data,
      --     on_exit = function(_, code)
      --       if #output == 0 then
      --         notify("No output of command, exit code: " .. code, "warn")
      --       end
      --     end,
      --   })
      -- end
    end
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
    config = function ()
      -- デフォルトマッピングを無効化してzから初まるマッピングに変更
      vim.g.sandwich_no_default_key_mappings = 1
      -- add
      vim.keymap.set('n', 'za', '<Plug>(sandwich-add)')
      vim.keymap.set('x', 'za', '<Plug>(sandwich-add)')
      vim.keymap.set('o', 'za', '<Plug>(sandwich-add)')
      -- delete
      vim.keymap.set('n', 'zd', '<Plug>(sandwich-delete)')
      vim.keymap.set('x', 'zd', '<Plug>(sandwich-delete)')
      vim.keymap.set('o', 'zdb', '<Plug>(sandwich-delete-auto)')
      -- replace
      vim.keymap.set('n', 'zr', '<Plug>(sandwich-replace)')
      vim.keymap.set('x', 'zr', '<Plug>(sandwich-replace)')
      vim.keymap.set('o', 'zrb', '<Plug>(sandwich-replace-auto)')
    end
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
    config = function()
      require('orgmode').setup_ts_grammar()
      require 'nvim-treesitter.configs'.setup {
        highlight = {
          enable = true, -- false will disable the whole extension
          disable = { "ruby" },
          additional_vim_regex_highlighting = { 'org' },
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
      vim.treesitter.language.register('typescript', 'typescriptreact')
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
    config = function()
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
    config = function()
      -- local init_pre = vim.api.nvim_create_augroup('skkeleton-initialize-pre', { clear = false })
      -- vim.api.nvim_create_autocmd('User', {
      --   group = init_pre,
      --   callback = function()
      --     local dic_path = vim.fn.stdpath("data") .. '/skk_dictionary/'
      --     vim.fn['skkeleton#config']({
      --       globalDictionaries = { dic_path .. 'SKK-JISYO.L', dic_path .. 'SKK-JISYO.jinmei', dic_path .. 'SKK-JISYO.geo', dic_path .. 'SKK-JISYO.emoji'}
      --     })
      --   end
      -- })
      vim.keymap.set('i', '<C-j>', '<Plug>(skkeleton-enable)', {})
      vim.keymap.set('c', '<C-j>', '<Plug>(skkeleton-enable)', {})
      vim.api.nvim_exec(
        [[
             function! s:skkeleton_init() abort
               let dic_path = stdpath("data") . "/skk_dictionary/"
               call skkeleton#config({
               \ 'globalDictionaries': [dic_path . "SKK-JISYO.L", dic_path . "SKK-JISYO.jinmei", dic_path . "SKK-JISYO.geo", dic_path . "SKK-JISYO.emoji"],
               \ })
             endfunction

             augroup skkeleton-initialize-pre
             autocmd!
             autocmd User skkeleton-initialize-pre call s:skkeleton_init()
             augroup END
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
    config = function()
      require 'ddc-config'
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
    config = function()
      vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
      local cmp_autopairs = require('nvim-autopairs.completion.cmp')
      local cmp = require 'cmp'
      local luasnip = require 'luasnip'

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
          -- ['<C-f>'] = cmp.mapping.complete({ config = {sources = {name = 'path'}} }),
          -- ['<C-s>'] = cmp.mapping.complete({ config = {sources = {name = 'luasnip'}} }),
          ['<Tab>'] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback(fallback)
            end
          end, { "i", "s" }),
          ['<S-Tab>'] = cmp.mapping(function(fallback)
            if luasnip.jumpable(-1) then
              luasnip.jump(-1)
            else
              fallback(fallback)
            end
          end, { "i", "s" }),
        }),
        sources = cmp.config.sources({
          {
            name = 'skkeleton',
            view = { entries = 'native' },
          },
          { name = 'luasnip' },
          { name = 'nvim_lsp' },
          { name = 'nvim_lsp_document_symbol' },
          -- { name = 'cmp_tabnine' },
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
          -- { name = 'cmp_tabnine' },
          buffer_source,
        })
      })
      cmp.setup.filetype('org', {
        { name = 'orgmode' },
        {
          name = 'skkeleton',
          view = { entries = 'native' },
        },
        { name = 'luasnip' },
        -- { name = 'cmp_tabnine' },
        buffer_source,
        { name = 'path' },
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
          { name = 'cmdline' },
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
        })
      })

      -- vim.keymap.set('i', '<c-t>', '<cmd>lua require"cmp".complete({ config = { sources = {{name = "cmp_tabnine"}} } })<cr>')
      vim.keymap.set('i', '<c-s>', '<cmd>lua require"cmp".complete({ config = { sources = {{name = "luasnip"}} } })<cr>')
      vim.keymap.set('i', '<c-f>', '<cmd>lua require"cmp".complete({ config = { sources = {{name = "path"}} } })<cr>')
    end
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
      {
        'folke/trouble.nvim',
        dependencies = {
          'nvim-web-devicons'
        },
        config = true,
      },
      { "princejoogie/dir-telescope.nvim", confog = true, }
    },
    cmd = { "Telescope" },
    keys = {
      { '\\T',   '<cmd>Telescope<cr>',                desc = 'Telescope show default pickers' },
      { '\\ff',  '<cmd>Telescope find_files<cr>',     desc = 'Telescope find_files' },
      { '\\lg',  '<cmd>Telescope live_grep<cr>',      desc = 'Telescope live_grep' },
      { '\\ls',  '<cmd>Telescope buffers<cr>',        desc = 'Telescope buffers' },
      { '\\o',   '<cmd>Telescope oldfiles<cr>',       desc = 'Telescope oldfiles' },
      { '\\ht',  '<cmd>Telescope help_tags<cr>',      desc = 'Telescope help_tags' },
      { '\\lr',  '<cmd>Telescope lsp_references<cr>', desc = 'Telescope lsp_references' },
      { '\\gc',  '<cmd>Telescope git_commits<cr>',    desc = 'Telescope git_commits' },
      { '\\gb',  '<cmd>Telescope git_branches<cr>',   desc = 'Telescope git_branches' },
      { '\\gs',  '<cmd>Telescope git_status<cr>',     desc = 'Telescope git_status' },
      { '\\sp',  '<cmd>Telescope spell_suggest<cr>',  desc = 'Telescope spell_suggest' },
      { '\\dlg', '<cmd>Telescope live_grep<cr>',      desc = 'Telescope live_grep' },
      { '\\u',   '<cmd>Telescope undo<cr>',           desc = 'Telescope undo' },
      { '\\fb',  '<cmd>Telescope file_browser<cr>',   desc = 'Telescope file_browser' },
    },
    config = function()
      require 'telescope-config'
    end
  },
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
    config = function()
      require 'ddu-config'
    end
  },
}, {
  custom_keys = {
    ["<localleader>t"] = function(plugin)
      require("lazy.util").float_term(nil, {
        cwd = plugin.dir,
      })
    end,
  }
})
