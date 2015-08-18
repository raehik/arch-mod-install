# vim: set ft=sh
#
# Module:   net/sshd
# Desc.:    Enable sshd on boot.
#

_log "Enabling sshd"
_pkg_install openssh rxvt-unicode-terminfo
systemctl enable sshd
