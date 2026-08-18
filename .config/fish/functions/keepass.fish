function keepass
    set -l file ~/.keepass
    set -l secs 10

    if not test -r $file
        echo "keepass: $file missing or unreadable" >&2
        return 1
    end

    wl-copy --trim-newline < $file
    fish -c "sleep $secs; wl-copy --clear" > /dev/null 2>&1 &
    disown
    echo "copied - clears in $secs"s
end
