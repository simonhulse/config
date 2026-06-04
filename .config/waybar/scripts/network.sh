#!/bin/sh
IFACE=wlp0s20f3
ssid=$(iw dev "$IFACE" link 2>/dev/null | awk '/SSID:/ {$1=""; sub(/^ /, ""); print}')

if [ -z "$ssid" ]; then
    printf '{"text": "NET: off", "class": "disconnected"}\n'
    exit 0
fi

len=$(printf '%s' "$ssid" | wc -m)
if [ "$len" -ge 6 ]; then
    ssid="$(printf '%.6s' "$ssid")…"
fi

printf '{"text": "NET: %s"}\n' "$ssid"
