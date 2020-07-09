#!/bin/bash -e
# exec > >(tee /tmp/ansible.log|logger -t ansible -s 2>/dev/console) 2>&1

# Install Ansible on the Cloud9 Box

# python3 -m pip install --upgrade pip
# python3 -m pip install ansible --user

ansible-playbook playbook.yml
