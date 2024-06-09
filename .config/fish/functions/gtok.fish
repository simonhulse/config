function gtok
    if test -f ~/.ghtoken
        cat ~/.ghtoken | xclip -selection clipboard
    else
        echo "File `~/.ghtoken` doesn't exist"
    end
end
