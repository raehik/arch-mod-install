# vim: set ft=sh
#
# Module:   net/sshd
# Desc.:    Install and enable Avahi (for the multicast DNS service).
#

_log "Installing and enabling Avahi"
_pkg_install avahi nss-mdns
sed -e 's/\(^hosts: files dns myhostname\)/#\1/' \
    -e '10ihosts: files mdns_minimal [NOTFOUND=return] dns myhostname' \
    -i /etc/nsswitch.conf
systemctl enable avahi-daemon
