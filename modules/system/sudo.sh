# vim: set ft=sh
#
# Module:   system/sudo
# Desc.:    Configure basic sudo rules.
#

_log "Installing sudo"
_pkg_install sudo

_log "Adding new user $V_user to sudoers"
adduser "$V_user" sudo
