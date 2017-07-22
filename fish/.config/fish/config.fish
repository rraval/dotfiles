set -x EDITOR vim
set -x PATH $HOME/.local/bin $HOME/.local/android-sdk/platform-tools $PATH
set -x GCC_COLORS 'error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

set -x TIMEFMT '\n\n%U user, %S system, %E elapsed, %P CPU (%X text, %D data, %M max)k\n%I inputs, %O outputs (%F major, %R minor) pagefaults, %W swaps'
set -x PYTHONDONTWRITEBYTECODE 1

set __fish_prompt_root      (set_color red)
set __fish_prompt_user      (set_color yellow)
set __fish_prompt_host      (set_color white)

set __fish_prompt_cwd       (set_color yellow)
set __fish_prompt_normal    (set_color white)

set __fish_git_prompt_show_informative_status   y
set __fish_git_prompt_showdirtystate            y
set __fish_git_prompt_showstashstate            y
set __fish_git_prompt_showuntrackedfiles        y
set __fish_git_prompt_showupstream              auto
set __fish_git_prompt_showcolorhints            y

set __fish_git_prompt_color_prefix  yellow
set __fish_git_prompt_color_suffix  yellow

keychain -Q --quiet
. ~/.keychain/(hostname)-fish{,-gpg}
