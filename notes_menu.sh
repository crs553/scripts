#!/bin/sh

# Set your notes directory
NOTES_DIR="$HOME/Documents/notes"

# Use $TERMINAL or fallback to wezterm
TERM="wezterm"

# Set Catppuccin Mocha colors using set -- and "$@"
set -- \
  --fn "JetBrains Mono 12" \
  --nb "#1e1e2e" --nf "#cdd6f4" \
  --tb "#1e1e2e" --tf "#f38ba8" \
  --hb "#313244" --hf "#f9e2af" \
  --ab "#1e1e2e" --af "#cdd6f4" \
  -i 

# Show bemenu
choice=$(printf "Open Notes\nSync Notes\nSearch Notes" | bemenu "$@")

case "$choice" in
    "Open Notes")
        "$TERM" -e nvim "$NOTES_DIR"
        ;;
    "Sync Notes")
        cd "$NOTES_DIR" || exit
        git pull
        git add .
        git commit -m "sync: update notes"
        git push
        notify-send "Notes Synced"
        ;;
    "Search Notes")
        selected=$(rg --files --glob '*.md' "$NOTES_DIR" | bemenu "$@")
        [ -n "$selected" ] && "$TERM" start -- nvim "$selected"
    ;;
    *)
        exit 0
        ;;
esac

