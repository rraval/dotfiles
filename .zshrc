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

# Fast Git Completion:
# http://talkings.org/post/5236392664/zsh-and-slow-git-completion
__git_files() { 
    _wanted files expl 'local files' _files 
}

export EDITOR='vim'
export PATH="$HOME/bin:$PATH"
alias ls='ls --color=auto -F' grep='grep --color=auto'
alias aurget='aurget --deps --noconfirm'
alias logcat='adb logcat | python2 ~/bin/colorlogcat.py'

export TIMEFMT='%U user, %S system, %E elapsed, %P CPU (%X text, %D data, %M max)k
%I inputs, %O outputs (%F major, %R minor) pagefaults, %W swaps'
export NODE_PATH='/usr/lib/node_modules'

source "$HOME"/.zsh_aws

# GNOME Keyring
SSH_AUTH_SOCK=`netstat -xl | grep -o '/run/user/1000/keyring-.*/ssh$'`
[ -z "$SSH_AUTH_SOCK" ] || export SSH_AUTH_SOCK
