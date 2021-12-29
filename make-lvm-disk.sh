#!/bin/bash
clear
echo "Script to create disk for LVM storage (PS@2021)"
fdisk -l |grep dev
echo "Choose disk and write path (eg sdb):"
read disk1
pvcreate --metadatasize 2048 /dev/$disk1
echo "Choose next disk and write path:"
read disk2
pvcreate /dev/$disk2
echo "Choose next disk and write path"
read disk3
pvcreate /dev/$disk3
vgcreate cinder-volumes /dev/$disk1
vgextend cinder-volumes /dev/$disk2
vgextend cinder-volumes /dev/$disk3
vgdisplay
sleep2

