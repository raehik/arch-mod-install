# vim: set ft=sh
#
# Module:   general/config
# Desc.:    General system configuration (hostname, locale etc.)
#

_log "Creating temporary directory"
mkdir "$V_chroot_tmp_dir"

_log "Setting hostname: $V_hostname"
echo "$V_hostname" > /etc/hostname

_log "Setting timezone: $V_timezone"
ln -sf "/usr/share/zoneinfo/$V_timezone" /etc/localtime

_log "Generating some locales"
sed -i \
    -e 's/^#en_GB.UTF-8/en_GB.UTF-8/' \
    -e 's/^#en_US.UTF-8/en_US.UTF-8/' \
    /etc/locale.gen
locale-gen

_log "Setting preferred locale & keymap"
localectl set-locale "LANG=$V_locale"
localectl set-keymap "$V_keymap"

## LVM-related options {{{
if [[ "$V_M_disk" == *"lvm"* ]]; then
    _log "LVM install detected, adding lvm2 hook for mkinitcpio"
    sed -i \
        -e 's/\(^HOOKS=".* block\) \(filesystems .*"\)/\1 lvm2 \2/' \
        /etc/mkinitcpio.conf
fi
## }}}

_log "Creating ramdisk with mkinitcpio"
mkinitcpio -p linux

# upgrade pacman db (depending on install media age, this might be necessary)
_log "Running pacman-db-upgrade"
pacman-db-upgrade

_log "Setting root password to $V_root_password"
chpasswd <<< "root:hackme"
