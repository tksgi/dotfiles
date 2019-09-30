function! hook#add#language_client_neovim#load() abort
" NeoVim起動時にLSPを自動スタート
  let g:LanguageClient_autoStart         = 1 
" シンタックスチェックをON
  let g:LanguageClient_diagnosticsEnable = 1

  let g:LanguageClient_serverCommands = {}
  " LSPの起動設定
  " `configuration`オプションはOSごとに別の設定にする必要がある。
  " `eclipse.jdt.ls`インストールディレクトリに、 `config_linux`, `config_mac`, `config_win` というディレクトリがあるので、それぞれOSに併せて設定ファイルパスを指定する。
  let g:LanguageClient_serverCommands["lua"] = ['lua-lsp']
  let g:LanguageClient_serverCommands["ruby"] = ['solargraph', 'stdio']
  let g:LanguageClient_serverCommands["go"] = ['~/go/bin/go-langserver']

  " javascript 設定
  let l:js_lsp_path = expand(g:outher_package_path) . "/javascript-typescript-langserver"
  " if !isdirectory(l:js_lsp_path)
  "   let l:working_path = execute(pwd)
  "   execute 'cd ' . expand(l:js_lsp_path)
  "   !git clone https://github.com/sourcegraph/javascript-typescript-langserver.git
  " endif
  let g:LanguageClient_serverCommands["javascript"] = [
        \ 'node',
        \ expand(l:js_lsp_path) . "/lib/language-server"]

  " java 設定
  " g:outher_package_pathは、`eclipse.jdt.ls`などの外部ツールのインストール先ディレクトリ。
  " 省略しているが、`init.vim`で設定している。
  " `eclipse.jdt.ls`で利用する、データ保存先ディレクトリの存在確認
  " ディレクトリが存在しない場合は作成する
  let l:jdt_lsp_data_dir = expand(g:outher_package_path) . "/jdt-data"
  if !isdirectory(l:jdt_lsp_data_dir)
    call mkdir(l:jdt_lsp_data_dir, "p")
  endif
  " 指定のディレクトリに`eclipse.jdt.ls`が存在するか確認
  let l:jdt_lsp_path = expand(g:outher_package_path) . "/jdt-lsp"
  if !executable(l:jdt_lsp_path . "/plugins/org.eclipse.equinox.launcher_1.5.0.v20180207-1446.jar")
    " `eclipse.jdt.ls`のダウンロード
    !curl -o /tmp/tmp_jdt_lsp.tar.gz http://download.eclipse.org/jdtls/snapshots/jdt-language-server-0.16.0-201803280253.tar.gz

    " `eclipse.jdt.ls`の保存先ディレクトリを作成
    call mkdir(l:jdt_lsp_path, "p")
    " ダウンロードしてきたファイルを保存先ディレクトリに解凍
    execute "!tar xf /tmp/tmp_jdt_lsp.tar.gz -C " . l:jdt_lsp_path
    " tar.gzファイルを削除
    !rm /tmp/tmp_jdt_lsp.tar.gz
  endif
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

  " キーマッピング
  nnoremap <silent> <C-k> :call LanguageClient_textDocument_hover()<CR>
  nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
  nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
  nnoremap <silent> <F3> :call LanguageClient_textDocument_references()<CR>
endfunction
