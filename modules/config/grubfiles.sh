# vim: set ft=sh
#
# Module:   grubfiles
# Desc.:    Install my grubfiles.
#

_pkg_install git
git clone "https://github.com/$V_github_user/grubfiles"
grubfiles/install
