FROM ubuntu:latest
RUN apt-get update && apt-get install -y curl git wget zsh dirmngr gpg
RUN chsh root -s /usr/bin/zsh
COPY ./ /root/dotfiles/
RUN cp /root/dotfiles/zsh/.zshrc /root
RUN mkdir /root/.config
RUN cp -r /root/dotfiles/nvim /root/.config

SHELL ["zsh", "-c"]

RUN /root/dotfiles/asdf/install_asdf.zsh
ENV PATH $PATH:/root/.asdf/bin
RUN zsh /root/dotfiles/asdf/install_asdf_plugin.zsh

RUN wget https://github.com/neovim/neovim/releases/download/v0.5.0/nvim.appimage
RUN chmod +x ./nvim.appimage && ./nvim.appimage --appimage-extract
RUN mv ./squashfs-root neovim
RUN echo 'alias nvim="/neovim/AppRun"' >> /root/.zshrc
RUN sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
  https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
WORKDIR /workspace

