# .config/fish/functions/largefont.fish
# Simon Hulse
# simonhulse@protonmail.com
# Last Edited: Wed 05 Mar 2025 03:36:52 PM EST

function largefont
    sed -i 's/font_size [0-9]\+\.[0-9]\+/font_size 16.0/' ~/.config/kitty/kitty.conf
end

