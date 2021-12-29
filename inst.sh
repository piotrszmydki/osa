#!/bin/bash
clear
git clone https://github.com/piotrszmydki/piotrszmydki /etc/openstack_deploy
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
echo "Add to the global: mon_max_pg_per_osd: 900"
echo " and auth_allow_insecure_global_id_reclaim: false"
sleep 5
nano /opt/openstack-ansible/inventory/group_vars/ceph_all.yml
echo " Change dalay in section install distro package from 2 to 5. #Because you will see error: connection failed"
sleep 5
nano /opt/openstack-ansible/playbooks/utility-install.yml
cd /opt/openstack-ansible/playbooks

