#!/bin/sh
PREV=/tmp/waybar_bandwidth_prev
IFACE=wlp0s20f3

rx=$(cat /sys/class/net/$IFACE/statistics/rx_bytes 2>/dev/null || echo 0)
tx=$(cat /sys/class/net/$IFACE/statistics/tx_bytes 2>/dev/null || echo 0)
now=$(date +%s%N)

if [ -f "$PREV" ]; then
    prev_rx=$(awk '{print $1}' "$PREV")
    prev_tx=$(awk '{print $2}' "$PREV")
    prev_time=$(awk '{print $3}' "$PREV")
    down=$(awk -v rx="$rx" -v prx="$prev_rx" -v ct="$now" -v pt="$prev_time" \
        'BEGIN { el=(ct-pt)/1e9; printf "%d", (el>0 && rx>=prx) ? (rx-prx)/el : 0 }')
    up=$(awk -v tx="$tx" -v ptx="$prev_tx" -v ct="$now" -v pt="$prev_time" \
        'BEGIN { el=(ct-pt)/1e9; printf "%d", (el>0 && tx>=ptx) ? (tx-ptx)/el : 0 }')
else
    down=0
    up=0
fi

printf "%s %s %s\n" "$rx" "$tx" "$now" > "$PREV"

fmt() {
    awk -v b="$1" 'BEGIN {
        if      (b >= 1048576) printf "%6.1f M", b/1048576
        else if (b >= 1024)    printf "%6.1f K", b/1024
        else                   printf "%6d B", b
    }'
}

echo "↓$(fmt "$down") ↑$(fmt "$up")"
