local config = function()
  require('conform').setup({
    formatters_by_ft = {
      lua = { "stylua" },
      python = { "isort", "black" },
      javascript = { { "prettierd", "prettier" } },
      typescript = { { "prettierd", "prettier" } },
      javascriptreact = { { "prettierd", "prettier" } },
      typescriptreact = { { "prettierd", "prettier" } },
      vue = { { "prettierd", "prettier" } },
      css = { { "prettierd", "prettier" } },
      scss = { { "prettierd", "prettier" } },
      less = { { "prettierd", "prettier" } },
      html = { { "prettierd", "prettier" } },
      json = { { "prettierd", "prettier" } },
      jsonc = { { "prettierd", "prettier" } },
      yaml = { { "prettierd", "prettier" } },
      markdown = { { "prettierd", "prettier" } },
      graphql = { { "prettierd", "prettier" } },
      handlebars = { "prettier" },
      go = { "goimports", "gofmt" },
      rust = { "rustfmt" },
      sh = { "shfmt" },
      ruby = { "rubocop" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_fallback = true,
    },
  })

  -- Key mappings for manual formatting
  vim.keymap.set({ "n", "v" }, "<leader>f", function()
    require("conform").format({
      lsp_fallback = true,
      async = false,
      timeout_ms = 500,
    })
  end, { desc = "Format file or range (in visual mode)" })
end

---@type LazySpec
local spec = {
  'stevearc/conform.nvim',
  opts = {},
  config = config,
}
return spec