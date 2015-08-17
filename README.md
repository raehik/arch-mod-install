Arch Linux automated modular install script
===========================================

This is a non-interactive installer for Arch Linux. You set options before
execution, then you run the script and leave it to its business.

Inspired by Ethan Schoonover's [archblocks][].

[archblocks]: https://github.com/altercation/archblocks


Requirements
------------

The default options require some extra packages on the install medium:

  * git
  * tmux

However, Git is only needed for certain modules, and tmux can be disabled in the
`vars` file.


Usage
-----

Make sure you have Git installed, and clone this repo:

    git clone https://github.com/raehik/arch-mod-install

Add modules and change options in the `vars` file, then **make sure you check
over the installer & selected modules!** When you're happy, begin the install by executing `install`.
