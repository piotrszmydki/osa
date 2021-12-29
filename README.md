### Hi there 👋

Source configuration files to create openstack cluster.

SERVERS CONFIGURATION
One controller: 
hostname: controller, 
ip 172.29.236.210 (  br-mgmt ) 
with LVM (script to make lvm disk) + nova

theree compute-nodes

hostname: compute1, 
ip 172.29.236.211 (  br-mgmt ), 
with SWIFT (script to make swift disk)

hostname: compute2, 
ip 172.29.236.212 (  br-mgmt ), 
with CEPH (default ceph disk sdb,sdc,sdd)

hostname: compute3, 
ip 172.29.236.213 (  br-mgmt ), 
with LVM (script to make lvm disk)

You need to prepare network bridges like: br-mgmt, add add second ethernet interface to this bridge.
Prepare disk for storage providers like swift, lvm ( with scripts )

run inst.sh
Script shows you 2 files: 
1. with passwords ( you can change password for openstack dashboard in line keystone_admin_password.
2. with inventory configuration - you can add hostnames in section [hosts] like (one per line): 
controller
compute1
compute2
compute3
