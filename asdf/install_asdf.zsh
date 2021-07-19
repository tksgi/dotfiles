case "$(uname)" in
  Darwin)
    #MacOSの場合
    brew install coreutils curl git
    # for nodejs
    brew install gpg gawk
    ;;
  Linux)
    #Linuxの場合
    echo 'you need following library'
    echo '#global requirement'
    echo 'curl git'
    echo ''
    echo '#for nodejs'
    echo 'dirmngr gpg'
    ;;
esac
git clone https://github.com/asdf-vm/asdf.git ~/.asdf
cd ~/.asdf
git checkout "$(git describe --abbrev=0 --tags)"

ln -sf ~/dotfiles/asdf/.asdfrc ~/
ln -sf ~/dotfiles/asdf/.default-gems ~/
ln -sf ~/dotfiles/asdf/.default-npm-packages ~/
ln -sf ~/dotfiles/asdf/.default-python-packages ~/
