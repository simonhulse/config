#!/bin/sh
PREV=/tmp/polybar_cpu_prev

curr_raw=$(grep '^cpu ' /proc/stat)
curr_idle=$(echo "$curr_raw" | awk '{print $5}')
curr_total=$(echo "$curr_raw" | awk '{print $2+$3+$4+$5+$6+$7+$8}')

if [ -f "$PREV" ]; then
    prev_idle=$(awk '{print $1}' "$PREV")
    prev_total=$(awk '{print $2}' "$PREV")
    val=$(awk -v ci="$curr_idle" -v ct="$curr_total" \
              -v pi="$prev_idle" -v pt="$prev_total" \
        'BEGIN { dt=ct-pt; printf "%d", (dt>0) ? (1-(ci-pi)/dt)*100 : 0 }')
else
    val=0
fi
printf "%s %s\n" "$curr_idle" "$curr_total" > "$PREV"

# gradient: gruvbox #b8bb26 -> #fe8019 -> #fb4934
color=$(awk -v v="$val" 'BEGIN {
    t = (v <= 50) ? v/50 : (v-50)/50
    if (v <= 50) { r=184+t*70; g=187-t*59; b=38-t*13 }
    else         { r=254-t*3;  g=128-t*55; b=25+t*27 }
    printf "#%02x%02x%02x", int(r), int(g), int(b)
}')
echo "%{F${color}}CPU: ${val}%%{F-}"
