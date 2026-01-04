Screenshots:
![alt text](img/image.png)

some dotfiles reference from:
https://github.com/brainfucksec/dotfiles

### Setup:

| Component         | Application         |
| ----------------- | ------------------- |
| OS                | Debian 13 (Trixie)  |
| Shell             | zsh with oh my zsh  |
| Compositor        | fastcompmgr         |
| Terminal Emulator | Alacritty           |
| Window Manager    | i3                  |
| Bar               | polybar             |
| Program Launcher  | rofi                |
| Themes            | Space-dark          |
| Icons             | Tokyonight-Moon     |
| File Manager      | Thunar File Manager |
| Image Viewer      | ristretto           |

### Notes:

    # after apply theme (for flatpak only):
    sudo flatpak override --filesystem=$HOME/.themes
    sudo flatpak override --filesystem=$HOME/.icons
    flatpak override --user --filesystem=xdg-config/gtk-4.0
    sudo flatpak override --filesystem=xdg-config/gtk-4.0

It is somehow better to install NVIDIA from CUDA (https://developer.nvidia.com/cuda-downloads?target_os=Linux&target_arch=x86_64&Distribution=Debian&target_version=13&target_type=deb_network), especially for Wayland. As I was writing this, I got bored with i3 and chose GNOME Wayland instead.
