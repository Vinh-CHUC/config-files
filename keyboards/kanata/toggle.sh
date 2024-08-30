#!/usr/bin/bash
exec > /tmp/kanata-toggle.log 2>&1

KANATA_PID=$(pgrep kanata)

if [ -z "$KANATA_PID" ]; then
    echo "Kanata not running, attempting to start it"
    nohup kanata -c "/home/$USER/.config/kanata/pocket-reform.kbd" > /dev/null &
    sleep 3
    echo "Kanata started"
else
    echo "Kanata running, attempting to kill it"
    kill "$KANATA_PID"
    echo "Kanata stopped"
fi
