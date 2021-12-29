apt install bridge-utils mc net-tools htop sysstat build-essential git chrony python3-dev sudo -y
git clone -b master https://opendev.org/openstack/openstack-ansible /opt/openstack-ansible
nano /opt/openstack-ansible/inventory/group_vars/hosts.yml
cd /opt/openstack-ansible
scripts/bootstrap-ansible.sh
cp -R /opt/openstack-ansible/etc/openstack_deploy /etc/openstack_deploy
cp /etc/openstack_deploy/openstack_user_config.yml.example /etc/openstack_deploy/openstack_user_config.yml
cd /opt/openstack-ansible
./scripts/pw-token-gen.py --file /etc/openstack_deploy/user_secrets.yml
nano /etc/openstack_deploy/user_secrets.yml
nano /opt/openstack-ansible/inventory/inventory.ini
echo "NOW ADD SOME DISK (IF YOU NEED)"
cd /opt/openstack-ansible/
inventory/dynamic_inventory.py --config /etc/openstack_deploy/
inventory/dynamic_inventory.py --check
cd /opt/openstack-ansible/playbooks
echo " type: openstack-ansible setup-hosts.yml"
echo " next: openstack-ansible setup-infrastructure.yml"
echo " at last: openstack-ansible setup-openstack.yml"