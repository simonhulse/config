function configure_path
    set -l possible_paths \
        "$HOME/.local/bin" \
        "$HOME/.local/bin/x86_64-linux" \
        "$HOME/progs/bin" \
        "$HOME/utils" \

    for possible_path in $possible_paths
        if [ -d $possible_path ]
           set PATH $possible_path $PATH
        end
    end

    add_texlive_to_path
end
