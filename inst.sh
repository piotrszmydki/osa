#!/bin/bash
clear
git clone https://github.com/piotrszmydki/osa /etc/openstack_deploy
git clone -b master https://opendev.org/openstack/openstack-ansible /opt/openstack-ansible
cd /opt/openstack-ansible
scripts/bootstrap-ansible.sh
cp -R /opt/openstack-ansible/etc/openstack_deploy /etc/
scp /etc/openstack_deploy/make-swift-disk.sh root@172.29.236.211:/root/
scp /etc/openstack_deploy/make-lvm-disk.sh root@172.29.236.213:/root/
#cp /etc/openstack_deploy/openstack_user_config.yml.example /etc/openstack_deploy/openstack_user_config.yml
cd /opt/openstack-ansible
./scripts/pw-token-gen.py --file /etc/openstack_deploy/user_secrets.yml
nano /etc/openstack_deploy/user_secrets.yml
nano /opt/openstack-ansible/inventory/inventory.ini
cd /opt/openstack-ansible/playbooks

