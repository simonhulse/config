# .config/fish/functions/smallfont.fish
# Simon Hulse
# simonhulse@protonmail.com
# Last Edited: Wed 05 Mar 2025 03:36:21 PM EST

function smallfont
    sed -i 's/size = [0-9]\+\.[0-9]\+/size = 12.0/' ~/.config/alacritty/alacritty.toml
end

