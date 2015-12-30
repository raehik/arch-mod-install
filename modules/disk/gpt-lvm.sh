# vim: set ft=sh
#
# Module:   disk/gpt-lvm
# Desc.:    Initialise a disk device with GPT LVM.
#
# NOTE: see sys/config for actions taken if an LVM module is chosen
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

_log "Removing any old LVM traces"
vgremove -f "$V_vg_name"
pvremove -ff "$lvm_part"

_log "Initialising LVM partition"
pvcreate -f --yes "$lvm_part"
vgcreate -f --yes "$V_vg_name" "$lvm_part"
lvcreate --yes -L $V_root_size "$V_vg_name" --name root
lvcreate --yes -L $V_var_size "$V_vg_name" --name var
lvcreate --yes -L $V_home_size "$V_vg_name" --name home

_log "Creating filesystems"
mkfs.ext4 "$boot_part"
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
