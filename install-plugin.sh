if [ -z "$1" ]; then 
    echo "Usage: ./install-plugin.sh https://github.com/user/plugin"
    exit 1;
fi

cd pack/romes/start || exit 1
/usr/bin/env git --git-dir=$HOME/control/dotfiles/.git --work-tree=$HOME/control/dotfiles submodule add "$1" || exit 1
