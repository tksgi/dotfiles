let s:dpp_base = '~/.cache/dpp/'

const s:dpp_src = '~/.cache/dpp/repos/github.com/Shougo/dpp.vim'
const s:denops_src = '~/.cache/dpp/repos/github.com/vim-denops/denops.vim'
const s:dpp_installer = '~/.cache/dpp/repos/github.com/Shougo/dpp-ext-installer'
const s:dpp_git = '~/.cache/dpp/repos/github.com/Shougo/dpp-protocol-git'

execute 'set runtimepath^=' .. s:dpp_src
execute 'set runtimepath^=' .. s:denops_src
execute 'set runtimepath^=' .. s:dpp_installer
execute 'set runtimepath^=' .. s:dpp_git

autocmd User DenopsReady
\ call dpp#make_state(s:dpp_base, '~/.config/nvim/dpp_minimum_config.ts')
