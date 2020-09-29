#!/bin/sh

set -e

echo "Install bbst config"
echo "Debian(Ubuntu) only"


# **************************************
# Install package
# **************************************
echo "** installing package"
if which cmake > /dev/null; then
    echo "** ! packages already installed"
else
    echo "** try to install packages"
    sudo apt-get install -y build-essential g++ cmake curl httpie python-pip python-dbus python3-pip xdotool clang xautolock
fi


# **************************************
# Install git
# **************************************
echo "** installing git"
if [ -L $HOME/.gitconfig ]; then
    rm -f $HOME/.gitconfig
    rm -f $HOME/.gitignore
fi
ln -s $PWD/git/.gitconfig $HOME/.gitconfig
ln -s $PWD/git/.gitignore $HOME/.gitignore
if which zsh > /dev/null; then
    echo "** ! git already installed"
else
    echo "** try to install git"
    sudo apt-get install -y git
fi


# **************************************
# Install bin
# **************************************
echo "** installing bin"
if [ -L $HOME/bin ]; then
    rm -f $HOME/bin
fi
ln -s $PWD/bin $HOME/bin

# **************************************
# Install mount
# **************************************
echo "** installing mount"
if [ ! -d ~/mount ]; then
    mkdir ~/mount
fi


# **************************************
# Install notes
# **************************************
echo "** installing notes"
if [ -L $HOME/notes ]; then
    rm -f $HOME/notes
fi
ln -s $PWD/notes $HOME/notes


# **************************************
# Install ZSH
# **************************************
echo "** install ZSH"
if [ -L $HOME/.bashrc ]; then
    rm -f $HOME/.bashrc
    rm -f $HOME/.zshrc
    rm -f $HOME/.global_profile
    rm -f $HOME/.navitia_profile
fi
ln -s $PWD/bashrc/.bashrc $HOME/.bashrc
ln -s $PWD/zsh/.zshrc $HOME/.zshrc
ln -s $PWD/profiles/.global_profile $HOME/.global_profile
ln -s $PWD/profiles/.navitia_profile $HOME/.navitia_profile
if which zsh > /dev/null; then
    echo "** ! zsh already installed"
else
    echo "** try to install zsh"
    sudo apt-get install -y zsh
    { # try
        chsh -s /usr/bin/zsh root
        sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
    } || { # catch
        echo "** ERROR install ZSH"
        return 1
    }
fi


# **************************************
# Install vim
# **************************************
echo "** install neovim"
if [ -L $HOME/.config/nvim ]; then
    rm -f $HOME/.config/nvim
    rm -f $HOME/.ctags
    rm -f $HOME/.vimrc
    rm -f $HOME/.vim
fi
ln -s $PWD/vim $HOME/.config/nvim
ln -s $PWD/vim $HOME/.vim
ln -s $PWD/vim/init.vim $HOME/.vimrc
ln -s $PWD/ctags/.ctags $HOME/.ctags
if which nvim.appimage > /dev/null; then
    echo "** ! neovim already installed"
else
    echo "** try to install neovim"
    sudo apt-get install -y fonts-powerline exuberant-ctags ack-grep
    { # try
        pushd ~/bin
        curl -LO https://github.com/neovim/neovim/releases/download/stable/nvim.appimage
        chmod u+x nvim.appimage
        popd
    } || { # catch
        echo "** ERROR install neovim"
        return 1
    }
fi


# **************************************
# Install tmux
# **************************************
echo "** install tmux"
if [ -L $HOME/.tmux.conf ]; then
    rm -f $HOME/.tmux.conf
fi
ln -s $PWD/tmux/.tmux.conf $HOME/.tmux.conf
if which tmux > /dev/null; then
    echo "** ! tmux already installed"
else
    echo "** try to install tmux"
    sudo apt-get install -y tmux vlock
    if [ ! -d ~/.tmux ]; then
        mkdir ~/.tmux
    fi
    if [ ! -d ~/.tmux/tmux-fpp ]; then
        git clone https://github.com/tmux-plugins/tmux-fpp.git ~/.tmux/tmux-fpp
    fi
    if [ ! -d ~/.tmux/tmux-open ]; then
        git clone https://github.com/tmux-plugins/tmux-open.git ~/.tmux/tmux-open
    fi
fi


# **************************************
# Install termite
# **************************************
echo "** install termite"
if [ -L $HOME/.config/termite ]; then
    rm -f $HOME/.config/termite
fi
ln -s $PWD/termite $HOME/.config/termite
if which termite > /dev/null; then
    echo "** ! termite already installed"
else
    echo "** try to install termite"

    { # try

        sudo apt-get install -y libgtk-3-dev gtk-doc-tools gnutls-bin valac intltool libpcre2-dev libglib3.0-cil-dev libgnutls28-dev libgirepository1.0-dev libxml2-utils gperf
        # VTE ng
        git clone https://github.com/thestinger/vte-ng.git $HOME/dev/vte-ng
        echo export LIBRARY_PATH="/usr/include/gtk-3.0:$LIBRARY_PATH"
        cd ~/dev/vte-ng
        ./autogen.sh
        make && sudo make install

        # termite
        git clone --recursive https://github.com/thestinger/termite.git ~/dev/termite
        cd ~/dev/termite
        make
        sudo make install
        sudo ldconfig
        sudo mkdir -p /lib/terminfo/x
        sudo ln -s /usr/local/share/terminfo/x/xterm-termite /lib/terminfo/x/xterm-termite
        sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator /usr/local/bin/termite 60

    } || { # catch
        echo "** ERROR install termite"
        return 1
    }
fi


# **************************************
# Install docker.io
# **************************************
{ # try
    echo "** install docker.io"
    if [ -x "$(command -v docker)" ]; then
        echo "** ! docker.io is already installed"
    else
        echo "** try to install docker"
        sudo apt-get install -y docker.io
        sudo usermod -aG docker $USER
        sudo systemctl restart docker
        sudo systemctl docker
    fi
} || { # catch
    echo "** ERROR install docker.io"
    return 1
}


# **************************************
# Install i3
# **************************************
echo "** install I3"
if [ -L $HOME/.config/i3 ]; then
    rm -f $HOME/.config/i3
fi
ln -s $PWD/i3 $HOME/.config/i3
if [ -L $HOME/.config/i3blocks ]; then
    rm -f $HOME/.config/i3blocks
fi
ln -s $PWD/i3blocks $HOME/.config/i3blocks
if [ -L $HOME/.wallpaper ]; then
    rm -f $HOME/.wallpaper
fi
ln -s $PWD/wallpaper $HOME/.wallpaper
if which i3 > /dev/null; then
    echo "** ! i3 already installed"
else
    echo "** try to install i3"
    sudo apt-get install -y i3 i3lock i3blocks feh rofi 
fi


# **************************************
# Install tmuxinator
# **************************************
echo "** install tmuxinator"
if [ -L $HOME/.config/tmuxinator ]; then
    rm -f $HOME/.config/tmuxinator
fi
ln -s $PWD/tmuxinator $HOME/.config/tmuxinator
if which gem > /dev/null; then
    echo "** ! tmuxinator already installed"
else
    echo "** try to install tmuxinator"
    sudo apt-get install -y ruby-full 
    sudo gem install tmuxinator
fi


# **************************************
# Install FZF
# **************************************
echo "** install fzf"
if which fzf > /dev/null; then
    echo "** ! fzf already installed"
else
    echo "** try to install fzf"
    git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
    ~/.fzf/install
fi


# **************************************
# Install dev
# **************************************
echo "** install dev"
if [ ! -d ~/dev ]; then
    mkdir ~/dev
fi
if [ ! -d ~/dev/run ]; then
    mkdir -p $HOME/dev/run/kraken/{krakenDebug,krakenRelease}
    cp -r run/* ~/dev/run
fi
if [ ! -d ~/dev/build/navitia ]; then
    mkdir -p $HOME/dev/build/navitia/{debug,release}
    mkdir -p $HOME/dev/build/navitia_docker/{debug,release}
fi
if [ ! -d ~/dev/virtualenv ]; then
    mkdir ~/dev/virtualenv
fi
if [ ! -d ~/dev/dataset ]; then
    mkdir ~/dev/dataset
fi


# **************************************
# Install FB pathpicker
# **************************************
echo "** install fb pathpicker"
if which fpp > /dev/null; then
    echo "** ! fpp already installed"
else
    echo "** try to install fpp"
    { # try
        if [ ! -d ~/bin/PathPicker ]; then
            echo "** download PathPicker repository"
        else
            echo "** remove old PathPicker repository"
            rm -rf $HOME/bin/PathPicker
        fi
        pushd ~/bin
        git clone https://github.com/facebook/PathPicker.git
        popd
        pushd ~/bin/PathPicker/debian
        ./package.sh
        popd
        pushd ~/bin/PathPicker
        sudo dpkg -i fpp_0.7.2_noarch.deb
        popd
    } || { # catch
        echo "** ERROR install FB pathPicker"
        return 1
    }
fi


# **************************************
# Install ranger
# **************************************
echo "** install ranger"
if which ranger > /dev/null; then
    echo "** ! ranger already installed"
else
    echo "** try to install ranger"
    sudo apt-get install -y ranger 
fi


# **************************************
# Install rip-grep
# **************************************
echo "** install rip-grep"
if which rg > /dev/null; then
    echo "** ! rg already installed"
else
    echo "** try to install rg"
    sudo apt-get install -y ripgrep 
fi


# **************************************
# Install spotify
# **************************************
echo "** installing spotify"
if which spotify > /dev/null; then
    echo "** ! spotify already installed"
else
    echo "** try to install spotify"
    { # try
        sudo sh -c 'echo "deb http://repository.spotify.com stable non-free" >> /etc/apt/sources.list.d/spotify.list'
        sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 4773BD5E130D1D45
        sudo apt-get update
        sudo apt-get -y spotify-client
    } || { # catch
        echo "** ERROR install spotify"
        return 1
    }
fi


# **************************************
# Install light
# **************************************
echo "** installing light"
if which light > /dev/null; then
    echo "** ! light already installed"
else
    echo "** try to install light"
    { # try
        git clone git@github.com:haikarainen/light.git ~/dev/light
        pushd $HOME/dev/light
        ./autogen.sh
        ./configure && make
        sudo make install
        popd
    } || { # catch
        echo "** ERROR install light"
        return 1
    }
fi


# **************************************
# Install rust
# **************************************
echo "** installing rust"
if which rustc > /dev/null; then
    echo "** ! rust already installed"
else
    echo "** try to install rust"
    { # try
        curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
    } || { # catch
        echo "** ERROR install Rust"
        return 1
    }
fi


# **************************************
# Install pip tools
# **************************************
echo "** installing pip tools"
if which gdbgui > /dev/null; then
    echo "** ! pip tools already installed"
else
    echo "** try to install pip tools"
    echo "** try to install pip gdbgui"
    pip install gdbgui
    echo "** try to install pip web-pdb"
    pip install web-pdb
    echo "** try to install pip pre-commit"
    pip install pre-commit
    echo "** try to install pip virtualenv"
    pip install virtualenv
fi


echo "** finish"
