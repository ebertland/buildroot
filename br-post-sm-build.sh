#!/bin/bash -p

# │ These scripts are called with the images directory name as            │
# │ first argument. The script is executed from the main Buildroot        │
# │ source directory as the current directory.                            │

TARGET=$1
TOPDIR=$(pwd)

echo "Running Cerebras SM post build script..."
echo "----------------------------------------"

echo "Copying Cerebras SM skeleton files"
tar -C $TOPDIR/cerebras/sm-skel -cf - . | (cd $TARGET && tar xf -)

echo "Enabling ETH0 at startup"
echo "auto eth0" >> $TARGET/etc/network/interfaces
echo "iface eth0 inet dhcp" >> $TARGET/etc/network/interfaces

echo "Enabling SSH root access without password"
sed -i 's/^#PermitRootLogin prohibit-password/PermitRootLogin yes/' \
    $TARGET/etc/ssh/sshd_config
sed -i 's/^#PermitEmptyPasswords no/PermitEmptyPasswords yes/' \
    $TARGET/etc/ssh/sshd_config
