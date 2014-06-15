Setsura automated install for Arch Linux
========================================

That's what this is. A set of rather unneat and badly thought through (but
verbose and helpful) scripts which leads you through a bare bones Arch install
(along with Vim, tmux, and openssh), written with a certain computer in mind.

To use, copy the `0[1-3]-*` files over to the computer you're installing on.
Instructions on how to SSH to a computer running the Arch install CD can be
found in `headless-notes.md`. Use `scp` like this:

    $ scp 00-initialise-disk root@${ip}

Then when you want to copy the rest over after a reboot:

    $ scp 01-create-mount-fs 02-setup-base 03-chroot-config def-static root@${ip}

Couldn't be much easier. Or maybe it could, but I probably won't take pull
requests all the same.
