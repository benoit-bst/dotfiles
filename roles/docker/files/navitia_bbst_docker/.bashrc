shopt -s cdspell

#----------------------
# path
#----------------------
export PATH=$PATH:~/.local/bin

#----------------------
# Custom Commands
#----------------------
alias cddn='cd $HOME/dev/navitia'
alias cdb='cd $HOME/dev/build/navitia_docker'
alias cdd='cd $HOME/dev'
alias cdr='cd $HOME/dev/run/kraken/docker'
alias cddd='cd $HOME/dev/dataset'

alias ex='exit'
alias g='git'
alias v='vim'
alias vi='vim'
alias vim='vim'
alias cl="clear"

#----------------------
# Kraken
#----------------------
alias kraken_cmake_r='cd $HOME/dev/build/navitia_docker/release && cmake -DCMAKE_BUILD_TYPE=RELEASE $HOME/dev/navitia/source && cd -'
alias kraken_cmake_d='cd $HOME/dev/build/navitia_docker/debug && cmake -DCMAKE_BUILD_TYPE=DEBUG $HOME/dev/navitia/source && cd -'
alias kraken_make_r='cd $HOME/dev/build/navitia_docker/release && make -j6 && cd -'
alias kraken_make_d='cd $HOME/dev/build/navitia_docker/debug && make -j6 && cd -'
alias kraken_all_r='kraken_cmake_r && kraken_make_r'
alias kraken_all_d='kraken_cmake_d && kraken_make_d'
alias kraken_config='vim $HOME/dev/run/kraken/docker/kraken.ini'
alias kraken_run_r='$HOME/dev/build/navitia_docker/release/kraken/kraken $HOME/dev/run/kraken/docker/kraken.ini'
alias kraken_run_d='$HOME/dev/build/navitia_docker/debug/kraken/kraken $HOME/dev/run/kraken/docker/kraken.ini'

#----------------------
# Navitia
#----------------------
alias navitia_tests_r='cd /$HOME/dev/build/navitia_docker/release && make CTEST_OUTPUT_ON_FAILURE=1 test && cd -'
alias navitia_tests_d='cd /$HOME/dev/build/navitia_docker/debug && make CTEST_OUTPUT_ON_FAILURE=1 test && cd -'
alias navitia_docker_tests_r='cd $HOME/dev/build/navitia_docker/release && make docker_test && cd -'
alias navitia_docker_tests_d='cd $HOME/dev/build/navitia_docker/debug && make docker_test && cd -'

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
export PS1="DOCKER-BBST: $C\A $R\u$Y-DOCKER@$W\h $G\w$Y $w\$ $NONE"
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
