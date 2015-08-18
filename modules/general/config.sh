# vim: set ft=sh
#
# Module:   general/config
# Desc.:    General system configuration (hostname, locale etc.)
#

# set hostname
echo "$V_hostname" > /etc/hostname

# set time zone
ln -sf "/usr/share/zoneinfo/$V_timezone" /etc/localtime

# generate locales
sed -i \
    -e 's/^#en_GB.UTF-8/en_GB.UTF-8/' \
    -e 's/^#en_US.UTF-8/en_US.UTF-8/' \
    /etc/locale.gen
locale-gen

# set preferred locale & keymap
localectl set-locale "LANG=$V_locale"
localectl set-keymap "$V_keymap"

## LVM-related options {{{
if [[ "$V_M_disk" == *"lvm"* ]]; then
    # add lvm2 hook for mkinitcpio
    sed -i \
        -e 's/\(^HOOKS=".* block\) \(filesystems .*"\)/\1 lvm2 \2/' \
        /etc/mkinitcpio.conf
fi
## }}}

# create ramdisk
mkinitcpio -p linux

# upgrade pacman db (depending on install media age, this might be necessary)
pacman-db-upgrade
