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

if [ -d "$HOME/.cargo/env" ] ; then
    . "$HOME/.cargo/env"  # Adds $HOME/.cargo/bin to path
fi

export PATH
export LS_COLORS="$LS_COLORS:ow=1;34:tw=1;34:"
export CLICOLOR=1

# Determine OS platform
UNAME=$(uname | tr "[:upper:]" "[:lower:]")
# If Linux, try to determine specific distribution
if [ "$UNAME" == "linux" ]; then
    # If available, use LSB to identify distribution
    if [ -f /etc/lsb-release -o -d /etc/lsb-release.d ]; then
        export DISTRO=$(lsb_release -i | cut -d: -f2 | sed s/'^\t'//)
    # Otherwise, use release info file
    else
        export DISTRO=$(ls -d /etc/[A-Za-z]*[_-][rv]e[lr]* | grep -v "lsb" | cut -d'/' -f3 | cut -d'-' -f1 | cut -d'_' -f1)
    fi
fi
# For everything else (or if above failed), just use generic identifier
[ "$DISTRO" == "" ] && export DISTRO=$UNAME
unset UNAME

if [ "$DISTRO" == "Ubuntu" ]; then
    # Brave
    dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/command "'brave-browser'"
    dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/binding "'<Ctrl><Alt>b'"
    dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom0/name "'brave-browser'"

    # Evince
    dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/command "'evince'"
    dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/binding "'<Ctrl><Alt>e'"
    dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom1/name "'evince'"

    # Inkscape
    dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/command "'inkscape'"
    dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/binding "'<Ctrl><Alt>i'"
    dconf write /org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/custom2/name "'inkscape'"
fi

# If running bash, include .bashrc if it exists
if [ -n "$BASH_VERSION" ]; then
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi
