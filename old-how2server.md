# Headless SSH
- [if required, press F1 after double beep to allow running while cover off]
  currently keeping the keyboard checks if there's a problem, so I know if
  there's a problem
- press enter (would be on Arch start-up GUI, want to start x86_64
- type passwd
    - use any old short password
    - remember to leave a space between the command and the password, and to
      enter it twice
- systemctl start sshd
- find DHCP IP on the clients table in router

# Create new GPT (destroy disk)
- gdisk /dev/sda
    - o (destroy all partitions, make new GPT table)

# Partition disk
- cgdisk /dev/sda
    - New
    - Default start
    - Size 100M
    - Default type (8300, Linux filesystem)

    - New on free space below
    - Default sectors
    - Type 8e00 (Linux LVM)

    - New on 1007.0 KiB free space above
    - Default sectors
    - Type ef02
- reboot

# Install Vim on the temporary filesystem
- pacman -Syu
    - choose not to install
- pacman -S vim

# Configure LVM partition
## Delete any old stuff
- vgremove main
- pvremove /dev/sda2

## Create PV, VG & all LVs (leaving much room for enlargement)
note: wipe any ext4 signatures, probs left over from not zeroing the disk
- pvcreate /dev/sda2
- vgcreate main /dev/sda2
- lvcreate -L 100G main --name root
- lvcreate -L 25G main --name usr
- lvcreate -L 50G main --name var
- lvcreate -L 3G main --name home

# Create filesystems
- mkfs.ext4 /dev/sda1
- mkfs.ext4 /dev/mapper/main-root
- mkfs.ext4 /dev/mapper/main-usr
- mkfs.ext4 /dev/mapper/main-var
- mkfs.ext4 /dev/mapper/main-home

# Mount partitions correctly (note /boot)
- mount /dev/mapper/main-root /mnt
- mkdir /mnt/boot /mnt/usr /mnt/var /mnt/home
- mount /dev/sda1 /mnt/boot
- mount /dev/mapper/main-usr /mnt/usr
- mount /dev/mapper/main-var /mnt/var
- mount /dev/mapper/main-home /mnt/home

# Install main base
- vim /etc/pacman.d/mirrorlist
    - bring e.g. some UK and Germany to the top
- pacstrap /mnt base openssh vim (do I need base-devel?)

# General system configuration
- genfstab -U -p /mnt >> /mnt/etc/fstab

## Inside the new system
- arch-chroot /mnt /bin/bash
- vim /etc/locale.gen
    - uncomment `en_GB.UTF-8`
- locale-gen
- echo LANG=en_GB.UTF-8 > /etc/locale.conf
- export LANG=en_GB.UTF-8
- ln -s /usr/share/zoneinfo/Europe/London /etc/localtime
- echo str1 > /etc/hostname
- vi /etc/hosts
    - on `127.0.0.1` line, add `\tstr1` to the end
- passwd
    - curpassaintagreat1
- vim /etc/mkinitcpio.conf
    - in `HOOKS=` line, add `lvm2` between `block` and `filesystems`
    - then append `shutdown usr` at end (after `fsck`)
    - i.e. HOOKS="base udev autodetect modconf block lvm2 filesystems keyboard fsck shutdown usr"
- mkinitcpio -p linux
- vim /etc/netctl/def-static
"""
Description='A basic static ethernet connection'
Interface=enp11s0
Connection=ethernet
IP=static
Address=('192.168.1.41/24')
Gateway='192.168.1.1'
DNS=('8.8.8.8' '8.8.4.4')
"""
- systemctl enable sshd

# Install bootloader
- pacman -S grub
- grub-install --target=i386-pc --recheck /dev/sda
- grub-mkconfig -o /boot/grub/grub.cfg
    - don't worry bout errors
- exit
- umount -R /mnt
- reboot
- take disc out
- hope for the fuckin best.
