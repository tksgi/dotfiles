local dpp_base = vim.fn.expand('$HOME') .. '/.cache/dpp'
local function init_plugin(repo)
  local repo_dir = vim.fs.joinpath(dpp_base, "repos/github.com", repo)
  if vim.fn.isdirectory(repo_dir) ~= 1 then
    vim.fn.system({
      "git",
      "clone",
      "https://github.com/" .. repo,
      repo_dir,
    })
  end
  vim.opt.rtp:prepend(repo_dir)
end

init_plugin('Shougo/dpp-ext-local')
init_plugin('Shougo/dpp-ext-lazy')
init_plugin('Shougo/dpp-ext-toml')
init_plugin('Shougo/dpp-ext-installer')
init_plugin('Shougo/dpp-protocol-git')
init_plugin('Shougo/dpp.vim')
init_plugin('vim-denops/denops.vim')

if vim.fn['dpp#min#load_state'](dpp_base, {}) then
  vim.api.nvim_create_autocmd('User', {
    -- group = vim.api.nvim_create_augroup('DenopsReady', { clear = false }),
    pattern = "DenopsReady",
    callback = function()
      vim.fn['dpp#make_state'](dpp_base, vim.fn.stdpath('config') .. '/dpp_config.ts')
    end
  })
end
