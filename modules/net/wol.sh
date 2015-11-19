# vim: set ft=sh
#
# Module:   net/wol
# Desc.:    Enable Wake-on-LAN for the specified interface
# Requires: config/adminfiles
#

_log "Enabling Wake-on-LAN for interface $V_wol_interface"
systemctl enable "wol@${V_wol_interface}.service"

# start it too in case the user might want to use it immediately
_log "Starting Wake-on-LAN for interface $V_wol_interface"
systemctl start "wol@${V_wol_interface}.service"
