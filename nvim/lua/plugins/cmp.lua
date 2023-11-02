local M = {}

M.config = function()
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
      { name = 'cmp_tabnine' },
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
    { name = 'cmp_tabnine' },
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

  vim.keymap.set('i', '<c-t>', '<cmd>lua require"cmp".complete({ config = { sources = {{name = "cmp_tabnine"}} } })<cr>')
  vim.keymap.set('i', '<c-s>', '<cmd>lua require"cmp".complete({ config = { sources = {{name = "luasnip"}} } })<cr>')
  vim.keymap.set('i', '<c-f>', '<cmd>lua require"cmp".complete({ config = { sources = {{name = "path"}} } })<cr>')
end

return M
