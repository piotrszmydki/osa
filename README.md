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

You need to prepare network bridges like: br-mgmt, add second ethernet interface to this bridge.
Prepare disk for storage providers like swift, lvm ( with scripts )

run inst.sh   
Script shows you 2 files: 
1. with passwords ( you can change password for openstack dashboard in line keystone_admin_password.
2. with inventory configuration - you can add hostnames in section [hosts] like (one per line): 
controller
compute1
compute2
compute3

If somthings goes wrong:

After each install of ceph you see warn error about insecure reclaim. After enter this command:

ceph config set mon auth_allow_insecure_global_id_reclaim false

ceph status will be OK.


Sometimes (if you have an error about too much pgs or somethings) you need to enter the ceph-mon container and enter this command:

ceph config set mon mon_max_pg_per_osd 900

Other usefull commands:

You can change deafult pool size by typing:

ceph osd pool set POOL_NAME size 2

ceph osd pool set POOL_NAME min_size 1
