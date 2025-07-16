#!/bin/sh

NOTES_DIR="$HOME/Documents/notes"
TERM="wezterm"

menu_items=$(cat <<EOF
Open Notes
Sync Notes
EOF
)
notes_list=$(rg --files "$NOTES_DIR" | sed "s|$NOTES_DIR/||")
full_menu=$(printf "%s\n%s" "$menu_items" "$notes_list")

# Launch wofi to get the selection
selected=$(printf "%s\n" "$full_menu" | wofi --dmenu --prompt "Notes" --insensitive --no-custom --style ~/.config/wofi/src/mocha/style.css)

case "$selected" in
  "Open Notes")
    "$TERM" start -- nvim "$NOTES_DIR"
    ;;
  "Sync Notes")
    cd "$NOTES_DIR" || exit
    git pull
    git add .
    git commit -m "sync: update notes"
    git push
    notify-send "Notes Synced"
    ;;
  *)
    [ -n "$selected" ] && "$TERM" start -- nvim "$NOTES_DIR/$selected"
    ;;
esac

