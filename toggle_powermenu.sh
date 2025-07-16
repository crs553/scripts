#!/bin/sh

if pgrep -x wofi > /dev/null; then
  pkill wofi
else
  "$HOME/scripts/powermenu.sh"
fi

