# Sys / Dev / Ops Development Ansible Playbook

[![CI][badge-gh-actions]][link-gh-actions]

This playbook installs and configures most of the software I use on my workstations for development, sysadmin, SRE, DevOps and Fun!

Totally inspired by [mac-dev-playbook](https://github.com/geerlingguy/mac-dev-playbook) by Geerlingguy!

## Installation

### OSX Only

1. Ensure Apple's command line tools are installed (`xcode-select --install` to launch the installer).
1. Continue with the steps for Linux and Windows (WSL)

### Linux & Windows (WSL)
1. [Install Ansible](http://docs.ansible.com/intro_installation.html).
1. Clone this repository to your local drive.
1. Run `$ ansible-galaxy install -r requirements.yml` inside this directory to install required Ansible roles.
1. Run `ansible-playbook main.yml -i inventory --ask-become-pass` inside this directory. Enter your account password when prompted.

> Note: If some Homebrew commands fail, you might need to agree to Xcode's license or fix some other Brew issue. Run `brew doctor` to see if this is the case.

### Running a specifi on Window (WSL)

Due to WSL mount the */home/user* as */mnt/c* you will face **world writable** directory issue, to fix it just export the ANSIBLE_CONFIG environment variable.

```
export ANSIBLE_CONFIG=`pwd`/ansible.cfg
```

### Running a specific set of tagged tasks

You can filter which part of the provisioning process to run by specifying a set of tags using `ansible-playbook`'s `--tags` flag. The tags available are `dotfiles`, `homebrew`.

    ansible-playbook main.yml -i inventory -K --tags "dotfiles,homebrew"

## Overriding Defaults

Not everyone's development environment and preferred software configuration is the same.

So you can customize your one using as base `default.config.yml` by creating a `config.yml` file and changing to your taste!

## Included Applications / Configuration (Default)

* [x] Ansible 

## Testing the Playbook

Use the [Mac OS X VirtualBox VM](https://github.com/geerlingguy/dev-osx-virtualbox-vm).

Additionally, this project is [continuously tested on GitHub Actions' macOS infrastructure](https://github.com/hugoprudente/box-dev-playbook/actions?query=workflow%3ACI).

## Troubleshoot 

### GPG Signed commits

If you are using WSL you will need to export this, to type the passphrase of your commit or it will fail with `error: gpg failed to sign the data. fatal: failed to write commit object\`

```
export GPG_TTY=$(tty)
```


## Author

[Hugo Prudente](hugo.kenshin@gmail.com)

[badge-gh-actions]: https://github.com/hugoprudente/box-dev-playbook/workflows/CI/badge.svg?event=push
[link-gh-actions]: https://github.com/hugoprudente/box-dev-playbook/actions?query=workflow%3ACI
