# .config/fish/functions/mb.fish
# Simon Hulse
# simonhulse@protonmail.com
# Last Edited: Mon 23 Sep 2024 11:37:17 AM EDT

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

