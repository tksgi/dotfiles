FROM ubuntu:latest
RUN apt-get update && apt-get install -y curl git wget zsh dirmngr gpg
RUN chsh root -s /usr/bin/zsh
COPY ./ /root/dotfiles/
RUN cp /root/dotfiles/zsh/.zshrc /root
RUN mkdir /root/.config
RUN cp -r /root/dotfiles/nvim /root/.config
RUN zsh  /root/dotfiles/asdf/install_asdf.sh
# RUN . $HOME/.asdf/asdf.sh
RUN zsh /root/dotfiles/asdf/install_asdf_plugin.sh

RUN cd /root
RUN wget https://github.com/neovim/neovim/releases/download/v0.5.0/nvim.appimage
RUN chmod +x ./nvim.appimage && ./nvim.appimage --appimage-extract
RUN ln -s  squashfs-root/AppRun /usr/local/bin/nvim
# RUN npm install -g neovim
RUN sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'

