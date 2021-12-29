#!/bin/bash
clear
echo "Script to create brigdes for openstack (PS@2021)"
echo" List of the interfaces:"
ifconfig
echo "enter name of the interface to add to br-mgmt:"
read e
echo "Inastall packages bridge-utils mc net-tools htop sysstat"
apt install bridge-utils mc net-tools htop sysstat -y
brctl addbr br-mgmt;
brctl addbr br-vxlan;
brctl addbr br-vlan;
brctl addbr br-storage;
brctl addif br-mgmt $e;
cp /etc/netplan/00-installer-config.yaml /etc/netplan/00-installer-config.old.yaml;
echo "      $e:
      dhcp4: false
      dhcp6: false
  bridges:
    br-mgmt:
           interfaces: [$e]
           addresses: [172.29.236.251/22]
           mtu: 1500
           parameters:
                stp: false
                forward-delay: 4
           dhcp4: no
           dhcp6: no
    br-storage:
           dhcp4: no
           dhcp6: no
    br-vxlan:
           dhcp4: no
           dhcp6: no
    br-vlan:
           dhcp4: no
           dhcp6: no
  version: 2" >> /etc/netplan/00-installer-config.yaml

echo "Copy scripts"
echo "enter node ip with ceph:"
read ceph
scp make-ceph-disk.sh root@$ceph:/root/
echo "enter node ip with swift:"
read swift
scp make-swift-disk.sh root@swift:/root/
echo "enter node ip with lvm:"
read lvm
scp make-lvm-disk.sh root@$lvm:/root/
echo "end"
