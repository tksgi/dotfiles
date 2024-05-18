local config = function()
  vim.opt.completeopt = { 'menu', 'menuone', 'noselect' }
  -- local cmp_autopairs = require('nvim-autopairs.completion.cmp')
  local cmp = require 'cmp'
  local luasnip = require 'luasnip'

  -- cmp.event:on(
  --   'confirm_done',
  --   cmp_autopairs.on_confirm_done()
  -- )
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
      ['<C-y>'] = cmp.mapping.confirm({ select = false }), -- <cr>で確定。未選択時は何もしない
      ['<CR>'] = cmp.mapping.confirm({ select = false }),  -- <cr>で確定。未選択時は何もしない
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
  -- cmp.setup.cmdline('/', {
  --   mapping = cmp.mapping.preset.cmdline(),
  --   sources = {
  --     { name = 'buffer' },
  --     {
  --       name = 'cmdline_history',
  --       option = { history_type = '/' }
  --     }
  --   }
  -- })

  -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
  -- cmp.setup.cmdline(':', {
  --   mapping = cmp.mapping.preset.cmdline(),
  --   sources = cmp.config.sources({
  --     { name = 'cmdline' },
  --     {
  --       name = 'path',
  --       option = {
  --         trailing_slash = true,
  --       }
  --     },
  --     {
  --       name = 'cmdline_history',
  --       option = { history_type = ':' }
  --     }
  --   })
  -- })

  -- vim.keymap.set(
  --   'i', '<c-c>t',
  --   function() require "cmp".complete({ config = { sources = { { name = "cmp_tabnine" } } } }) end,
  --   { desc = 'tabnine補完', noremap = true }
  -- )
  vim.keymap.set('i', '<c-c>s',
    function() require "cmp".complete({ config = { sources = { { name = "luasnip" } } } }) end,
    { desc = 'snippet補完', noremap = true })
  vim.keymap.set('i', '<c-c>l',
    function() require "cmp".complete({ config = { sources = { { name = "look" } } } }) end,
    { desc = 'lookの補完', noremap = true })
  vim.keymap.set('i', '<c-c><c-l>',
    function() require "cmp".complete({ config = { sources = { { name = "buffer-lines" } } } }) end,
    { desc = 'buffer-lineの補完', noremap = true })
  vim.keymap.set('i', '<c-c><c-f>',
    function()
      require "cmp".complete({ config = { sources = { { name = "path" } } } })
    end,
    { desc = 'pathの補完', noremap = true })

  vim.keymap.set('i', '<c-c><c-j>',
    function()
      require "cmp".complete({
        config = {
          sources = {
            {
              name = "skkeleton",
              view = { entries = 'native' },
            }
          }
        }
      })
    end,
    { desc = 'skkeletonの補完', noremap = true })

end

---@type LazySpec
local spec = {
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
    -- { 'https://github.com/octaltree/cmp-look' },
    { 'https://github.com/amarakon/nvim-cmp-buffer-lines' },
    { 'uga-rosa/cmp-skkeleton',                               dependencies = { 'skkeleton' } },
    -- { "windwp/nvim-autopairs",               config = true, },
    { 'saadparwaiz1/cmp_luasnip',                         dependencies = { 'LuaSnip' } },
    { 'orgmode' },
    -- {
    --   'tzachar/cmp-tabnine',
    --   build = './install.sh',
    --   lazy = true,
    --   config = function()
    --     local tabnine = require('cmp_tabnine.config')
    --
    --     tabnine:setup({
    --       max_lines = 1000,
    --       max_num_results = 20,
    --       sort = true,
    --       run_on_every_keystroke = true,
    --       snippet_placeholder = '..',
    --       ignored_file_types = {
    --         -- default is not to ignore
    --         -- uncomment to ignore in lua:
    --         -- lua = true
    --       },
    --       show_prediction_strength = false
    --     })
    --   end
    -- },
  },
  config = config,
}
return spec
