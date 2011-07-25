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
zstyle :compinstall filename '/home/ronuk/.zshrc'

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

export EDITOR='vim'
alias p='pushd .' o='popd'
function d { local dir="$1"; ~/www/"$dir"; }
alias ls='ls --color=auto -F' grep='grep --color=auto'

source /home/engshare/admin/scripts/master.zshrc

alias ab='/home/engshare/devtools/arcanist/bin/arc build'
alias up='git fetch; git rebase trunk; ab'
function new { git checkout -b $1 trunk; up }
alias com='git commit -a'
alias acom='git commit -a --amend'
alias sw='git checkout'
alias st='git status'
alias br='git branch'
alias ad='/home/engshare/devtools/arcanist/bin/arc diff'
alias sm='/home/engshare/devtools/arcanist/bin/arc amend; git svn dcommit'
alias cont='git rebase --continue'
alias del='sw master; git branch -D'

export HPHP_HOME=/home/rraval/hphp HPHP_LIB=/home/rraval/hphp/bin
export DISTCC_VERBOSE=true HPHP_FACEBOOK_WWW=/home/rraval/www
export PATH=/home/rraval/scripts/bin:/home/rraval/www/flib/_bin:/mnt/vol/hive/dis/databee:$PATH

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

# Hive stuff
export HIVE_RLWRAP=true
source /mnt/vol/hive/dis/lib/utils/hive.include
hive_select_release silver
export HIVE_LIB=$HADOOP_HOME/lib

sshlink="/tmp/ssh-agent-$USER-screen"
if [ $SSH_AUTH_SOCK ] && [ ! -e $sshlink ] || [ `readlink $sshlink` != $SSH_AUTH_SOCK ]; then
  rm -f $sshlink
  ln -sf "$SSH_AUTH_SOCK" $sshlink
fi
