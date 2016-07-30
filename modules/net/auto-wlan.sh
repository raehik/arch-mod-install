# vim: set ft=sh
#
# Module:   net/auto-wlan
# Desc.:    Auto-connect to wireless networks which have netctl profiles.
#

_log "Installing dependencies for netctl-auto and wifi-menu"
_pkg_install wpa_actiond dialog
_log "Enabling netctl-auto on $V_wlan_interface"
systemctl enable netctl-auto@${V_wlan_interface}.service
_log "Enabled, however no netctl profiles are present yet, so you'll have to
create one on reboot"
