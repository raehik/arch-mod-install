# vim: set ft=sh :
#

## Basic stuff {{{
# set hostname
echo "$V_hostname" > /etc/hostname

# set time zone
ln -sf /usr/share/zoneinfo/$V_timezone /etc/localtime

# generate locales
sed -i \
    -e 's/^#en_GB.UTF-8/en_GB.UTF-8/' \
    -e 's/^#en_US.UTF-8/en_US.UTF-8/' \
    /etc/locale.gen
locale-gen

# set preferred locale & keymap
localectl set-locale "LANG=en_GB.UTF-8"
localectl set-keymap uk

# add lvm2 hook for mkinitcpio & run
sed -i \
    -e 's/\(^HOOKS=".* block\) \(filesystems .*"\)/\1 lvm2 \2/' \
    /etc/mkinitcpio.conf
mkinitcpio -p linux
## }}}

# now we do the modules
for module in $V_modules; do
    echo $module
done
