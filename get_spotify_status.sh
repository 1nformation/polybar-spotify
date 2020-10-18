#!/bin/bash

STATUS=$($HOME/.config/polybar/get_playerctl_status.sh)

if [ "$STATUS" = "Stopped" ]; then
    echo ""
    polybar-msg -p "$(pgrep -f "polybar now-playing")" hook pause 3 1>/dev/null 2>&1
    polybar-msg -p "$(pgrep -f "polybar now-playing")" hook prev 2 1>/dev/null 2>&1
    polybar-msg -p "$(pgrep -f "polybar now-playing")" hook next 2 1>/dev/null 2>&1

elif [ "$STATUS" = "Paused"  ]; then
    polybar-msg -p "$(pgrep -f "polybar now-playing")" hook pause 2 1>/dev/null 2>&1
    polybar-msg -p "$(pgrep -f "polybar now-playing")" hook prev 1 1>/dev/null 2>&1
    polybar-msg -p "$(pgrep -f "polybar now-playing")" hook next 1 1>/dev/null 2>&1
    playerctl --player=playerctld metadata --format "  {{ title }} - {{ artist }} "
elif [ "$STATUS" = "No player is running"  ]; then
    echo ""
    polybar-msg -p "$(pgrep -f "polybar now-playing")" hook pause 3 1>/dev/null 2>&1
    polybar-msg -p "$(pgrep -f "polybar now-playing")" hook prev 2 1>/dev/null 2>&1
    polybar-msg -p "$(pgrep -f "polybar now-playing")" hook next 2 1>/dev/null 2>&1
else
    polybar-msg -p "$(pgrep -f "polybar now-playing")" hook pause 1 1>/dev/null 2>&1
    polybar-msg -p "$(pgrep -f "polybar now-playing")" hook prev 1 1>/dev/null 2>&1
    polybar-msg -p "$(pgrep -f "polybar now-playing")" hook next 1 1>/dev/null 2>&1
    playerctl --player=playerctld metadata --format "  {{ title }} - {{ artist }} "
fi