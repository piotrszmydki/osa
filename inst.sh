#!/bin/bash
clear
git clone https://github.com/piotrszmydki/osa /etc/openstack_deploy
git clone -b master https://opendev.org/openstack/openstack-ansible /opt/openstack-ansible
cd /opt/openstack-ansible
scripts/bootstrap-ansible.sh
cp -R /opt/openstack-ansible/etc/openstack_deploy /etc/
echo " copy create disks script for swift to host 172.29.236.211"
scp /etc/openstack_deploy/make-swift-disk.sh root@172.29.236.211:/root/
echo " copy create disks script for lvm to host 172.29.236.213"
scp /etc/openstack_deploy/make-lvm-disk.sh root@172.29.236.213:/root/
#cp /etc/openstack_deploy/openstack_user_config.yml.example /etc/openstack_deploy/openstack_user_config.yml
cd /opt/openstack-ansible
./scripts/pw-token-gen.py --file /etc/openstack_deploy/user_secrets.yml
echo " you can change openstack dashboard password in line keystone_admin_password: ( or exit without any changes)"
nano /etc/openstack_deploy/user_secrets.yml
echo " add some host to hosts section: ( where openstack will be installed)"
nano /opt/openstack-ansible/inventory/inventory.ini
echo "Add to the global: mon_max_pg_per_osd: 900"
echo " and auth_allow_insecure_global_id_reclaim: false"
sleep 5
nano /opt/openstack-ansible/inventory/group_vars/ceph_all.yml
echo " Change dalay in section install distro package from 2 to 5. #Because you will see error: connection failed"
sleep 5
nano /opt/openstack-ansible/playbooks/utility-install.yml
echo " add venv_wheel_build_skip_check: true to /etc/openstack_deploy/user_variables.yml"
sleep 5
nano /etc/openstack_deploy/user_variables.yml
cd /opt/openstack-ansible/playbooks
echo " END"
sleep 5
