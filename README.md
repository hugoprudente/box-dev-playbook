# Sys / Dev / Ops Development Ansible Playbook

[![CI][badge-gh-actions]][link-gh-actions]

This playbook installs and configures most of the software I use on my workstations for development, sysadmin, SRE, DevOps and Fun!

Totally inspired by [mac-dev-playbook](https://github.com/geerlingguy/mac-dev-playbook) by Geerlingguy!

## Installation

### OSX Only

1. Install the Apple's command line tools

```bash
xcode-select --install
```

### Window (WSL) only

Due to WSL mount the */home/user* as */mnt/c* you will face **world writable** directory issue, to fix it just export the ANSIBLE_CONFIG environment variable.

```
export ANSIBLE_CONFIG=`pwd`/ansible.cfg
```

1. Continue with the steps for Linux and Windows (WSL)

### Linux & Windows (WSL)

1. [Install Ansible](http://docs.ansible.com/intro_installation.html). (This is prepared to work with ansible-base/core)

Or run the script below to install a `venv` with the latest `python3` available in your system and install `ansible-2.12.10`

```bash
bash scripts/bootstra.sh env

# or

ANSIBLE_VERSION=2.12.10 bash scripts/bootstrap.sh env
```

1. Clone this repository to your local drive.

```bash
git clone https://github.com/hugoprudente/box-dev-playbook.git
```

1. Install the `ansible-galaxy` dependencies

```bash
ansible-galaxy install -r requirements.yml --force-with-deps
```

1. Run the the setup playbook. Enter your account password when prompted.

```bash 
ansible-playbook main.yml -i inventory --ask-become-pass
```

> Note: If some Homebrew commands fail, you might need to agree to Xcode's license or fix some other Brew issue. Run `brew doctor` to see if this is the case.

### Running a specific set of tagged tasks

You can filter which part of the provisioning process to run by specifying a set of tags using `ansible-playbook`'s `--tags` flag. Examples: `base` (core OS packages and macOS setup), `dotfiles`, `homebrew`, `apt`, `dnf`.

```bash
ansible-playbook main.yml -i inventory -K --tags "base"
ansible-playbook main.yml -i inventory -K --tags "dotfiles,homebrew"
```

## Overriding Defaults

Not everyone's development environment and preferred software configuration is the same.

So you can customize your one using as base `default.config.yml` by creating a `config.yml` file and changing to your taste!

## Included Applications / Configuration (Default)

Base provisioning (`common` + roles tagged `base` in `main.yml`) installs the default CLI tools, Homebrew formulae/casks, and Mac App Store apps defined in `default.config.yml`.

- [Base roles](docs/base-roles.md) — what each role does and which variables define packages
- [Base install matrix](docs/base-install-matrix.md) — per-OS ✅ / ❌ / ⚠️ coverage for `common` and `base` defaults

Optional roles (see `default.config.yml`): **kubernetes** (kind, clusterctl, cilium+hubble), **languages** (Node.js latest), **ai** ([skills repos](roles/ai/README.md)), **containerization** (Docker Compose / podman-compose), **remote-vpn** ([WireGuard server](roles/remote-vpn/README.md), off by default).

## Testing the Playbook

Use the [Mac OS X VirtualBox VM](https://github.com/geerlingguy/macos-virtualbox-vm)

Additionally, this project is [continuously tested on GitHub Actions' macOS infrastructure](https://github.com/hugoprudente/box-dev-playbook/actions?query=workflow%3ACI).

## Troubleshoot

### GPG Signed commits

If you are using WSL you will need to export this, to type the passphrase of your commit or it will fail with `error: gpg failed to sign the data. fatal: failed to write commit object\`

```
export GPG_TTY=$(tty)
```


## Author

[Hugo Prudente](hugo.kenshin+github@gmail.com)

[badge-gh-actions]: https://github.com/hugoprudente/box-dev-playbook/workflows/CI/badge.svg?event=push
[link-gh-actions]: https://github.com/hugoprudente/box-dev-playbook/actions?query=workflow%3ACI
