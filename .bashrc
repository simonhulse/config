# Source Ubuntu's default .bashrc
# I'm mainly keeping this here as I don't really know how
# to set up colors on gnome-terminal, and by sourcing this,
# it does it "out of the box"
if [[ -f /etc/skel/.bashrc ]] ; then
    . /etc/skel/.bashrc
fi

# Shorthands
alias q="exit"
alias c="clear"
alias cs="clear;ll"
alias o="xdg-open"
alias h="history"

# ls: If `exa` exists, replace ls with this.
if command -v exa >/dev/null 2>&1; then
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

if command -v xclip >/dev/null 2>&1; then
    alias xclip="xclip -selection clipboard"
    alias cppwd="pwd | xclip -selection clipboard"
fi

alias ud="sudo apt-get update && sudo apt-get upgrade"

# Navigation
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias root="cd /"

alias grep='grep --color=auto'

# Git commands
alias gi="git init"
alias gs="git status"
alias gcom="git commit -m"
alias gcoma="git commit --amend"
alias gclo="git clone"
alias gl="git log --oneline --decorate --graph --all"
alias gtok="cat ~/.ghtoken | xclip -selection clipboard"
alias groot='cd $(git rev-parse --show-toplevel)'

# Volume control
if [[ -x "$(command -v amixer)" ]] ; then
    alias volup="amixer sset Master 10%+"
    alias voldown="amixer sset Master 10%-"
    alias voltoggle="amixer sset Master toggle"
alias gcom="git commit -m"
fi


# Vim
alias v='vim'
alias vi='vim'
set -o vi

# Python
alias sv="source .venv/bin/activate"
alias pup="pip install --upgrade pip"

# Re-run previous command using sudo
alias pls='sudo "$BASH" -c "$(history -p !!)"'

# Prevent bash from escaping $ during tab completion
shopt -s direxpand

# PS1 showing git status
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

# Oxford Chemistry network
alias belladonna="ssh -X jesu2901@belladonna.chem.ox.ac.uk"
alias parsley="ssh -X jesu2901@parsley.chem.ox.ac.uk"
alias ciscoconnect="/opt/cisco/anyconnect/bin/vpn -s connect vpn.ox.ac.uk"
alias mfgroup="sudo mount -t cifs -o user=mfgroup,vers=3\.0 //chem.ox.ac.uk/Research/ /media/samba"
alias chemdata="sudo mount -t cifs -o user=mfgroup,vers=3\.0 //chem.ox.ac.uk/srf /media/samba"

# DPhil
if [[ -d "$HOME/Documents/DPhil" ]] ; then
    alias dphil="cd $HOME/Documents/DPhil"
    if [[ -d "$HOME/Documents/DPhil/projects/NMR-EsPy" ]] ; then
        NMRESPYPATH="$HOME/Documents/DPhil/projects/NMR-EsPy"
        alias espy="cd $NMRESPYPATH"
        alias espyvenv="cd $NMRESPYPATH && rm -rf .venv; python3.9 -m venv .venv && source .venv/bin/activate && pip install --upgrade pip && pip install -e .[dev,docs] && cd -"
        alias espysource="source $NMRESPYPATH/.venv/bin/activate"
        alias espybuilddocs="espysource && cd $NMRESPYPATH/docs && ./builddocs.sh && cd -"
        alias espyviewhtml="sensible-browser $NMRESPYPATH/docs/_build/html/index.html"
        alias espyviewpdf="evince $NMRESPYPATH/docs/_build/latex/nmr-espy.pdf"
    fi
fi

# ASRC
alias spasrc="sshpass -f ~/.asrcpwd"
alias sshasrc="sshpass -f ~/.asrcpwd ssh -Y simonhulse@10.16.7.230"
alias vpnasrc="sudo dpkg -i ~/Documents/CUNY/admin/IT/GlobalProtect/GlobalProtect_UI_deb-5.2.6.0-18.deb"

# Silly welcome using cowsay
if [[ -x "$(command -v cowsay)" ]] ; then
    cowsay "Hello, Simon"
fi
