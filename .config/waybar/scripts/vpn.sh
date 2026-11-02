#!/bin/sh
# VPN: <CC> (green) when Proton VPN is connected, VPN: off otherwise.
status=$(protonvpn status 2>/dev/null)

case "$status" in
    *Disconnected*)
        printf '{"text": "VPN: off", "class": "disconnected"}\n'
        ;;
    *Connected*)
        # "Server: NAME in City, Country" -> country name -> 2-letter code
        loc=$(printf '%s\n' "$status" | sed -n 's/^Server: .* in //p' | head -1)
        country=${loc##*, }
        country=${country#via }
        cc=$(python3 -c '
import sys
from proton.vpn.session.servers.country_codes import get_country_code_for_name as g
cc = g(sys.argv[1]) or ""
print({"UK": "GB"}.get(cc, cc))' "$country" 2>/dev/null)
        printf '{"text": "VPN: %s", "class": "connected"}\n' "${cc:-on}"
        ;;
    *)
        printf '{"text": "VPN: ?", "class": "disconnected"}\n'
        ;;
esac
