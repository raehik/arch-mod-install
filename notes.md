# Headless SSH
- [if required, press F1 after double beep to allow running while cover off]
  currently keeping the keyboard checks if there's a problem, so I know if
  there's a problem
- press enter (would be on Arch start-up GUI, want to start x86_64
$ passwd
    - use any old short password
    - remember to leave a space between the command and the password (while the
      disk spins up), and enter it twice!
$ systemctl start sshd
- find IP on clients table in router (hostname `archiso`)
  (Status-->Local Network-->DHCP Clients Table)
- ssh in to root on port 22, using previously set password
