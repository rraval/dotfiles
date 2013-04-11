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

# Completion fixes from:
# https://github.com/fschulze/zsh-settings/blob/746924fc589112a33b2c5042701a86af23e78617/completion.zsh
#
# colorise files
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"

# ignore some files during completion
zstyle ':completion:*:(all-|)files' ignored-patterns "(*.pyc|*~)"
# but not for these programs
zstyle ':completion:*:ls:*:(all-|)files' ignored-patterns
zstyle ':completion:*:rm:*:(all-|)files' ignored-patterns

export EDITOR='vim'
export PATH="$HOME/bin:/opt/java/bin:$PATH:/usr/share/git/git-jump:/usr/share/git/subtree"
alias ls='ls --color=auto -F' grep='grep --color=auto'
alias aurget='aurget --deps --noconfirm'
alias logcat='adb logcat | python2 ~/bin/colorlogcat.py'

function gvim_server() {
    gvimid=`xdotool search --limit 1 --all --class --name Gvim`

    if [[ -n "$gvimid" ]]; then
        for file in "$@"; do
            gvim --remote-send ":split `readlink -f $file`<CR>"
        done
        xdotool windowactivate "$gvimid"
    fi
}
alias vim=gvim_server

export TIMEFMT='%U user, %S system, %E elapsed, %P CPU (%X text, %D data, %M max)k
%I inputs, %O outputs (%F major, %R minor) pagefaults, %W swaps'
export NODE_PATH='/usr/lib/node_modules'
export PYTHONDONTWRITEBYTECODE=1

source "$HOME"/.zsh_aws

# GNOME Keyring
SSH_AUTH_SOCK=`netstat -xl | grep -o '/run/user/1000/keyring-.*/ssh$'`
[ -z "$SSH_AUTH_SOCK" ] || export SSH_AUTH_SOCK

# Antigen
source ~/.zsh/antigen/antigen.zsh

antigen-bundle git
antigen-bundle pip
antigen-bundle command-not-found

antigen-bundle zsh-users/zsh-syntax-highlighting
ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets cursor root)

antigen-apply
