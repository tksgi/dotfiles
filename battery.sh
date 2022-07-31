case "$(uname)" in
  Darwin)
    #MacOSの場合
    pmset -g batt | tail -1 | cut -f 2 | cut -f 1 -d ';'
    ;;
  *)
    #Linuxの場合
    echo ''
    ;;
esac

