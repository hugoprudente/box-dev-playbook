#!/bin/bash -e
exec > >(tee /var/log/ansible.log|logger -t ansible -s 2>/dev/console) 2>&1

# Install Ansible on the Cloud9 Box
/usr/local/bin/pip install --upgrade ansible
ansible-playbook cloud9.yml
