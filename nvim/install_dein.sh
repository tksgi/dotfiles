#!sh
curl https://raw.githubusercontent.com/flutter/flutter/master/analysis_options.yaml > installer.sh
curl https://raw.githubusercontent.com/Shougo/dein.vim/master/bin/installer.sh > installer.sh
bash ./installer.sh ~/.cache/dein
pip3 install neovim-remote --user
