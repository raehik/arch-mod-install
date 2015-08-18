# vim: set ft=sh
#
# Module:   net/auto-eth
# Desc.:    Enable ifplugd (auto-connect ethernet).
#
# Note: This module requires disabling consistent device naming. My grubfiles do
# this for you (check config/grubfiles.sh).
#

_log "Installing & enabling ifplugd"
_pkg_install ifplugd
systemctl enable netctl-ifplugd@eth0

_log "Enabling sshd"
systemctl enable sshd
