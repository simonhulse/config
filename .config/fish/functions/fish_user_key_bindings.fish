#fish_user_key_bindings.fish
#Simon Hulse
#simonhulse@protonmail.com
#Last Edited: Mon 10 Jun 2024 10:01:36 PM EDT

function fish_user_key_bindings
    fish_vi_key_bindings

    # `jk` to escape insert-mode
    bind -M insert -m default jk backward-char force-repaint

    # Still allow `<CTRL>-F` and `<ALT>-F` for autocompletion
    for mode in insert default visual
        bind -M $mode \cf forward-char
        bind -M $mode \ef forward-word
    end
end

