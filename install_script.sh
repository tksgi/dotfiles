sudo apt update
sudo apt install -y git zsh vim

# rustup
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# mise
mise/apt-install-dependencies.sh
curl https://mise.run | sh
~/.local/bin/mise --version
~/.local/bin/mise install

# zsh
cat zsh/.zshenv >> $HOME/
cp zsh/.zshrc $HOME/

# git
ln -sf .gitconfig $HOME/
ln -sf .gitignore_global $HOME/

# zeno
git clone https://github.com/yuki-yano/zeno.zsh.git $HOME/zone.zsh


