fpath=(~/.zsh $fpath)
# The following lines were added by compinstall

zstyle ':completion:*' add-space true
zstyle ':completion:*' completer _expand _complete _ignored _match _correct _approximate _prefix
zstyle ':completion:*' completions 1
zstyle ':completion:*' glob 1
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' match-original both
zstyle ':completion:*' matcher-list '' 'r:|[._-]=* r:|=*' 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}' 'l:|=* r:|=*'
zstyle ':completion:*' max-errors 2
zstyle ':completion:*' prompt 'E:%e'
zstyle ':completion:*' substitute 1

autoload -Uz compinit colors
compinit
colors
# End of lines added by compinstall
# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt appendhistory autocd autopushd beep extendedglob notify
unsetopt nomatch
bindkey -e
# End of lines configured by zsh-newuser-install
autoload -Uz promptinit
promptinit
prompt adam_git

export EDITOR='vim'
export PATH="$HOME/bin:$PATH"
alias ls='ls --color=auto -F' grep='grep --color=auto'

sshlink="/tmp/ssh-agent-$USER-screen"
if [[ -n $SSH_AUTH_SOCK ]]; then
    if [[ ! -e $sshlink ]] || [[ `readlink $sshlink` != $SSH_AUTH_SOCK ]]; then
        rm -f $sshlink
        ln -sf "$SSH_AUTH_SOCK" $sshlink
    fi
fi

[[ -s "/home/rraval/.rvm/scripts/rvm" ]] && source "/home/rraval/.rvm/scripts/rvm"
