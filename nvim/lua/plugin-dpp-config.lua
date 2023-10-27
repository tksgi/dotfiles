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

init_plugin('Shougo/dpp.vim')
init_plugin('Shougo/dpp-ext-lazy')

vim.api.nvim_exec2([[
filetype plugin indent on
autocmd FileType * syntax on
]], {})

if vim.fn['dpp#min#load_state'](dpp_base, {}) then
  init_plugin('vim-denops/denops.vim')
  init_plugin('Shougo/dpp-ext-local')
  init_plugin('Shougo/dpp-ext-toml')
  init_plugin('Shougo/dpp-ext-installer')
  init_plugin('Shougo/dpp-protocol-git')

  vim.cmd({ cmd = 'runtime', args = { 'plugin/denops.vim' } })

  vim.api.nvim_create_autocmd('User', {
    -- group = vim.api.nvim_create_augroup('DenopsReady', { clear = false }),
    pattern = "DenopsReady",
    callback = function()
      vim.fn['dpp#make_state'](dpp_base, vim.fn.stdpath('config') .. '/dpp_config.ts', 'nvim')
    end
  })
  vim.api.nvim_create_autocmd('User', {
    pattern = 'Dpp:makeStatePost',
    callback = function()
      --vim.cmd('quit!')
      vim.fn['dpp#min#load_state'](dpp_base, 'nvim')
      vim.fn['dpp#util#_call_hook']('post_source')
    end
  })

  vim.api.nvim_create_user_command('DppInstall', function() vim.fn['dpp#async_ext_action']('installer', 'install') end, {})
  vim.api.nvim_create_user_command('DppUpdate', function() vim.fn['dpp#async_ext_action']('installer', 'update') end, {})

end
