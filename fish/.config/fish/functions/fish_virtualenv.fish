function fish_virtualenv --description 'Write out current virtualenv'
    if set -q VIRTUAL_ENV
        echo -n -s (set_color green) '[' (basename $VIRTUAL_ENV) ']' ' '
    end
end
