#!/bin/bash -p

# │ These scripts are called with the images directory name as            │
# │ first argument. The script is executed from the main Buildroot        │
# │ source directory as the current directory.                            │

TARGET=$1
TOPDIR=$(pwd)

echo "Running Cerebras SM post build script..."
echo "----------------------------------------"

echo "Moving udev init script"
if [ -f ${TARGET}/etc/init.d/S10udev ]
then
    mv -f ${TARGET}/etc/init.d/{S10udev,S35udev}
fi
if [ ! -f ${TARGET}/etc/init.d/S35udev ]
then
    echo ${TARGET}/etc/init.d/S35udev is missing
    exit 1
fi

echo "Copying Cerebras SM skeleton files"
tar -C $TOPDIR/cerebras/sm-skel -cf - . | (cd $TARGET && tar xf -)

#
# Following probably should be done in a script and not part of interfaces file
#
echo "Enabling ETH0 at startup"
cat << EOM > $TARGET/etc/network/interfaces
#
# Temporary hack
#

auto lo
iface lo inet loopback
auto eth0
iface eth0 inet dhcp
auto eth2
iface eth2 inet static
    address 10.0.0.1
    netmask 255.255.255.252
auto eth3
iface eth3 inet static
    address 10.0.0.5
    netmask 255.255.255.252
EOM

#
# Rewrite sshd_config by adding Cerebras settings
# to the end of the file.  This method works
# even if this script is executed multiple times.
#

echo "Updating sshd_config"

# delete those that are changed or added
sed -i -f - ${TARGET}/etc/ssh/sshd_config <<<'
/^#\?PermitRootLogin[ \t]\+/d
/^#\?PermitEmptyPasswords[ \t]\+/d
/^#\?X11Forwarding[ \t]\+/d
/^#\?XauthLocation[ \t]\+/d
/^# Cerebras config/d
${/^.*$/{G;}}
'

# create new values
cat >> ${TARGET}/etc/ssh/sshd_config <<'EOF'
# Cerebras config
PermitRootLogin yes
PermitEmptyPasswords yes
X11Forwarding yes
XauthLocation /usr/bin/xauth
EOF
