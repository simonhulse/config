function asrc-fetch
    set signature "asrc-fetch (daisy|orin) src [dst]"
    if test (count $argv) -lt 2 -o (count $argv) -gt 3
        echo $signature
        echo "2 or 3 arguments are required"
        return 1
    end

    if not contains $argv[1] daisy orin
        echo $signature
        echo "First argument must be `daisy` or `orin`."
        return 1
    else
        set varname (string upper $argv[1])
        set host $$varname
    end

    if test (count $argv) -eq 2
        set src $argv[2]
        set dst "$PWD/"
    else
        set src $argv[2]
        set dst $argv[3]
    end
    set cmd "sshpass -f ~/.asrcpwd rsync -arv $host:$src $dst"
    echo -e "Running the following command:\n$cmd"
    eval $cmd
end
