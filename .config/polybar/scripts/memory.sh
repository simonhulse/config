#!/bin/sh
val=$(free | awk '/^Mem:/ { printf "%d", $3*100/$2 }')

# gradient: gruvbox #b8bb26 -> #fe8019 -> #fb4934
color=$(awk -v v="$val" 'BEGIN {
    t = (v <= 50) ? v/50 : (v-50)/50
    if (v <= 50) { r=184+t*70; g=187-t*59; b=38-t*13 }
    else         { r=254-t*3;  g=128-t*55; b=25+t*27 }
    printf "#%02x%02x%02x", int(r), int(g), int(b)
}')
echo "%{F${color}}RAM: ${val}%%{F-}"
