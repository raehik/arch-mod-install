# vim: set ft=sh
#
# Module:   user/init-user
# Desc.:    Initialise a user.
#

_log "Initialising new user $V_user"
useradd -m "$V_user"
chpasswd <<< "$V_user:$V_user_passwd"
