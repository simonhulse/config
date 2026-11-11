#!/bin/sh
# CPU package temp; find the zone by type since zone numbers can change between boots
# (thermal_zone0 is INT3400, a firmware placeholder fixed at 20C)
zone=$(grep -l '^x86_pkg_temp$' /sys/class/thermal/thermal_zone*/type | head -n1)
val=$(awk '{ printf "%d", $1/1000 }' "$(dirname "$zone")/temp")

# scale 30-90C onto 0-100; gradient: gruvbox #b8bb26 -> #fe8019 -> #fb4934
color=$(awk -v v="$val" 'BEGIN {
    pct = (v - 30) / 60 * 100
    if (pct < 0) pct = 0
    if (pct > 100) pct = 100
    t = (pct <= 50) ? pct/50 : (pct-50)/50
    if (pct <= 50) { r=184+t*70; g=187-t*59; b=38-t*13 }
    else           { r=254-t*3;  g=128-t*55; b=25+t*27 }
    printf "#%02x%02x%02x", int(r), int(g), int(b)
}')
echo "<span foreground='${color}'>TEMP: ${val}C</span>"
