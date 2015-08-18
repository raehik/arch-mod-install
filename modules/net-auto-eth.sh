# vim: set ft=sh
#
# Module:   net-auto-eth
# Priority: 99
# Desc.:    Enable ifplugd (auto-connect ethernet).
# Requires: grubfiles
#

_pkg_install ifplugd
systemctl enable netctl-ifplugd@eth0
