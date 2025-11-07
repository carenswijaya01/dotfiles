#!/usr/bin/env bash
#
# Additional apps installer script
# by Carens — 2025
#

set -e

# --- Colours ---
GREEN="\033[1;32m"
YELLOW="\033[1;33m"
CYAN="\033[1;36m"
RESET="\033[0m"

APP_DIR="$HOME/Apps"
DESKTOP_DIR="$HOME/.local/share/applications"
mkdir -p "$APP_DIR" "$DESKTOP_DIR"

echo -e "${CYAN}>>> Updating package lists...${RESET}"
sudo apt update

# --- APT / Repo installable apps ---
echo -e "${CYAN}>>> Installing apps via apt/repo...${RESET}"
sudo apt install -y \
  dbeaver-ce \
  thunderbird \
  zoom \
  anydesk \
  rustdesk

# --- VS Code setup ---
echo -e "${CYAN}>>> Installing Visual Studio Code...${RESET}"
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /etc/apt/trusted.gpg.d/
sudo sh -c 'echo "deb [arch=amd64] https://packages.microsoft.com/repos/code stable main" > /etc/apt/sources.list.d/vscode.list'
rm microsoft.gpg
sudo apt update
sudo apt install -y code

echo -e "${GREEN}>>> VS Code installed.${RESET}"

# --- Vivaldi setup ---
echo -e "${CYAN}>>> Installing Vivaldi browser...${RESET}"
wget -qO /tmp/vivaldi.deb https://downloads.vivaldi.com/stable/vivaldi-stable_amd64.deb
sudo apt install -y /tmp/vivaldi.deb
rm /tmp/vivaldi.deb
echo -e "${GREEN}>>> Vivaldi installed.${RESET}"

# --- Termius setup ---
echo -e "${CYAN}>>> Installing Termius...${RESET}"
wget -qO /tmp/Termius.deb https://www.termius.com/download/linux/Termius.deb
sudo apt install -y /tmp/Termius.deb
rm /tmp/Termius.deb
echo -e "${GREEN}>>> Termius installed.${RESET}"

# --- Postman setup ---
echo -e "${CYAN}>>> Installing Postman...${RESET}"
cd "$APP_DIR"
wget -q https://dl.pstmn.io/download/latest/linux64 -O postman.tar.gz
tar -xzf postman.tar.gz
rm postman.tar.gz
cd -

# Create desktop entry
echo -e "${CYAN}>>> Creating Postman desktop entry...${RESET}"
cat > "$DESKTOP_DIR/postman.desktop" <<EOF
[Desktop Entry]
Name=Postman
Exec=$APP_DIR/Postman/app/Postman
Icon=$APP_DIR/Postman/app/resources/app/assets/icon.png
Type=Application
Categories=Development;Utility;
Terminal=false
StartupWMClass=Postman
EOF

echo -e "${GREEN}>>> Postman installed and desktop entry created.${RESET}"

# --- Final message ---
echo ""
echo -e "${GREEN}✅ All requested apps have been processed.${RESET}"
echo ""
