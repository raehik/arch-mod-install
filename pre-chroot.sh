# vim: set ft=sh :
#

## Disk initialising {{{
_log "Prepping disk"
sgdisk -Z "$V_disk_dev"
sgdisk -o "$V_disk_dev"

_log "Creating partitions"
sgdisk -n 1:2048:+1M -c 1:"BIOS-GPT boot partition" -t 1:ef02 "$V_disk_dev"
sgdisk -n 2:0:+$V_boot_size -c 2:"Linux /boot" -t 2:8300 "$V_disk_dev"
sgdisk -n 3:0:0 -c 3:"Linux LVM" -t 3:8e00 "$V_disk_dev"
## }}}
## Filesystem creation {{{
boot_part="${V_disk_dev}2"
lvm_part="${V_disk_dev}3"

_log "Initialising LVM partition"
pvcreate "$lvm_part"
vgcreate "$V_vg_name" "$lvm_part"
lvcreate -L $V_root_size "$V_vg_name" --name root
lvcreate -L $V_var_size "$V_vg_name" --name var
lvcreate -L $V_home_size "$V_vg_name" --name home

_log "Creating filesystems"
mkfs.ext4 "$V_boot_part"
mkfs.ext4 "/dev/mapper/$V_vg_name-root"
mkfs.ext4 "/dev/mapper/$V_vg_name-var"
mkfs.ext4 "/dev/mapper/$V_vg_name-home"

_log "Mounting partitions"
mount "/dev/mapper/$V_vg_name-root" /mnt
mkdir /mnt/boot /mnt/var /mnt/home
mount "$boot_part" /mnt/boot
mount "/dev/mapper/$V_vg_name-var" /mnt/var
mount "/dev/mapper/$V_vg_name-home" /mnt/home
## }}}
## Base system install {{{
_log "Ranking pacman mirrors (may take 5 minutes or more)"
mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bak
rankmirrors -n 6 /etc/pacman.d/mirrorlist.bak > /etc/pacman.d/mirrorlist

_log "Pacstrapping base packages"
pacstrap -i /mnt base

_log "Generating fstab"
genfstab -U -p /mnt >> /mnt/etc/fstab
## }}}
