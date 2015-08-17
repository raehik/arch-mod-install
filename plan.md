Flow
----

  * Run core pre-chroot install stuff (partitioning etc.)
    * Not modules, but are affected by `vars`
  * Chroot in
  * Run modules

If it turns out I need to have modules for pre-chroot as well, I'll need to
separate the module vars.
