# vim: set ft=sh
#
# Module:   adminfiles
# Desc.:    Install my adminfiles.
#

_pkg_install git
git clone "https://github.com/$V_github_user/adminfiles" "$V_chroot_tmp_dir"
"$V_chroot_tmp_dir/adminfiles/install"
rm -rf "$V_chroot_tmp_dir/adminfiles"
