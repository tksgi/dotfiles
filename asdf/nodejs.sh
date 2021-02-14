versions=(`echo 'latest 14.15.5'`)

case "$(uname)" in
  Darwin)
    #MacOSの場合
    brew install gpg gawk
    ;;
  Linux)
    #Linuxの場合
    echo 'you need following library to install nodejs'
    echo 'dirmngr gpg'
    ;;
esac

asdf plugin-add nodejs

bash -c '${ASDF_DATA_DIR:=$HOME/.asdf}/plugins/nodejs/bin/import-release-team-keyring'

for version in versions
do
  asdf install nodejs "$version"
done
asdf global `asdf latest nodejs`
