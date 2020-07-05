shopt -s cdspell

. /etc/bash_completion

export LC_ALL=en_US.UTF-8

# Hist
export HISTCONTROL=ignoredups:erasedups
shopt -s histappend
export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"
export HISTFILESIZE=1000
export HISTIGNORE="cdb:cddd:v:v *:vi:vi *:vim:vim *:ls:l:ll:ps:ps *::history *::pwd:top:gotop:cava:clear:clear *:cl:cl *:pstree"

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
export PS1="$C\A $R\u$Y@$W\h $G\w$Y$ $w\$(__git_ps1 '[%s]') $NONE"

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

# include navitia_profile
if [ -f $HOME/.global_profile ]; then
    . $HOME/.global_profile
fi

# tmuxinator
[ -f ~/bin/tmux_completion.bash ] && source ~/bin/tmux_completion.bash
[ -f ~/bin/tmuxinator.bash ] && source ~/bin/tmuxinator.bash
[ -f ~/.fzf/shell/completion.bash ] && source ~/.fzf/shell/completion.bash
export FZF_DEFAULT_OPTS='
--color fg:252,bg:235,hl:67,fg+:252,bg+:235,hl+:81
--color info:144,prompt:161,spinner:135,pointer:135,marker:118
'

