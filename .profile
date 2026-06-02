#!/usr/bin/env bash


umask 022

for path in "$HOME/.local/bin" "$HOME/.local/bin/x86_64-linux"
    do
        if [ -d "$path" ] ; then
            PATH="$path:$PATH"
        fi
    done

if [ -f "$HOME/.cargo/env" ] ; then
    . "$HOME/.cargo/env"
fi

export PATH
export LS_COLORS="$LS_COLORS:ow=1;34:tw=1;34:"
export CLICOLOR=1
