#abbreviations.fish
#Simon Hulse
#simonhulse@protonmail.com
#Last Edited: Mon 10 Jun 2024 10:06:22 PM EDT

# FISH ABBREVIATIONS

# Misc
abbr --add ud 'sudo apt-get update && sudo apt-get upgrade'
abbr --add q 'exit'
abbr --add c 'clear'
abbr --add cs 'clear; ls -lh'
abbr --add o 'xdg-open'
abbr --add h 'history'
abbr --add v 'vim'
abbr --add vi 'vim'

# Replacing ls with exa
if command -sq exa
    abbr --add ls 'exa'
    abbr --add la 'exa -la'
    abbr --add lh 'exa -lh'
    abbr --add tree 'exa --tree'
else
    abbr --add la 'ls -la'
    abbr --add lh 'ls -lh'
end

# Naviagtion
abbr --add .. 'cd ..'
abbr --add ... 'cd ../..'
abbr --add .... 'cd ../../..'
abbr --add ..... 'cd ../../../..'
abbr --add root 'cd /'

# Git
abbr --add gi 'git init'
abbr --add gs 'git status'
abbr --add gco 'git commit'
abbr --add gcl 'git clone'
abbr --add gl 'git log --oneline --decorate --graph --all'
abbr --add groot 'cd $(git rev-parse --show-toplevel)'

# Python
abbr --add sv 'source .venv/bin/activate.fish'
abbr --add pup 'pip install --upgrade pip'
