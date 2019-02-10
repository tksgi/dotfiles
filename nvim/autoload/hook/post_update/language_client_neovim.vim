function! hook#post_update#language_client_neovim#load() abort
  !./install.sh
  " g:outher_package_pathは、`eclipse.jdt.ls`などの外部ツールのインストール先ディレクトリ。
  " 省略しているが、`init.vim`で設定している。
  let l:jdt_lsp_path = expand(g:outher_package_path) . "/jdt-lsp"
  " 指定のディレクトリに`eclipse.jdt.ls`が存在するか確認
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
endfunction
