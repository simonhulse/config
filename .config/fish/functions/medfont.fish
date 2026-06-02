# .config/fish/functions/medfont.fish
# Simon Hulse
# simonhulse@protonmail.com
# Last Edited: Wed 05 Mar 2025 03:36:41 PM EST

function medfont
    sed -i 's/font_size [0-9]\+\.[0-9]\+/font_size 14.0/' ~/.config/kitty/kitty.conf
end

