#!/bin/sh
BAT=/sys/class/power_supply/BAT0
val=$(cat "${BAT}/capacity")
status=$(cat "${BAT}/status")

if [ "$status" = "Charging" ]; then
    echo "<span foreground='#fabd2f'>BAT: ${val}%+</span>"
    exit 0
fi

# invert: low battery = high urgency; gradient: gruvbox #b8bb26 -> #fe8019 -> #fb4934
color=$(awk -v v="$((100 - val))" 'BEGIN {
    t = (v <= 50) ? v/50 : (v-50)/50
    if (v <= 50) { r=184+t*70; g=187-t*59; b=38-t*13 }
    else         { r=254-t*3;  g=128-t*55; b=25+t*27 }
    printf "#%02x%02x%02x", int(r), int(g), int(b)
}')
echo "<span foreground='${color}'>BAT: ${val}%</span>"
