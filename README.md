Screenshots:
![alt text](img/image.png)

i3 initial setup:
https://codeberg.org/cizordj/i3-themer

    sudo apt install alacritty i3 i3lock-fancy polybar nitrogen fonts-font-awesome fonts-firacode rofi xdg-utils sensible-utils alsa-utils dunst flameshot libx11-dev libxcomposite-dev libxdamage-dev libxfixes-dev libxrender-dev pkg-config make gcc git fastfetch

some dotfiles reference from:
https://github.com/brainfucksec/dotfiles

### Setup:

| Component         | Application                    |
| ----------------- | ------------------------------ |
| OS                | Parrot Security 6.4 (lorikeet) |
| Shell             | zsh with oh my zsh             |
| Compositor        | fastcompmgr                    |
| Terminal Emulator | Alacritty                      |
| Window Manager    | i3                             |
| Bar               | polybar                        |
| Program Launcher  | rofi                           |
| Themes            | Nordic                         |
| Icons             | Papirus                        |
| File Manager      | Thunar File Manager            |
| Image Viewer      | gThumb                         |

### Notes:

    rm -rf ~/.config/alacritty ~/.config/dunst ~/.config/fastfetch ~/.config/gtk-3.0 ~/.config/i3 ~/.config/polybar ~/.config/rofi
    ln -s ~/Documents/dotfiles/.config/alacritty ~/.config/alacritty
    ln -s ~/Documents/dotfiles/.config/dunst ~/.config/dunst
    ln -s ~/Documents/dotfiles/.config/fastfetch ~/.config/fastfetch
    ln -s ~/Documents/dotfiles/.config/gtk-3.0 ~/.config/gtk-3.0
    ln -s ~/Documents/dotfiles/.config/i3 ~/.config/i3
    ln -s ~/Documents/dotfiles/.config/polybar ~/.config/polybar
    ln -s ~/Documents/dotfiles/.config/rofi ~/.config/rofi

    # before themes:
    sudo apt install sassc gnome-themes-extra gtk2-engines-murrine

    ln -sf ~/Documents/dotfiles/.fonts ~/.fonts
    ln -sf ~/Documents/dotfiles/.themes ~/.themes
    ln -sf ~/Documents/dotfiles/.icons ~/.icons
    ln -sf ~/Documents/dotfiles/.Xresources ~/.Xresources
    ln -sf ~/Documents/dotfiles/.zshrc ~/.zshrc

    # after apply theme (for flatpak only):
    sudo flatpak override --filesystem=$HOME/.themes
    sudo flatpak override --filesystem=$HOME/.icons
    flatpak override --user --filesystem=xdg-config/gtk-4.0
    sudo flatpak override --filesystem=xdg-config/gtk-4.0
