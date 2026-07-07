#!/bin/sh
# Minimal audio output (sink) switcher — a lighter alternative to pavucontrol.
# Lists sinks via wpctl (pipewire's native CLI), lets you pick one with wofi,
# and makes it the default via `wpctl set-default`.

choice=$(wpctl status \
    | awk '/Sinks:/{f=1; next} /Sink endpoints:/{f=0} f' \
    | grep -E '[0-9]+\.' \
    | sed -E 's/^[^*0-9]*(\*)?[^0-9]*([0-9]+)\.\s*([^[]*[^[:space:]])\s*\[vol.*/\2: \3\1/' \
    | sed -E 's/\*$/ (current)/' \
    | wofi --dmenu -p 'Audio output' -l top_left)
# wpctl status: dump the full pipewire object tree (sinks, sources, streams, ...)
# awk: keep only lines between "Sinks:" and the next "Sink endpoints:" section
# grep: drop section headers/blank lines, keeping only numbered sink entries
# sed 1: reshape "│  *   67. Name [vol: 0.91]" -> "67: Name*" (capture the leading
#        "*" that marks the current default, and the id/name, drop the vol suffix)
# sed 2: turn that trailing "*" (if present) into a readable " (current)" suffix
# wofi: show the list, let the user pick one line interactively

[ -z "$choice" ] && exit 0  # user hit Escape / closed wofi without picking

id="${choice%%:*}"  # everything before the first ":" is the wpctl object id
wpctl set-default "$id"
