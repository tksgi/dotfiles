FROM ubuntu:latest
RUN DEBIAN_FRONTEND=noninteractive
RUN apt-get update && apt-get install -y tzdata
ENV TZ=Asia/Tokyo
RUN apt-get install -y curl git wget zsh dirmngr gpg make build-essential libssl-dev zlib1g-dev libbz2-dev libreadline-dev libsqlite3-dev libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev llvm libncursesw5-dev xz-utils tk-dev libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev
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
RUN /neovim/AppRun +PlugInstall +UpdateRemotePlugins +qa
RUN asdf plugin-add flutter && asdf install flutter 2.2.1-stable && asdf global flutter 2.2.1-stable
WORKDIR /workspace

