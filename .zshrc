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
setopt appendhistory autocd beep extendedglob notify
unsetopt nomatch
bindkey -e
# End of lines configured by zsh-newuser-install
autoload -Uz promptinit
promptinit
prompt adam_git

export EDITOR='vim' INPUTRC="$HOME/.inputrc"
alias p='pushd .' o='popd'
function d { local dir="$1"; ~/www/"$dir"; }
alias ls='ls --color=auto -F' grep='grep --color=auto'

function v() {
  if [ $# -ge 1 ]; then
    if [ -d "$1" ]; then
      cd "$1"
      shift
    fi
    if [ $# -ge 1 ]; then
      "$EDITOR" $@
    fi
  fi
}

sshlink="/tmp/ssh-agent-$USER-screen"
if [[ -n $SSH_AUTH_SOCK ]]; then
    if [[ ! -e $sshlink ]] || [[ `readlink $sshlink` != $SSH_AUTH_SOCK ]]; then
        rm -f $sshlink
        ln -sf "$SSH_AUTH_SOCK" $sshlink
    fi
fi

# bind special keys, should match $INPUTRC
bindkey "\C-k" up-history
bindkey "\C-j" down-history
bindkey "\C-h" backward-word
bindkey "\C-l" forward-word
