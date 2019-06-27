function! hook#add#language_client_neovim#load() abort
" NeoVim起動時にLSPを自動スタート
  let g:LanguageClient_autoStart         = 1 
" シンタックスチェックをON
  let g:LanguageClient_diagnosticsEnable = 1

  let g:LanguageClient_serverCommands = {}
  " `eclipse.jdt.ls`で利用する、データ保存先ディレクトリの存在確認
  " ディレクトリが存在しない場合は作成する
  let l:jdt_lsp_data_dir = expand(g:outher_package_path) . "/jdt-data"
  if !isdirectory(l:jdt_lsp_data_dir)
    call mkdir(l:jdt_lsp_data_dir, "p")
  endif
  " LSPの起動設定
  " `configuration`オプションはOSごとに別の設定にする必要がある。
  " `eclipse.jdt.ls`インストールディレクトリに、 `config_linux`, `config_mac`, `config_win` というディレクトリがあるので、それぞれOSに併せて設定ファイルパスを指定する。
  let g:LanguageClient_serverCommands["lua"] = ['lua-lsp']
  let g:LanguageClient_serverCommands["java"] = [
        \ 'java',
        \ '-agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=1044',
        \ '-Declipse.application=org.eclipse.jdt.ls.core.id1',
        \ '-Dosgi.bundles.defaultStartLevel=4',
        \ '-Declipse.product=org.eclipse.jdt.ls.core.product',
        \ '-Dlog.level=ALL',
        \ '-noverify',
        \ '-Xmx1G',
        \ '-jar',
        \ expand(g:outher_package_path) . '/jdt-lsp/plugins/org.eclipse.equinox.launcher_1.5.0.v20180207-1446.jar',
        \ '-configuration',
        \ expand(g:outher_package_path) . '/jdt-lsp/config_mac',
        \ '-data',
        \ l:jdt_lsp_data_dir,
        \ '--add-modules=ALL-SYSTEM',
        \ '--add-opens',
        \ 'ava.base/java.util=ALL-UNNAMED',
        \ '--add-opens',
        \ 'java.base/java.lang=ALL-UNNAMED']

  let g:LanguageClient_serverCommands["ruby"] = ['solargraph', 'stdio']

  " キーマッピング
  nnoremap <silent> <C-k> :call LanguageClient_textDocument_hover()<CR>
  nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
  nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
  nnoremap <silent> <F3> :call LanguageClient_textDocument_references()<CR>
endfunction
