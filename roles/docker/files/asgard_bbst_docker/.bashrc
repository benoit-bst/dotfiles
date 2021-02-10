shopt -s cdspell

#----------------------
# path
#----------------------
export PATH=$PATH:~/.local/bin

#----------------------
# Custom Commands
#----------------------
alias cdda='cd $HOME/dev/asgard'
alias cdb='cd $HOME/dev/asgard/build'
alias cdd='cd $HOME/dev'
alias cddd='cd $HOME/dev/dataset'

alias ex='exit'
alias g='git'
alias v='vim'
alias vi='vim'
alias vim='vim'
alias cl="clear"

#----------------------
# Valhalla
#----------------------
alias asgard_clone_valhalla='cd /home/bbrisset/dev/asgard && rm -rf libvalhalla && git clone https://github.com/valhalla/valhalla.git libvalhalla && cd libvalhalla && git submodule update --init --recursive --depth=1 && git reset --hard f7c8a5bef64833787ffcc7640eb7b85ee624836b && cd --'
alias asgard_build_valhalla='cd /home/bbrisset/dev/asgard && mkdir -p libvalhalla/build && cd libvalhalla/build && cmake .. -DCMAKE_BUILD_TYPE=Release -DENABLE_SERVICES=Off -DENABLE_NODE_BINDINGS=Off -DENABLE_BENCHMARKS=Off -DCMAKE_INSTALL_PREFIX:PATH=/home/bbrisset/dev/asgard/valhalla_install && make -j5 install && cd --'
alias asgard_build_asgard='cd /home/bbrisset/dev/asgard && mkdir -p build && cd build && cmake .. -DVALHALLA_INCLUDEDIR=/home/bbrisset/dev/asgard/valhalla_install/include -DVALHALLA_LIBRARYDIR=/home/bbrisset/dev/asgard/valhalla_install/lib -DCMAKE_BUILD_TYPE=Release && make -j5 && cd --'
alias asgard_test='cd /home/bbrisset/dev/asgard/build/asgard && ctest && cd --'

#----------------------
# Prompt
#----------------------
NONE='\[\033[0m\]'    # default coloring
K='\[\033[0;30;1m\]'    # black
R='\[\033[0;31;1m\]'    # red
G='\[\033[0;32;1m\]'    # green
Y='\[\033[0;33;1m\]'    # yellow
B='\[\033[0;34;1m\]'    # blue
M='\[\033[0;35;1m\]'    # magenta
C='\[\033[0;36;1m\]'    # cyan
W='\[\033[0;37;1m\]'    # white
export PS1="DOCKER-ASGARD: $C\A $R\u$Y-DOCKER@$W\h $G\w$Y $w\$ $NONE"
export PAGER=most

export EDITOR="/usr/bin/vim"

#-------------------- Commands Colors
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias ll='ls --color=auto -l'
    alias l='ls --color=auto -lA'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi
