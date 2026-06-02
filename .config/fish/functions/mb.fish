function mb
    set cmd 'mvn clean install -DskipTests'
    if test (count $argv) -eq 1
        set cmd "$cmd -pl $argv[1]"
    end
    echo "Running command:
    $cmd"
    echo
    eval $cmd
end

