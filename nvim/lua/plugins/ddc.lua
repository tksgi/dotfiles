local config = function()
  vim.fn['ddc#custom#patch_global']('ui', 'pum')
  vim.fn['ddc#custom#patch_global']('autoCompleteEvents', {
    'InsertEnter', 'TextrChangedI', 'TextChangedP', 'CmdlineChanged'
  })
  vim.g.ggc_default_sources = { 'nvim-lsp', 'skkeleton', 'around', 'line', 'buffer', 'file' }
  vim.fn['ddc#custom#patch_global']('sources', vim.g.ggc_default_sources)
  local sourceOptions = {
    _ = {
      matchers = { 'matcher_head' },
      sorters = { 'sorter_rank' },
      converters = { 'converter_fuzzy' },
    },
    zsh = {
      mark = 'Z',
      maxItems = 10,
    },
    skkeleton = {
      mark = 'skk',
      matchers = { 'skkeleton' },
      maxItems = 10,
    },
    buffer = {
      mark = 'buffer',
      maxItems = 5,
    },
    file = {
      mark = 'F',
      isVolatile = true,
      forceCompletionPattern = [[\S/\S*]],
      maxItems = 5,
    },
    necovim = {
      mark = 'necovim',
      maxItems = 10,
    },
    tabnine = {
      mark = 'TN',
      maxItems = 10,
      isVolatile = true,
    },
    oldfiles = {
      mark = 'oldfiles',
      maxItems = 5,
    },
    around = {
      mark = 'A',
      maxItems = 5,
    },
    line = {
      mark = 'line',
      maxItems = 5,
    },
    cmdline = {
      mark = 'cmd',
      maxItems = 10,
    },
    look = {
      converters = { 'loud' },
      matchers = {},
      mark = 'l',
      isVolatile = true
    }
  }
  sourceOptions['nvim-lsp'] = {
    mark = 'lsp',
    forceCompletionPattern = [[.\w*|:\w*|->\w*]],
    maxItems = '10',
  }
  sourceOptions['git-flie'] = {
    mark = 'gitF',
    maxItems = 5,
  }
  sourceOptions['git-commit'] = {
    mark = 'gitF',
    maxItems = 5,
  }
  sourceOptions['git-branch'] = {
    mark = 'gitF',
    maxItems = 5,
  }
  sourceOptions['cmdline-history'] = {
    mark = 'history',
    maxItems = 5,
  }
  vim.fn['ddc#custom#patch_global']('sourceOptions', sourceOptions)
  vim.fn['ddc#custom#patch_filetype']({ 'zsh' }, 'sources', { 'zsh' })

  function CommandlinePre()
    vim.keymap.set('c', '<Tab>', function() vim.fn['pum#map#insert_relative']('+1') end, { remap = true })
    vim.keymap.set('c', '<S-Tab>', function() vim.fn['pum#map#insert_relative']('-1') end, { remap = true })
    vim.keymap.set('c', '<C-n>', function() vim.fn['pum#map#insert_relative']('+1') end, { remap = true })
    vim.keymap.set('c', '<C-p>', function() vim.fn['pum#map#insert_relative']('-1') end, { remap = true })
    vim.keymap.set('c', '<C-y>', function() vim.fn['pum#map#confirm']() end, { remap = true })
    vim.keymap.set('c', '<C-e>', function() vim.fn['pum#map#cancel']() end, { remap = true })

    if not vim.b.prev_buffer_config then
      vim.b.prev_buffer_config = vim.fn['ddc#custom#get_buffer']()
    end

    vim.fn['ddc#custom#patch_buffer']('cmdlineSources', { 'cmdline', 'cmdline-history', 'necovim', 'oldfiles', 'around' })

    vim.api.nvim_exec([[
    autocmd User DDCCmdlineLeave ++once lua CommandlinePost()
    autocmd InsertEnter <buffer> ++once lua CommandlinePost()
  ]], false)

    vim.fn['ddc#enable_cmdline_completion']()
  end

  function CommandlinePost()
    vim.keymap.del('c', '<Tab>')
    vim.keymap.del('c', '<S-Tab>')
    vim.keymap.del('c', '<C-n>')
    vim.keymap.del('c', '<C-p>')
    vim.keymap.del('c', '<C-y>')
    vim.keymap.del('c', '<C-e>')

    if vim.b.prev_buffer_config then
      vim.fn['ddc#custom#set_buffer'](vim.b.prev_buffer_config)
      vim.b.prev_buffer_config = nil
    else
      vim.fn['ddc#custom#set_buffer']()
    end
  end

  -- vim.keymap.set('n', ':', CommandlinePre, { remap = true })
  vim.keymap.set('n', ';', '<cmd>lua CommandlinePre<cr>:', { remap = true })
  vim.keymap.set('i', '<Tab>', function() vim.fn['pum#map#insert_relative']('+1') end, { remap = true })
  vim.keymap.set('i', '<S-Tab>', function() vim.fn['pum#map#insert_relative']('-1') end, { remap = true })
  vim.keymap.set('i', '<C-n>', function() vim.fn['pum#map#insert_relative']('+1') end, { remap = true })
  vim.keymap.set('i', '<C-p>', function() vim.fn['pum#map#insert_relative']('-1') end, { remap = true })
  vim.keymap.set('i', '<C-y>', function() vim.fn['pum#map#confirm']() end, { remap = true })
  vim.keymap.set('i', '<C-e>', function() vim.fn['pum#map#cancel']() end, { remap = true })

  vim.keymap.set('i', '<C-x><C-o>', function() vim.fn['ddc#custom#patch_buffer']('sources', vim.g.ddc_default_souces) end,
    { remap = true })
  vim.keymap.set('i', '<C-x><C-f>', function() vim.fn['ddc#custom#patch_buffer']('sources', { 'file', 'git-file' }) end,
    { remap = true })
  vim.keymap.set('i', '<C-x>s', function() vim.fn['ddc#custom#patch_buffer']('sources', { 'look' }) end, { remap = true })
  vim.keymap.set('i', '<C-x><C-]>',
    function() vim.fn['ddc#custom#patch_buffer']('sources', { 'nvim-lsp', 'treesitter' }) end,
    { remap = true })
  vim.keymap.set('i', '<C-x><C-l>', function() vim.fn['ddc#custom#patch_buffer']('sources', { 'line' }) end,
    { remap = true })
  vim.keymap.set('i', '<C-x><C-v>',
    function() vim.fn['ddc#custom#patch_buffer']('sources', { 'cmdline', 'cmdline-history' }) end, { remap = true })
  vim.keymap.set('i', '<C-x><C-i>',
    function() vim.fn['ddc#custom#patch_buffer']('sources', { 'buffer', 'around-history' }) end, { remap = true })

  vim.fn['pum#set_option']('border', 'double')
  vim.fn['ddc#enable']()
  vim.fn['popup_preview#enable']()
  vim.fn['signature_help#enable']()
















  -- vim.api.nvim_exec([[
  --   call ddc#custom#patch_global('ui', 'pum')
  --   call ddc#custom#patch_global('autoCompleteEvents', ['InsertEnter', 'TextChangedI', 'TextChangedP', 'CmdlineChanged'])
  --
  --   let g:ddc_default_souces = ['nvim-lsp', 'tabnine', 'skkeleton', 'line', 'buffer', 'file']
  --   call ddc#custom#patch_global('sources', g:ddc_default_souces)
  --   call ddc#custom#patch_global('sourceOptions', {
  --   \   '_': {
  --   \     'matchers': ['matcher_head'],
  --   \     'sorters': ['sorter_rank'],
  --   \     'converters': ['converter_fuzzy']
  --   \   },
  --   \   'zsh': {
  --   \     'mark': 'Z',
  --   \     'maxItems': 10,
  --   \   },
  --   \   'nvim-lsp': {
  --   \     'mark': 'lsp',
  --   \     'forceCompletionPattern': '\.\w*|:\w*|->\w*',
  --   \     'maxItems': 10,
  --   \   },
  --   \   'skkeleton': {
  --   \     'mark': 'skkeleton',
  --   \     'matchers': ['skkeleton'],
  --   \     'maxItems': 10,
  --   \   },
  --   \   'buffer': {
  --   \     'mark': 'buffer',
  --   \     'maxItems': 5,
  --   \   },
  --   \   'file': {
  --   \     'mark': 'F',
  --   \     'isVolatile': v:true,
  --   \     'forceCompletionPattern': '\S/\S*',
  --   \     'maxItems': 5,
  --   \   },
  --   \   'git-flie': {
  --   \     'mark': 'gitF',
  --   \     'maxItems': 5,
  --   \   },
  --   \   'git-commit': {
  --   \     'mark': 'gitF',
  --   \     'maxItems': 5,
  --   \   },
  --   \   'git-branch': {
  --   \     'mark': 'gitF',
  --   \     'maxItems': 5,
  --   \   },
  --   \   'necovim': {
  --   \     'mark': 'necovim',
  --   \     'maxItems': 10,
  --   \    },
  --   \   'tabnine': {
  --   \     'mark': 'TN',
  --   \     'maxItems': 10,
  --   \     'isVolatile': v:true,
  --   \   },
  --   \   'oldfiles': {
  --   \     'mark': 'oldfiles',
  --   \     'maxItems': 5,
  --   \   },
  --   \   'around': {
  --   \     'mark': 'around',
  --   \     'maxItems': 5,
  --   \   },
  --   \   'line': {
  --   \     'mark': 'line',
  --   \     'maxItems': 5,
  --   \   },
  --   \  'cmdline': {
  --   \     'mark': 'cmdline',
  --   \     'maxItems': 10,
  --   \  },
  --   \  'cmdline-history': {
  --   \     'mark': 'history',
  --   \     'maxItems': 5,
  --   \  },
  --   \  'look': {
  --   \     'converters': ['loud'],
  --   \     'matchers': [],
  --   \     'mark': 'l',
  --   \     'isVolatile': v:true
  --   \  }
  --   \ })
  --   call ddc#custom#patch_global('sourceParams', {
  --   \ 'look': {
  --   \   'convertCase': v:true,
  --   \   'dict': v:null
  --   \ }})
  --
  --   call ddc#custom#patch_filetype(['zsh'], 'sources', ['zsh'])
  --
  --   nnoremap ;       <Cmd>call CommandlinePre()<CR>:
  --   inoremap <Tab>   <Cmd>call pum#map#insert_relative(+1)<CR>
  --   inoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
  --   inoremap <C-n>   <Cmd>call pum#map#insert_relative(+1)<CR>
  --   inoremap <C-p>   <Cmd>call pum#map#insert_relative(-1)<CR>
  --   inoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
  --   "inoremap <CR>   <Cmd>call pum#map#confirm()<CR>
  --   inoremap <C-e>   <Cmd>call pum#map#cancel()<CR>
  --   inoremap <PageDown> <Cmd>call pum#map#insert_relative_page(+1)<CR>
  --   inoremap <PageUp>   <Cmd>call pum#map#insert_relative_page(-1)<CR>
  --
  --   inoremap <C-x><C-o>   <Cmd>call ddc#custom#patch_buffer('sources', g:ddc_default_souces)<CR>
  --   inoremap <C-x><C-f>   <Cmd>call ddc#custom#patch_buffer('sources', ['file', 'git-file'])<CR>
  --   inoremap <C-x>s       <Cmd>call ddc#custom#patch_buffer('sources', ['look'])<CR>
  --   inoremap <C-x><C-t>   <Cmd>call ddc#custom#patch_buffer('sources', ['tabnine'])<CR>
  --   inoremap <C-x><C-]>   <Cmd>call ddc#custom#patch_buffer('sources', ['nvim-lsp', 'treesitter'])<CR>
  --   inoremap <C-x><C-l>   <Cmd>call ddc#custom#patch_buffer('sources', ['line'])<CR>
  --   inoremap <C-x><C-v>   <Cmd>call ddc#custom#patch_buffer('sources', ['cmdline', 'cmdline-history'])<CR>
  --   inoremap <C-x><C-i>   <Cmd>call ddc#custom#patch_buffer('sources', ['buffer', 'around'])<CR>
  --
  --
  --   call pum#set_option('border', 'double')
  --   call ddc#enable()
  --   call popup_preview#enable()
  --   call signature_help#enable()
  --
  --   "nnoremap :       <Cmd>call CommandlinePre()<CR>:
  --
  --   function! CommandlinePre() abort
  --   cnoremap <Tab>   <Cmd>call pum#map#insert_relative(+1)<CR>
  --   cnoremap <S-Tab> <Cmd>call pum#map#insert_relative(-1)<CR>
  --   cnoremap <C-n>   <Cmd>call pum#map#insert_relative(+1)<CR>
  --   cnoremap <C-p>   <Cmd>call pum#map#insert_relative(-1)<CR>
  --   cnoremap <C-y>   <Cmd>call pum#map#confirm()<CR>
  --   cnoremap <C-e>   <Cmd>call pum#map#cancel()<CR>
  --
  --   " Overwrite sources
  --   if !exists('b:prev_buffer_config')
  --   let b:prev_buffer_config = ddc#custom#get_buffer()
  --   endif
  --   call ddc#custom#patch_buffer('cmdlineSources',
  --   \ ['cmdline', 'cmdline-history', 'necovim', 'oldfiles', 'around'])
  --
  --   autocmd User DDCCmdlineLeave ++once call CommandlinePost()
  --   autocmd InsertEnter <buffer> ++once call CommandlinePost()
  --
  --   " Enable command line completion
  --   call ddc#enable_cmdline_completion()
  --   endfunction
  --   function! CommandlinePost() abort
  --   silent! cunmap <Tab>
  --   silent! cunmap <S-Tab>
  --   silent! cunmap <C-n>
  --   silent! cunmap <C-p>
  --   silent! cunmap <C-y>
  --   silent! cunmap <C-e>
  --
  --   " Restore sources
  --   if exists('b:prev_buffer_config')
  --   call ddc#custom#set_buffer(b:prev_buffer_config)
  --   unlet b:prev_buffer_config
  --   else
  --   call ddc#custom#set_buffer({})
  --   endif
  --   endfunction
  --
  --   " SKKがenableの時だけskkeleton sourceを有効化	autocmd User skkeleton-enable-pre call s:skkeleton_pre()
  --   function! s:skkeleton_pre() abort
  --   " Overwrite sources
  --     let s:prev_buffer_config = ddc#custom#get_buffer()
  --     call ddc#custom#patch_buffer('sources', ['skkeleton'])
  --   endfunction
  --   autocmd User skkeleton-disable-pre call s:skkeleton_post()
  --   function! s:skkeleton_post() abort
  --   " Restore sources
  --     call ddc#custom#set_buffer(s:prev_buffer_config)
  --   endfunction
  -- ]], false)
end

---@type LazySpec
local spec =
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
    { 'octaltree/cmp-look' },   -- complete english word
  },
  config = config,
}
return spec
