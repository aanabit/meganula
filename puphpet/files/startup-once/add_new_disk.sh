#!/bin/bash
set -e
set -x

if [ -f /usr/tmp/disk_added_date ]
then
   echo "Disk already added so exiting."
   exit 0
fi


sudo fdisk -u /dev/sdb <<EOF
n
p
1


t
8e
w
EOF

pvcreate /dev/sdb1
vgextend VolGroup /dev/sdb1
lvextend /dev/VolGroup/lv_root /dev/sdb1
resize2fs /dev/VolGroup/lv_root
echo "Disk Added, Done resizing"

date > /usr/tmp/disk_added_date
exit 0