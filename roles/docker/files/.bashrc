shopt -s cdspell

#----------------------
# Custom Commands
#----------------------
alias cddn='cd /navitia'
alias cdb='cd /build'

alias ex='exit'
alias g='git'
alias v='vim'
alias vi='vim'
alias vim='vim'
alias cl="clear"

#----------------------
# Kraken
#----------------------
alias kraken_cmake_r='cd /build/release && cmake -DCMAKE_BUILD_TYPE=RELEASE ../../navitia/source && cd -'
alias kraken_cmake_d='cd /build/debug && cmake -DCMAKE_BUILD_TYPE=DEBUG ../../navitia/source && cd -'
alias kraken_make_r='cd /build/release && make -j6 && cd -'
alias kraken_make_d='cd /build/debug && make -j6 && cd -'
alias kraken_all_r='kraken_cmake_r && kraken_make_r'
alias kraken_all_d='kraken_cmake_d && kraken_make_d'

#--------------------- Prompt
NONE='\[\033[0m\]'    # default coloring
K='\[\033[0;30;1m\]'    # black
R='\[\033[0;31;1m\]'    # red
G='\[\033[0;32;1m\]'    # green
Y='\[\033[0;33;1m\]'    # yellow
B='\[\033[0;34;1m\]'    # blue
M='\[\033[0;35;1m\]'    # magenta
C='\[\033[0;36;1m\]'    # cyan
W='\[\033[0;37;1m\]'    # white
export PS1="$C\A $R\u$Y@$W\h $G\w$Y$ $w\$ $NONE"
export PAGER=most

export EDITOR="/usr/bin/vim"

#-------------------- Cname
# recherche du CNAME dans la zone DNS
# pour affecter un hostalias dans le prompt
DOMAINE=`dnsdomainname`
HOSTALIAS=""
if [ "$DOMAINE" ] ; then
  HOSTNAME=`hostname`
  L_HOSTALIAS=`host -al -t CNAME $DOMAINE | egrep -c "[[:space:]]$HOSTNAME."`
  if [ $L_HOSTALIAS -eq 1 ] ; then
    HOSTALIAS=`host -al -t CNAME $DOMAINE | egrep "[[:space:]]$HOSTNAME." | cut -d"." -f1`
    export PS1="$C$HOSTALIAS $R\u$Y@$W\h $G\w$Y$ $NONE"
  fi
fi

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

