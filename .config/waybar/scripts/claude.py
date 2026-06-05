#!/usr/bin/env python3
"""Waybar module: Claude Code 5-hour usage utilization from Anthropic API."""
import json, os, subprocess, sys, time
from datetime import datetime, timezone
from pathlib import Path

CACHE_FILE = "/tmp/claude_usage_cache.json"
CACHE_TTL = 30  # seconds between API calls


def read_cache():
    try:
        d = json.loads(Path(CACHE_FILE).read_text())
        if time.time() - d["ts"] < CACHE_TTL:
            return d
    except Exception:
        pass
    return None


def write_cache(data):
    data["ts"] = time.time()
    Path(CACHE_FILE).write_text(json.dumps(data))


def fetch_utilization():
    creds = json.loads(Path.home().joinpath(".claude/.credentials.json").read_text())
    token = creds["claudeAiOauth"]["accessToken"]
    result = subprocess.run(
        [
            "curl", "-si", "-X", "POST",
            "https://api.anthropic.com/v1/messages",
            "-H", f"Authorization: Bearer {token}",
            "-H", "Content-Type: application/json",
            "-H", "anthropic-version: 2023-06-01",
            "-d", '{"model":"claude-haiku-4-5-20251001","max_tokens":1,"messages":[{"role":"user","content":"hi"}]}',
        ],
        capture_output=True, text=True, timeout=15
    )
    headers = {}
    for line in result.stdout.splitlines():
        if ":" in line and line.startswith("anthropic-ratelimit"):
            k, _, v = line.partition(":")
            headers[k.strip().lower()] = v.strip()

    utilization = float(headers.get("anthropic-ratelimit-unified-5h-utilization", -1))
    reset_ts = int(headers.get("anthropic-ratelimit-unified-5h-reset", 0))
    status = headers.get("anthropic-ratelimit-unified-5h-status", "unknown")
    return {"utilization": utilization, "reset_ts": reset_ts, "status": status}


def find_node_bin():
    nvm_alias_dir = Path.home() / ".nvm" / "alias"
    alias_file = nvm_alias_dir / "default"
    for _ in range(5):
        if not alias_file.exists():
            break
        alias = alias_file.read_text().strip()
        if alias.startswith("v"):
            bin_dir = Path.home() / ".nvm" / "versions" / "node" / alias / "bin"
            if bin_dir.exists():
                return bin_dir
            break
        alias_file = nvm_alias_dir / alias
    return None


def fetch_cost():
    node_bin = find_node_bin()
    env = os.environ.copy()
    if node_bin:
        env["PATH"] = str(node_bin) + ":" + env.get("PATH", "")
    ccusage = str(node_bin / "ccusage") if node_bin and (node_bin / "ccusage").exists() else "ccusage"
    result = subprocess.run(
        [ccusage, "blocks", "--active", "--json", "--offline"],
        capture_output=True, text=True, timeout=10, env=env
    )
    data = json.loads(result.stdout)
    blocks = data.get("blocks", [])
    if not blocks:
        return None
    b = blocks[0]
    return {
        "cost": b["costUSD"],
        "proj_cost": b.get("projection", {}).get("totalCost", 0),
        "burn_rate": b.get("burnRate", {}).get("costPerHour", 0),
        "start": b["startTime"],
        "end": b["endTime"],
    }


def usage_color(pct):
    t = min(1.0, max(0.0, pct))
    if t <= 0.5:
        s = t * 2
        r, g, b = int(184 + s * 66), int(187 + s * 2), int(38 + s * 9)
    else:
        s = (t - 0.5) * 2
        r, g, b = int(250 + s * 1), int(189 - s * 116), int(47 + s * 5)
    return f"#{r:02x}{g:02x}{b:02x}"


def fmt_remaining(remaining_m):
    if remaining_m >= 60:
        return f"{remaining_m // 60}h{remaining_m % 60:02d}m"
    return f"{remaining_m}m"


def main():
    err = f"CLAUDE: <span foreground='#fb4934'>?</span>"
    try:
        cache = read_cache()
        if cache:
            usage = cache
        else:
            usage = fetch_utilization()
            write_cache(usage)
    except Exception as e:
        print(json.dumps({"text": err, "tooltip": str(e)}))
        return

    pct = usage["utilization"]
    if pct < 0:
        print(json.dumps({"text": err, "tooltip": "Could not read utilization"}))
        return

    reset_dt = datetime.fromtimestamp(usage["reset_ts"], tz=timezone.utc).astimezone()
    remaining_m = max(0, int((reset_dt.timestamp() - time.time()) / 60))
    color = usage_color(pct)
    pct_int = int(pct * 100)

    text = f"CLAUDE: <span foreground='{color}'>{pct_int}%</span> {fmt_remaining(remaining_m)}"

    tooltip_lines = [
        f"5h utilization: {pct_int}%",
        f"Resets at: {reset_dt.strftime('%H:%M')}  ({fmt_remaining(remaining_m)} remaining)",
    ]
    try:
        cost_data = fetch_cost()
        if cost_data:
            tooltip_lines += [
                f"Spent: ${cost_data['cost']:.4f}  |  Projected: ${cost_data['proj_cost']:.2f}",
                f"Burn rate: ${cost_data['burn_rate']:.2f}/hr",
            ]
    except Exception:
        pass

    print(json.dumps({"text": text, "tooltip": "\n".join(tooltip_lines)}))


main()
