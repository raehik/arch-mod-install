# vim: set ft=sh
#
# Module:   net/auto-eth
# Desc.:    Auto-connect ethernet via dhcpcd.
#

_log "Enabling dhcpcd"
systemctl enable dhcpcd
