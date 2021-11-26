# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

if [ -d "$HOME/Documents/code/shell/wicked_cool_shell_scripts" ] ; then
    PATH="$HOME/Documents/code/shell/wicked_cool_shell_scripts:$PATH"
fi

if [ -d "$HOME/progs/texlive/2021/bin/x86_64-linux" ] ; then
    PATH="$HOME/progs/texlive/2021/bin/x86_64-linux:$PATH"
fi

if [ -d "$HOME/.local/bin" ] ; then
    PATH="$HOME/.local/bin:$PATH"
fi

if [ -d "$HOME/.cargo/bin" ] ; then
    PATH="$HOME/.cargo/bin:$PATH"
fi

if [ -d "$HOME/progs/bin" ] ; then
    PATH="$HOME/progs/bin:$PATH"
fi

export PATH

if [ -d "$HOME/.cargo/env" ] ; then
    source "$HOME/.cargo/env"
fi


export LS_COLORS="$LS_COLORS:ow=1;34:tw=1;34:"
export CLICOLOR=1

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi
