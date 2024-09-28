# .config/fish/functions/gtok.fish
# Simon Hulse
# simonhulse@protonmail.com
# Last Edited: Wed 25 Sep 2024 11:07:08 PM EDT

function gtok
    if test -f ~/.ghtoken
        cat ~/.ghtoken | xclip -selection clipboard &> /dev/null
    else
        echo "File `~/.ghtoken` doesn't exist"
    end
end
