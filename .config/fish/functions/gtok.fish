function gtok
    if test -f ~/.ghtoken
        cat ~/.ghtoken | xclip -selection clipboard &> /dev/null
    else
        echo "File `~/.ghtoken` doesn't exist"
    end
end
