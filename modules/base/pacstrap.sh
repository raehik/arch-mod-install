# vim: set ft=sh
#
# Module:   base/pacstrap
# Desc.:    Install the base system.
#

_log "Ranking pacman mirrors (may take 5 minutes or more)"
mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
rankmirrors -n 6 /etc/pacman.d/mirrorlist.bak > /etc/pacman.d/mirrorlist

_log "Pacstrapping base packages"
pacstrap -i /mnt base grub openssh rxvt-unicode-terminfo sudo

_log "Generating fstab"
genfstab -U -p /mnt >> /mnt/etc/fstab
