local dependencies = {
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
  -- { 'matsui54/ddu-vim-ui-select' },
  { 'matsui54/ddu-source-help' },
  { '4513ECHO/ddu-source-ghq' },
  { 'mikanIchinose/ddu-source-markdown' },
  { 'kamecha/ddu-source-jumplist' },

  -- Kind
  { 'Shougo/ddu-kind-file' },

  -- Filter
  { 'Milly/ddu-filter-kensaku' },
  { 'yuki-yano/ddu-filter-fzf' },
}
local config = function()
  local palette = require 'nightfox.palette'.load('nightfox')
  vim.api.nvim_set_hl(0, "dduFilterText", { bg = palette.sel1 })
  vim.api.nvim_set_hl(0, "dduFloating", { bg = palette.bg0 })
  vim.api.nvim_set_hl(0, "dduFloatingCursor", { bg = palette.bg3 })

  local global_config = {
    ui = 'ff',
    uiParams = {
      ff = {
        startFilter = true,
        split = 'floating',
        ignoreEmpty = false,
        autoResize = false,
        floatingBorder = 'single',
        winHeight = '&lines / 3 * 2',
        winWidth = '&columns / 3 - 2',
        winRow = '&lines / 6',
        winCol = '&columns / 3 / 2',
        filterFloatingPosition = 'bottom',
        previewFloating = true,
        previewFloatingBorder = 'single',
        previewSplit = 'vertical',
        previewHeight = 'eval(uiParams.winHeight)',
        previewWidth = 'eval(uiParams.winWidth)',
        previewCol = 'eval(uiParams.winCol) + eval(uiParams.winWidth) + 2',
        prompt = "▷ ",
        highlights = {
          filterText = 'dduFilterText',
          floating = 'dduFloating',
          floatingCursorLine = 'dduFloatingCursor',
        },
      },
    },
    sources = {
      { name = 'file_rec', params = {} }
    },
    sourceOptions = {
      _ = {
        matchers = { 'matcher_fzf' },
        sorters = { 'sorter_fzf' },
      },
      rg = {
        matchers = {},
        sorters = {},
        volatile = true,
      },
      markdown = {
        sorters = {},
      }
    },
    sourceParams = {
      markdown = {
        style = 'none',
        chunkSize = 5,
        limit = 1000,
      }
    },
    kindOptions = {
      file = { defaultAction = { 'open' }
      },
      action = { defaultAction = { 'do' }
      },
    },
    kindParams = {
      file = {
        previewCmds = { 'bat', '-n', '%s', '-r', '%b:%e', '--highlight-line', '%l' },
      },
    },
    filterParams = {
      matcher_fzf = {
        highlightMatched = 'String'
      },
      matcher_kensaku = {
        highlightMatched = 'Search'
      }
    },
  }

  vim.fn['ddu#custom#patch_global'](global_config)

  -- vim.fn['ddu#custom#action']('kind', 'file', 'grep',
  --   function(args)
  --     local path = args.items[1].action.path
  --     local directory = vim.fn.isdirectory(path) ~= 0 and path or vim.fn.fnamemodify(path, ':h')
  --
  --     print(args.options.name)
  --     print(directory)
  --     vim.fn['ddu#start']({
  --       name = args.options.name,
  --       push = true,
  --       sources = {
  --         {
  --           name = 'rg',
  --           options = {
  --             path = directory,
  --           }
  --         }
  --       }
  --     })
  --   end
  -- )
  vim.api.nvim_exec([[
    call ddu#custom#action('kind', 'file', 'grep',
        \ { args -> GrepAction(args) })
    function GrepAction(args)
      " NOTE: param "path" must be one directory
      const path = a:args.items[0].action.path
      const directory = isdirectory(path) ? path : fnamemodify(path, ':h')

      call ddu#start(#{
          \   name: a:args.options.name,
          \   sources: [
          \     #{
          \       name: 'rg',
          \       options: #{
          \         path: directory,
          \       },
          \     },
          \   ],
          \ })
    endfunction
  ]], false)

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "ddu-ff",
    callback = function()
      local keymapOpt = { buffer = true, silent = true, remap = true }
      vim.keymap.set('n', '<CR>', function() vim.fn['ddu#ui#do_action']('itemAction') end, keymapOpt)
      vim.keymap.set('n', '<Tab>', function() vim.fn['ddu#ui#do_action']('toggleSelectItem') end, keymapOpt)
      vim.keymap.set('n', '<Space>', function() vim.fn['ddu#ui#do_action']('expandItem') end, keymapOpt)
      vim.keymap.set('n', '+', function() vim.fn['ddu#ui#do_action']('chooseAction') end, keymapOpt)
      vim.keymap.set('n', '<C-a>', function() vim.fn['ddu#ui#do_action']('toggleAllItems') end, keymapOpt)
      vim.keymap.set('n', '<C-q>', function() vim.fn['ddu#ui#do_action']('itemAction', { name = 'quickfix' }) end,
        keymapOpt)

      vim.keymap.set('n', 'p', function() vim.fn['ddu#ui#do_action']('preview') end, keymapOpt)

      vim.keymap.set('n', 'i', function() vim.fn['ddu#ui#do_action']('openFilterWindow') end, keymapOpt)
      vim.keymap.set('n', 'q', function() vim.fn['ddu#ui#do_action']('quit') end, keymapOpt)
    end
  })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = "ddu-ff-filter",
    callback = function()
      local keymapOpt = { buffer = true, silent = true, remap = true }
      vim.keymap.set('i', '<CR>', '<ESC><Cmd>call ddu#ui#do_action("leaveFilterWindow")<cr>', keymapOpt)
      vim.keymap.set('n', '<CR>', function() vim.fn['ddu#ui#do_action']('leaveFilterWindow') end, keymapOpt)
      vim.keymap.set('n', 'q', function() vim.fn['ddu#ui#do_action']('closeFilterWindow') end, keymapOpt)

      vim.keymap.set('i', '<C-A>', '<Home>', keymapOpt)
      vim.keymap.set('i', '<C-E>', '<End>', keymapOpt)
    end
  })

  -- call ddu#start({'sources': [{'name': 'markdown'}], 'ui': 'filer'})
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "markdown",
    callback = function()
      vim.keymap.set('n', 'gO', function() vim.fn['ddu#start']({ sources = { { name = 'markdown' } } }) end, {})
      vim.api.nvim_create_user_command('MarkdownTOC',
        function() vim.fn['ddu#start']({ sources = { { name = 'markdown' } } }) end, {})
    end
  })
end

---@type LazySpec
local spec = {
  'Shougo/ddu.vim',
  dependencies = dependencies,
  config = config,
}
return spec
