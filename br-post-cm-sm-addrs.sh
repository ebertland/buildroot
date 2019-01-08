#!/bin/bash -p

#
# Add the CM and SM interconnect addresses
#

SM_ADDR="169.254.0.5"
CM_ADDR="169.254.0.6"
NETMASK="255.255.255.252"

SM_ADDR2="169.254.0.1"
CM_ADDR2="169.254.0.2"
NETMASK2="255.255.255.252"


echo "Fixing CM and SM addresses"

TARGET=$1
TOPDIR=$(pwd)

echo "$SM_ADDR" > "$TARGET"/etc/sm_addr
echo "$CM_ADDR" > "$TARGET"/etc/cm_addr

echo "$SM_ADDR2" > "$TARGET"/etc/sm_addr2
echo "$CM_ADDR2" > "$TARGET"/etc/cm_addr2

find "$TARGET"/etc -type f -exec sed -i \
     -e 's|@@SM_ADDR@@|'"$SM_ADDR"'|g' \
     -e 's|@@CM_ADDR@@|'"$CM_ADDR"'|g' \
     -e 's|@@NETMASK@@|'"$NETMASK"'|g' \
     -e 's|@@SM_ADDR2@@|'"$SM_ADDR2"'|g' \
     -e 's|@@CM_ADDR2@@|'"$CM_ADDR2"'|g' \
     -e 's|@@NETMASK2@@|'"$NETMASK2"'|g' \
     '{}' \;
