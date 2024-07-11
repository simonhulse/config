function asrc-send
    set signature "asrc-send (exxact|orin) src [dst]"
    if test (count $argv) -lt 2 -o (count $argv) -gt 3
        echo $signature
        echo "2 or 3 arguments are required"
        return 1
    end

    if not contains $argv[1] exxact orin
        echo $signature
        echo "First argument must be `exxact` or `orin`."
    else
        set host $$argv[1]
    end

    if test (count $argv) -eq 2
        set src $argv[2]
        set dst ""
    else
        set src $argv[2]
        set dst $argv[3]
    end
    set cmd "sshpass -f ~/.asrcpwd rsync -arv $src $host:$dst"
    echo -e "Running the following command:\n$cmd"
    eval $cmd
end
