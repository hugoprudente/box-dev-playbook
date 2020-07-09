# All Might Box

This is the Ansible Roles that I use to configure my Developer, SysAdmin & DevOps box

## Why?
* From: Everywhere
* With: Vim / Vim Support
* And: Any Device

## Deploy

```bash
$sudo apt-get install python3 python3-pip
```

### Localhost

```bash
$git --depth=1 clone https://github.com/hugoprudente/all-might-box.git
```

**Install Ansible**

Using the [official documentation](https://docs.ansible.com/ansible/latest/installation_guide/intro_installation.html#) install Ansible.

**Run the playbook**

```bash
$ansible-playbook --connection=local --inventory 127.0.0.1, playbook.yml --extra-vars "user=$USER"
```

**Configuration**

### Cloud

Configure the *REGION*, *NAME*, and *IAMUSER* on the **bin/deploy**, file to match your AWS configurations.

```
REGION=eu-west-1
NAME=cloud9pp
IAMUSER=$USER

```

Deploy it!

```
$bin/deploy
```

This creates [Public (IGW)/Private(NAT)](https://docs.aws.amazon.com/vpc/latest/userguide/VPC_Scenario2.html) subnets using all available AZs on give region and create a Cloud9 with extra volume and 2 CodeCommit repositories.

## Extra Setup

TODO, add ansible playbooks
]

## Development

```
pip3 install ansible-lint
```