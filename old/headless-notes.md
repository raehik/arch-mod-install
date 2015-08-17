SSHing to the Arch Live CD fully headless from turned off
=========================================================

Starting Arch
-------------

The computer will by default try to boot using the CD if it is present, so that
makes things a lot easier.

If you've got the side cover off, press F1 after you hear a double beep. (I
like the forced keyboard checks, because it tells me when there's a problem.)

After letting it get past the BIOS to the Arch architecture-choosy screen,
press Enter once. This'll boot up x64_86 Arch, because it's the default
selection.


Running SSH
-----------

First, we need to start the ssh daemon, `sshd`:

    $ systemctl start sshd

But to ssh in to a user, they need a password. By default, root doesn't have a
password on Arch. So we'll set one:

    $ passwd

Remember to type it in twice. And KISS, because we're headless.


Logging in
----------

We need to know the IP. Arch is rather nice and grabs a DHCP IP by default if
it can - so, we just need to check our router's DHCP client table. In my
Linksys WRT54G2, it's in Status-->Local Network-->DHCP Clients Table. Look for
the hostname `archiso`.

With the IP and your set password from before, go ahead and ssh in on the
default port 22 as the root user:

    $ ssh root@${ip}

You're in! Hopefully.


tl;dr
-----

  1. press Enter
  2. `$ systemctl start sshd ; passwd`
  3. `$ ssh root@${dhcp-ip}`
