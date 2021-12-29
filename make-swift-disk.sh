#!/bin/bash
clear
echo "Script to create disk for SWIFT storage (PS@2021)"
fdisk -l |grep dev
echo "Choose disk and write path (eg sdb):"
read disk1
mkfs.xfs -f -i size=1024 -L '$disk' /dev/$disk1
echo "Choose next disk and write path:"
read disk2
mkfs.xfs -f -i size=1024 -L '$disk2' /dev/$disk2
echo "Choose next disk and write path:"
read disk3
mkfs.xfs -f -i size=1024 -L '$disk3' /dev/$disk3
echo "FSTAB before changes: "
cat /etc/fstab
#echo "/dev/$disk1 /srv/$disk1 xfs noatime,nodiratime,nobarrier,logbufs=8,auto 0 0" >> /etc/fstab
#echo "LABEL=$disk1 /srv/$disk1 xfs noatime,nodiratime,nobarrier,logbufs=8,auto 0 0" >> /etc/fstab
echo "/dev/$disk1 /srv/$disk1 xfs auto 0 0" >> /etc/fstab
echo "/dev/$disk2 /srv/$disk2 xfs auto 0 0" >> /etc/fstab
echo "/dev/$disk3 /srv/$disk3 xfs auto 0 0" >> /etc/fstab
mkdir -p /srv/$disk1
mkdir -p /srv/$disk2
mkdir -p /srv/$disk3
mount -a
mount
sleep 2
echo " fstab AFTER changes: "
cat /etc/fstab

