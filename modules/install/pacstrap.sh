# vim: set ft=sh
#
# Module:   install/pacstrap
# Desc.:    Install the base system.
#

_log "Updating pacman package lists"
pacman -Sy

_log "Updating keyring"
_pkg_install archlinux-keyring

_log "Ranking pacman mirrors (may take 5 minutes or more)"
mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
rankmirrors -n 10 /etc/pacman.d/mirrorlist.bak > /etc/pacman.d/mirrorlist

_log "Pacstrapping packages: $V_pkgs"
pacstrap /mnt $V_pkgs

_log "Generating fstab"
genfstab -U -p /mnt >> /mnt/etc/fstab
