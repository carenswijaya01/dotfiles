#!/bin/bash
set -e

CONFIG_DIR="$HOME/.config/gtk-4.0"
ASSETS_LINK="$CONFIG_DIR/assets"

# -------------------------------
# UNINSTALL MODE
# -------------------------------
if [[ "$1" == "--uninstall" ]]; then
  rm -rf "$CONFIG_DIR"
  if command -v flatpak >/dev/null 2>&1; then
    flatpak override --user --nofilesystem=$CONFIG_DIR >/dev/null 2>&1
  fi
  exit 0
fi

# -------------------------------
# APPLY MODE
# -------------------------------

mkdir -p "$CONFIG_DIR"

THEME=$(gsettings get org.gnome.desktop.interface gtk-theme | tr -d "'")

# Resolve theme path
if [ -d "$HOME/.themes/$THEME" ]; then
  THEME_PATH="$HOME/.themes/$THEME"
elif [ -d "/usr/share/themes/$THEME" ]; then
  THEME_PATH="/usr/share/themes/$THEME"
elif [ -d "/usr/local/share/themes/$THEME" ]; then
  THEME_PATH="/usr/local/share/themes/$THEME"
else
  exit 0
fi

GTK4_SOURCE="$THEME_PATH/gtk-4.0"
[ -d "$GTK4_SOURCE" ] || exit 0

# -------------------------------
# gtk.css wrapper (SAFE)
# -------------------------------
cat > "$CONFIG_DIR/gtk.css" <<EOF
@import url("file://$GTK4_SOURCE/gtk.css");
EOF

# Optional dark variant
if [ -f "$GTK4_SOURCE/gtk-dark.css" ]; then
  cat > "$CONFIG_DIR/gtk-dark.css" <<EOF
@import url("file://$GTK4_SOURCE/gtk-dark.css");
EOF
else
  rm -f "$CONFIG_DIR/gtk-dark.css"
fi

# -------------------------------
# Assets symlink (SAFE)
# -------------------------------
if [ -d "$GTK4_SOURCE/assets" ]; then
  ln -sfn "$GTK4_SOURCE/assets" "$ASSETS_LINK"
else
  rm -f "$ASSETS_LINK"
fi

# -------------------------------
# Flatpak override
# -------------------------------
if command -v flatpak >/dev/null 2>&1; then
  flatpak override --user --filesystem=$CONFIG_DIR:ro >/dev/null 2>&1
fi

exit 0
