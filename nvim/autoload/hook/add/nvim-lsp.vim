function! hook#add#denite#load() abort
  lua << EOF
  local nvim_lsp = require'nvim_lsp'
  nvim_lsp.gopls.setup{}
  nvim_lsp.dartls.setup{
    cmd = { "dart", "/usr/local/Cellar/dart/2.7.1/libexec/bin/snapshots/analysis_server.dart.snapshot", "--lsp" }
  }
  nvim_lsp.pyls.setup{}
  nvim_lsp.solargraph.setup{}
  nvim_lsp.vimls.setup{}
  nvim_lsp.tsserver.setup{}
  nvim_lsp.vuels.setup{}
  nvim_lsp.yamlls.setup{}
  nvim_lsp.dockerls.setup{}
  EOF
endfunction
