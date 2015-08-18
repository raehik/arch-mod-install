Arch Linux automated modular install script
===========================================

This is a non-interactive installer for Arch Linux. You set options before
execution, then you run the script and leave it to its business.

Inspired by Ethan Schoonover's [archblocks][].

[archblocks]: https://github.com/altercation/archblocks


Requirements
------------

By default, the install script will try to use **tmux**. However, this can be
disabled in the `vars` file.

All other requirements are for the installing system, and packages are specified
and installed by the modules that need them.

You'll probably want to install **Git** to clone this repo, unless you can easily
scp it over or similar (I find Git fastest).


Usage
-----

Make sure you have Git installed, and clone this repo:

    git clone https://github.com/raehik/arch-mod-install

Add modules and change options in the `vars` file, then **make sure you check
over the installer & selected modules!** When you're happy, begin the install by
executing `install`.
