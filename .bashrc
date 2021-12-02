# Source Ubuntu's default .bashrc
# I'm mainly keeping this here as I don't really know how
# to set up colors on gnome-terminal, and by sourcing this,
# it does it "out of the box"
if [ -f /etc/skel/.bashrc ] ; then
    . /etc/skel/.bashrc
fi

# Shorthands
alias q="exit"
alias c="clear"
alias cs="clear;ll"
alias o="xdg-open"
alias h="history"

# ls: If `exa` exists, replace ls with this.
if [ $(which exa 2>&1 >/dev/null; echo $?) = 0 ] ; then
    alias l="exa"
    alias ls="exa"
    alias sl="exa"
    alias ll="exa --long"
    alias la="exa --long --all"
else
    alias l="ls"
    alias sl="ls"
    alias ll="ls -l"
    alias la="ls -a"
fi

# Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias home="cd $HOME"
alias root="cd /"

# Git commands
alias gi="git init"
alias gs="git status"
alias gcom="git commit -m"
alias gclo="git clone"
alias gl="git log --oneline --decorate --graph --all"
alias groot='cd $(git rev-parse --show-toplevel)'

if [ -x "$(command -v xclip)" ] ; then
    alias xclip="xclip -selection clipboard"
fi

# Misc stuff
alias grep='grep --color=auto'
# https://www.homeonrails.com/2016/05/truecolor-in-gnome-terminal-tmux-and-neovim/
alias tmux="env TERM=xterm-256color tmux"
alias vi='vim'

# Oxford Chemistry aliases
alias ciscoconnect="/opt/cisco/anyconnect/bin/vpn -s connect vpn.ox.ac.uk"
alias mfgroup="sudo mount -t cifs -o user=mfgroup,vers=3\.0 //chem.ox.ac.uk/Research/ /media/samba"
alias chemdata="sudo mount -t cifs -o user=mfgroup,vers=3\.0 //chem.ox.ac.uk/srf /media/samba"

# DPhil stuff
if [ -d "$HOME/Documents/DPhil" ] ; then
    alias dphil="cd $HOME/Documents/DPhil"

    if [ -d "$HOME/Documents/DPhil/projects/spectral_estimation/NMR-EsPy" ] ; then
        NMRESPYPATH="$HOME/Documents/DPhil/projects/spectral_estimation/NMR-EsPy"
        alias espy="cd $NMRESPYPATH"
        if [ -d "$NMRESPYPATH/.venv" ] ; then
            alias espysource="source $NMRESPYPATH/.venv/bin/activate"
            alias espybuilddocs="espysource && cd $NMRESPYPATH/docs && sphinx-build -b html . _build/html && cd -"
            alias espyviewdocs="o $NMRESPYPATH/docs/_build/html/content/index.html"
        fi
    fi
    if [ -d "$HOME/Documents/DPhil/journal" ] ; then
        JOURNALPATH="$HOME/Documents/DPhil/journal"
        # TODO needs fixing
        function build_journal {
            cd $JOURNALPATH
            source .venv/bin/activate
            sphinx-build -b html . _build
            cd -
        }
        function view_journal {
            xdg-open $JOURNALPATH/_build/index.html &
        }
    fi
fi

# Prevent bash from escaping $ during tab completion
shopt -s direxpand

# --- PS1 showing git status ------------------------------------------------
# get current status of git repo
function parse_git_branch {
  STATUS="$(git status 2> /dev/null)"
  if [[ $? -ne 0 ]]; then return; else printf " ["; fi
  if echo ${STATUS} | grep -c "renamed:"         &> /dev/null; then printf ">"; else printf ""; fi
  if echo ${STATUS} | grep -c "branch is ahead:" &> /dev/null; then printf "!"; else printf ""; fi
  if echo ${STATUS} | grep -c "new file::"       &> /dev/null; then printf "+"; else printf ""; fi
  if echo ${STATUS} | grep -c "Untracked files:" &> /dev/null; then printf "?"; else printf ""; fi
  if echo ${STATUS} | grep -c "modified:"        &> /dev/null; then printf "*"; else printf ""; fi
  if echo ${STATUS} | grep -c "deleted:"         &> /dev/null; then printf "-"; else printf ""; fi
  printf "]"
}

export PS1="\u@\h:\w\$(parse_git_branch)$ "

# Silly welcome using cowsay
COWS=(/usr/share/cowsay/cows/*)
RAND_COW=$(($RANDOM % $( ls /usr/share/cowsay/cows/*.cow | wc -l )))
echo Hello, Simon | cowsay -f ${COWS[$RAND_COW]}
