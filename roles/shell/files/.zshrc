# Theme
ZSH_THEME="af-magic"

# Zsh Plugins 
export ZSH="$HOME/.oh-my-zsh"
plugins=(git ssh-agent fzf pip docker zsh-syntax-highlighting httpie web-search tmuxinator virtualenv colored-man-pages zsh-autosuggestions)

source $ZSH/oh-my-zsh.sh
source $HOME/bin/tools/fzf-git.sh

# Hist
export HISTSIZE=90000
export HISTFILE="$HOME/.zsh_history"
setopt hist_ignore_all_dups
setopt hist_ignore_space

# include global_profile
if [ -f $HOME/.global_profile ]; then
    . $HOME/.global_profile
fi

# include criteo_profile
if [ -f $HOME/.criteo_profile ]; then
    . $HOME/.criteo_profile
fi

eval "$(zoxide init zsh)"
eval "$(rtx activate zsh)"
# eval "$(starship init bash)"

# Completion
[ -f ~/bin/tmuxinator.zsh ] && source ~/bin/tmuxinator.zsh
[ -f ~/.fzf/shell/completion.zsh ] && source ~/.fzf/shell/completion.zsh
export FZF_DEFAULT_OPTS='
--color fg:252,bg:235,hl:67,fg+:252,bg+:235,hl+:81
--color info:144,prompt:161,spinner:135,pointer:135,marker:118
'
# if inside docker
if [ -f /tmp/docker_type ]; then
    alias v='nvim'
    alias vi='nvim'
    alias vim='nvim'

    PS1="${FG[032]}%~\$(git_prompt_info)\$(hg_prompt_info) $fg[red]$(cat /tmp/docker_type) >> "
    PS2="%{$fg[red]%}\ %{$reset_color%}"

    RPS1=""
    if (( $+functions[virtualenv_prompt_info] )); then
      RPS1+='$(virtualenv_prompt_info)'
    fi
    #RPS1+=" ${FG[237]}%n%{$reset_color%}"
fi

# fzf
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export PATH=$PATH:$HOME/sqlpackage

export CDT_REMOTE_CONFIG_URL=https://moab-filer.crto.in/.filer/cdt/remote-config.json
