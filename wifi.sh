case "$(uname)" in
  Darwin)
    #MacOSの場合
    networksetup -getairportnetwork en0 | awk -F '[: ]' '{print $NF}'
    ;;
  *)
    #Linuxの場合
    echo ''
    ;;
esac

