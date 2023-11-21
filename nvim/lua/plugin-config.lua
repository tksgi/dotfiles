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

require("lazy").setup("plugins", {
  custom_keys = {
    ["<localleader>t"] = function(plugin)
      require("lazy.util").float_term(nil, {
        cwd = plugin.dir,
      })
    end,
  },
  readme = {
    enabled = true,
    skip_if_doc_exists = true,
  }
})

