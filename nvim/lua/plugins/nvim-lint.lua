local config = function()
  require('lint').linters_by_ft = {
    ruby = { 'rubocop', }
  }
  vim.api.nvim_create_autocmd({ "BufWritePost" }, {
    callback = function()
      require("lint").try_lint()
    end,
  })
end

---@type LazySpec
local spec = {
  'mfussenegger/nvim-lint',
  config = config,
}
return spec
