# .config/fish/functions/medfont.fish
# Simon Hulse
# simonhulse@protonmail.com
# Last Edited: Wed 05 Mar 2025 03:36:41 PM EST

function medfont
    sed -i 's/size = [0-9]\+\.[0-9]\+/size = 14.0/' ~/.config/alacritty/alacritty.toml
end

