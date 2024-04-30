#!/usr/bin/env bash

umask 022

# Hodge-podge of various paths that might exist and contain executables
paths=(
    "/usr/local/texlive/2023/bin/x86_64-linux"
    "$HOME/Documents/code/shell/wicked_cool_shell_scripts"
    "$HOME/progs/texlive/2021/bin/x86_64-linux"
    "$HOME/progs/apache-maven-3.9.5/bin"
    "$HOME/.local/bin"
    "$HOME/.local/bin/x86_64-linux"
    "$HOME/progs/bin"
    "$HOME/utils"
)

for path in ${paths[*]}
    do
        if [ -d $path ] ; then
            PATH="$path:$PATH"
        fi
    done

# find nmrfx
if [ -f ~/.find-nmrfx ]; then
    NMRFXA_PATH=$(~/.find-nmrfx)
    if [ $? -eq 0 ]; then
        PATH="$NMRFXA_PATH:$PATH"
    fi
fi

if [ -d "$HOME/.cargo/env" ] ; then
    . "$HOME/.cargo/env"  # Adds $HOME/.cargo/bin to path
fi

export PATH
export LS_COLORS="$LS_COLORS:ow=1;34:tw=1;34:"
export CLICOLOR=1
