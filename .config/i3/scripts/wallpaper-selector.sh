#!/bin/bash

######################
# Wallpaper Selector #
######################

# Idea by: https://github.com/Bromax14/Dotfiles-i3WM-Gruvbox-Minimal

# Wallpaper Selector
WALLPAPER_DIR="$HOME/Documents/dotfiles/wallpapers"

# Check if the folder exists
if [ ! -d "$WALLPAPER_DIR" ]; then
  notify-send -u critical "Wallpaper Selector" "Error: The folder $WALLPAPER_DIR does not exist."
  echo "Error: The folder $WALLPAPER_DIR does not exist."
  exit 1
fi

# Get the list of images
WALLPAPER_LIST=$(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.gif" -o -iname "*.bmp" \) | sort)

if [ -z "$WALLPAPER_LIST" ]; then
  notify-send -u critical "Wallpaper Selector" "No images found in $WALLPAPER_DIR."
  echo "Error: No images found in $WALLPAPER_DIR."
  exit 1
fi

# Save the current wallpaper BEFORE changing it
CURRENT_WALLPAPER=$(grep "feh --bg-scale" $HOME/.config/i3/config | cut -d '"' -f2 2>/dev/null)

# Loop to be able to re-select if you don't like it
while true; do
  # Open Rofi with the wallpapers list
  SELECTED_WALLPAPER=$(
    echo "$WALLPAPER_LIST" \
    | while IFS= read -r f; do
        printf '%s\0icon\x1f%s\n' "$f" "$f"
      done \
    | rofi -dmenu -i -show-icons -p "Wallpapers" \
        -theme-str 'window { location: center; anchor: center; width: 600px; height: 500px; }' \
        -theme-str 'mainbox { padding: 15px; spacing: 10px; }' \
        -theme-str 'listview { columns: 3; lines: 3; spacing: 10px; }' \
        -theme-str 'element { padding: 15px; border-radius: 6px; }' \
        -theme-str 'element-icon { size: 128px; }' \
        -theme-str 'element-text { horizontal-align: 0.5; font: "Adwaita Sans 10"; }' \
        -theme-str 'element selected { background-color: rgba(255,255,255,0.12); }'
  )
  ROFI_EXIT_CODE=$?

  # Check if ESC was pressed (exit 1) or if nothing was selected
  if [ $ROFI_EXIT_CODE -eq 1 ] || [ -z "$SELECTED_WALLPAPER" ]; then
    notify-send "Wallpaper Selector" "Selection cancelled"
    echo "Selection cancelled"
    exit 0
  fi

  # Check if the selected file exists
  if [ -f "$SELECTED_WALLPAPER" ]; then
    # Change the wallpaper temporarily
    feh --bg-scale "$SELECTED_WALLPAPER"
    notify-send "Preview applied" "$(basename "$SELECTED_WALLPAPER")"

    # Ask if you like the wallpaper
    CONFIRM=$(echo -e "Yes\nNo" | rofi \
      -dmenu \
      -p 'Confirm' \
      -mesg 'Are you sure?' \
      -timeout 0 \
      -esc 1)
    CONFIRM_EXIT_CODE=$?

    if [ "$CONFIRM" = "Yes" ] && [ $CONFIRM_EXIT_CODE -eq 0 ]; then
      # Save wallpaper
      I3_CONFIG="$HOME/.config/i3/config"
      sed -i '/exec --no-startup-id feh --bg-scale/d' "$I3_CONFIG"
      echo "exec --no-startup-id feh --bg-scale \"$SELECTED_WALLPAPER\"" >> "$I3_CONFIG"
      notify-send "Wallpaper applied" "$(basename "$SELECTED_WALLPAPER")"
      echo "Wallpaper applied: $SELECTED_WALLPAPER"
      exit 0

    elif [ $CONFIRM_EXIT_CODE -eq 1 ] || [ -z "$CONFIRM" ]; then
      # Restore previous wallpaper when cancelled
      if [ -n "$CURRENT_WALLPAPER" ] && [ -f "$CURRENT_WALLPAPER" ]; then
        feh --bg-scale "$CURRENT_WALLPAPER"
        notify-send "Restored" "You returned to the previous wallpaper"
      fi

    else
      # "No" response → return to previous wallpaper
      if [ -n "$CURRENT_WALLPAPER" ] && [ -f "$CURRENT_WALLPAPER" ]; then
        feh --bg-scale "$CURRENT_WALLPAPER"
        notify-send "Not applied" "The previous wallpaper was restored"
      fi
    fi

  else
    notify-send -u critical "Wallpaper Selector" "The selected file does not exist."
    echo "The selected file does not exist."
  fi
done
