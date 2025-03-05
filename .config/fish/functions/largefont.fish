# .config/fish/functions/largefont.fish
# Simon Hulse
# simonhulse@protonmail.com
# Last Edited: Wed 05 Mar 2025 03:36:52 PM EST

function largefont
    sed -i 's/size = [0-9]\+\.[0-9]\+/size = 16.0/' ~/.config/alacritty/alacritty.toml
end

