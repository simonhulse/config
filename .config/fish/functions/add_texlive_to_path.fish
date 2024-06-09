function add_texlive_to_path
    set texlive_installs $(find /usr/local/ -regextype posix-extended -regex "/usr/local/texlive/[0-9]{4}/bin/x86_64-linux")
    set n_installs $(count $texlive_installs)
    if [ $n_installs -gt 0 ]
        set PATH $texlive_installs[-1] $PATH
    end
end
