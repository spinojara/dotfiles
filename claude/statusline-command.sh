#!/bin/bash
input=$(cat)
cwd=$(echo "$input" | jq -r '.cwd')
dir=$(basename "$cwd")
host=$(hostname -s)
model=$(echo "$input" | jq -r '.model.id')
effort=$(echo "$input" | jq -r '.effort.level')

cache="$HOME/.claude/cache/rate-limits.json"
now=$(date +%s)

read_bucket() {
    local key=$1
    local pct reset
    pct=$(echo "$input" | jq -r ".rate_limits.${key}.used_percentage // empty")
    reset=$(echo "$input" | jq -r ".rate_limits.${key}.resets_at // empty")
    if [ -z "$pct" ] && [ -r "$cache" ]; then
        pct=$(jq -r ".${key}.used_percentage // empty" < "$cache")
        reset=$(jq -r ".${key}.resets_at // empty" < "$cache")
    fi
    if [ -n "$reset" ] && [ "$now" -ge "$reset" ]; then
        pct=0
        reset=""
    fi
    printf '%s\t%s' "$pct" "$reset"
}

IFS=$'\t' read -r five five_reset < <(read_bucket five_hour)
IFS=$'\t' read -r week week_reset < <(read_bucket seven_day)

jq -n \
    --arg fp "$five" --arg fr "$five_reset" \
    --arg wp "$week" --arg wr "$week_reset" \
    '{
        five_hour: ($fp | select(. != "") | {used_percentage: tonumber, resets_at: ($fr | select(. != "") | tonumber)}),
        seven_day: ($wp | select(. != "") | {used_percentage: tonumber, resets_at: ($wr | select(. != "") | tonumber)})
    }' > "$cache" 2>/dev/null

fmt_remaining() {
    local reset=$1
    [ -z "$reset" ] && return
    local secs=$(( reset - now ))
    [ "$secs" -le 0 ] && { printf '0m'; return; }
    local d=$(( secs / 86400 ))
    local h=$(( (secs % 86400) / 3600 ))
    local m=$(( (secs % 3600) / 60 ))
    if [ "$d" -gt 0 ]; then printf '%dd%dh' "$d" "$h"
    elif [ "$h" -gt 0 ]; then printf '%dh%dm' "$h" "$m"
    else printf '%dm' "$m"
    fi
}

limits=""
[ -n "$five" ] && limits="${limits}5h:$(printf '%.0f' "$five")%"
[ -n "$five" ] && [ -n "$five_reset" ] && limits="${limits}($(fmt_remaining "$five_reset"))"
[ -n "$week" ] && limits="${limits} 7d:$(printf '%.0f' "$week")%"
[ -n "$week" ] && [ -n "$week_reset" ] && limits="${limits}($(fmt_remaining "$week_reset"))"
if [ -n "$limits" ]; then
    printf '\033[0;31m%s \033[0;34m%s \033[0;33m%s (%s)\033[0m %s' "$host" "$dir" "$model" "$effort" "$limits"
else
    printf '\033[0;31m%s \033[0;34m%s\033[0m \033[0;33m%s (%s)\033[0m' "$host" "$dir" "$model" "$effort"
fi
