# vim: set ft=sh
#
# Module:   net/sshd
# Desc.:    Install and enable Avahi (for the multicast DNS service).
#

_log "Installing and enabling Avahi"
_pkg_install avahi
systemctl enable avahi-daemon
