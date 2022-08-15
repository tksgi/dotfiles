vim.opt.completeopt = {'menu','menuone','noselect'}

local cmp = require'cmp'

cmp.setup({
  mapping = cmp.mapping.preset.insert({
      ['<C-b>'] = cmp.mapping.scroll_docs(-4),
      ['<C-f>'] = cmp.mapping.scroll_docs(4),
      ['<C-Space>'] = cmp.mapping.complete(),
      ['<C-e>'] = cmp.mapping.abort(),
      ['<CR>'] = cmp.mapping.confirm({ select = true }), -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
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

})

-- Set configuration for specific filetype.
cmp.setup.filetype('gitcommit', {
  sources = cmp.config.sources({
    { name = 'cmp_git' }, -- You can specify the `cmp_git` source if you were installed it.
  }, {
    { name = 'buffer' },
  })
})

cmp.setup.filetype('lua', {
  sources = cmp.config.sources({
    { name = 'nvim_lua' }, -- You can specify the `cmp_git` source if you were installed it.
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
