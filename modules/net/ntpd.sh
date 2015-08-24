# vim: set ft=sh
#
# Module:   system/sudo
# Desc.:    Configure basic sudo rules.
#

_log "Installing & enabling ntp"
_pkg_install ntp
systemctl enable ntpd
