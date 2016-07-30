# vim: set ft=sh
#
# Module:   net/auto-wlan
# Desc.:    Auto-connect to wireless networks which have netctl profiles.
#

_pkg_install wpa_actiond
systemctl enable netctl-auto@${V_test}.service
