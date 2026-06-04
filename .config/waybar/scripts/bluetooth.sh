#!/bin/sh
device=$(bluetoothctl devices Connected 2>/dev/null | head -1 | cut -d' ' -f3-)

if [ -z "$device" ]; then
    printf '{"text": ""}\n'
    exit 0
fi

len=$(printf '%s' "$device" | wc -m)
if [ "$len" -ge 6 ]; then
    device="$(printf '%.6s' "$device")…"
fi

printf '{"text": "BT: %s", "class": "connected"}\n' "$device"
