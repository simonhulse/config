#!/bin/sh
# Three world clocks; the one matching the system timezone is bold.
local_tz=$(timedatectl show -p Timezone --value 2>/dev/null)

out=""
for entry in "SG:Asia/Singapore" "LN:Europe/London" "NY:America/New_York"; do
    label=${entry%%:*}
    tz=${entry#*:}
    t=$(TZ="$tz" date +"%Y-%m-%d %H:%M")
    if [ "$tz" = "$local_tz" ]; then
        seg="<b>${label} ${t}</b>"
    else
        seg="<span font_weight='normal'>${label} ${t}</span>"
    fi
    out="${out:+$out  |  }${seg}"
done
echo "$out"
