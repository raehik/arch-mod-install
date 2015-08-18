# vim: set ft=sh
#
# Module:   boot/grub
# Desc.:    Install grub on the install disk.
#

_log "Installing GRUB"
_pkg_install grub
grub-install --recheck "$V_disk_dev"

_log "Making GRUB config (warnings are fine, don't worry!)"
grub-mkconfig -o /boot/grub/grub.cfg
