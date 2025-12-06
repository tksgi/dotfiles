---@type LazySpec
local spec = {
  'saghen/blink.cmp',
  enabled = vim.g.completion_plugin == 'blink',
  version = '*',

  ---module 'blink.cmp'
  ---@type blink.cmp.Config
  opts = {
    completion = {
      documentation = {
        auto_show = true,
        auto_show_delay_ms = 500,
        window = {
          border = 'single',
        },
      },
      menu = {
        auto_show = false,
        border = 'single',
        draw = {
          treesitter = { 'lsp', 'buffer' },
        }
      }
    },
    keymap = {
      preset = 'default',
      ['<C-n>'] = { 'show', 'select_next' },
      ['<C-b><C-f>'] = {
        function(cmp) cmp.show({ providers = { 'path' } }) end
      },
      ['<C-b><C-b>'] = {
        function(cmp) cmp.show({ providers = { 'buffer' } }) end
      },
      ['<Space>'] = {},
    },
    signature = { enabled = true },
    sources = {
      default = function(_ctx)
        if require("blink-cmp-skkeleton").is_enabled() then
          return { "skkeleton" }
        else
          return { "lsp", "path", "snippets", "buffer" }
        end
      end,
      providers = {
        skkeleton = {
          name = "skkeleton",
          module = "blink-cmp-skkeleton",
        },
      },
    }
    -- sources = {
    --   providers = {
    --     path = {
    --       opts = {
    --         get_cwd = function()
    --           return vim.fn.getcwd()
    --         end,
    --       }
    --     }
    --   }
    -- }
  },
  dependencies = {
    "Xantibody/blink-cmp-skkeleton",
    "vim-skk/skkeleton",
    "vim-denops/denops.vim",
  },
}
return spec
