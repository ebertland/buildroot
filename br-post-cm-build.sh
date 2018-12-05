#!/bin/bash -p

# │ These scripts are called with the images directory name as            │
# │ first argument. The script is executed from the main Buildroot        │
# │ source directory as the current directory.                            │

TARGET=$1
TOPDIR=$(pwd)

echo "Running Cerebras CM post build script..."
echo "----------------------------------------"

echo "Moving udev init script"
if [ -f ${TARGET}/etc/init.d/S10udev ]
then
    mv -f ${TARGET}/etc/init.d/{S10udev,S99udev}
fi
if [ ! -f ${TARGET}/etc/init.d/S99udev ]
then
    echo ${TARGET}/etc/init.d/S99udev is missing
    exit 1
fi

echo "Copying Cerebras SM skeleton files"
tar -C $TOPDIR/cerebras/cm-skel -cf - . | (cd $TARGET && tar xf -)

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
auto ni0
iface ni0 inet static
    address 10.0.0.6
    netmask 255.255.255.252
auto ni1
iface ni1 inet static
    address 10.0.0.2
    netmask 255.255.255.252
EOM

echo "Enabling SSH root access without password"
sed -i 's/^#PermitRootLogin prohibit-password/PermitRootLogin yes/' \
    $TARGET/etc/ssh/sshd_config
sed -i 's/^#PermitEmptyPasswords no/PermitEmptyPasswords yes/' \
    $TARGET/etc/ssh/sshd_config
