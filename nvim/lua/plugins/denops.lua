-- local init = function()
--   vim.fn.jobstart({'deno', 'run', '-A', '--no-lock', vim.fn.stdpath('data') .. '/denops.vim/denops/@denops-private/cli.ts', '--port', '32123'}, { detach = true })
-- end
vim.g.denops_server_addr = '127.0.0.1:32123'

---@type LazySpec
local spec = {
  'vim-denops/denops.vim',
  lazy = false,
  -- init = init,
  dependencies = {
    'vim-denops/denops-shared-server.vim', build = function()
      vim.fn['denops_shared_server#install']()
    end
  }
}
return spec
