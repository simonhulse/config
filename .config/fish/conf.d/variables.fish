# .config/fish/conf.d/variables.fish
# Simon Hulse
# simonhulse@protonmail.com
# Last Edited: Wed 02 Oct 2024 09:04:12 PM EDT

# >>>> VARIABLES >>>>

set daisy 'simonhulse@10.16.7.230'
set orin 'simonhulse@10.20.0.43'

# <<<< VARIABLES <<<<

# >>>> ABBREVIATIONS >>>>

# >>> Misc >>>
abbr --add ud 'sudo apt-get update && sudo apt-get upgrade'
abbr --add q 'exit'
abbr --add c 'clear'
abbr --add cs 'clear; ls -lh'
abbr --add o 'xdg-open'
abbr --add h 'history'

# >>> Vim: use vim-gtk3 if it exists, for clipboard support >>>
if command -sq vim.gtk3
    abbr --add v 'vim.gtk3'
    abbr --add vi 'vim.gtk3'
else
    abbr --add v 'vim'
    abbr --add vi 'vim'
end
# <<< Vim <<<

# >>> Replacing ls with exa >>>
if command -sq eza
    abbr --add ls 'eza --icons=auto'
    abbr --add ll 'eza -l --icons=auto --git'
    abbr --add la 'eza -la --icons=auto --git'
    abbr --add lh 'eza -lh --icons=auto --git'
    abbr --add tree 'eza --tree --icons=auto'
else
    abbr --add la 'ls -la'
    abbr --add ll 'ls -l'
    abbr --add lh 'ls -lh'
end
# <<< Replacing ls with exa <<<

# >>> Naviagtion >>>
abbr --add .. 'cd ..'
abbr --add ... 'cd ../..'
abbr --add .... 'cd ../../..'
abbr --add ..... 'cd ../../../..'
abbr --add root 'cd /'
# <<< Naviagtion <<<

# >>> Git >>>
abbr --add gi 'git init'
abbr --add gs 'git status'
abbr --add gco 'git commit'
abbr --add gcl 'git clone'
abbr --add gl 'git log --oneline --decorate --graph --all'
abbr --add groot 'cd (git rev-parse --show-toplevel)'
# <<< Git <<<

# >>> Python >>>
abbr --add sv 'source .venv/bin/activate.fish'
abbr --add pup 'pip install --upgrade pip'
# <<< Python <<<

# >>> Network >>>
abbr --add daisy "sshpass -f ~/.asrcpwd ssh -Y $exxact"
abbr --add orin "sshpass -f ~/.asrcpwd ssh -Y $orin"
# <<< Network <<<

# <<<< ABBREVIATIONS <<<<
