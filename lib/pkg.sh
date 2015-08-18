# vim: set ft=sh :
#

_install_pkgs() {
    pacman -S --noconfirm "$@"
}
