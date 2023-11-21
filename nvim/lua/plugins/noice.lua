local config = function()
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
    require 'notify'.dismiss({ pending = true, silent = true })
    require 'noice'.cmd('dismiss')
  end, {})
end

---@type LazySpec
local spec = {
  'folke/noice.nvim',
  event = "VeryLazy",
  dependencies = {
    "MunifTanjim/nui.nvim",
    'nvim-notify'
  },
  config = config,
}
return spec
