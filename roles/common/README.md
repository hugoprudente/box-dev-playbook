# Ansible Role: common

Shared bootstrap for the [box-dev-playbook](../../README.md): sets architecture/OS facts used by other roles, creates base home directories, configures Red Hat PATH/sudoers for `/usr/local/bin`, detects GitHub reachability for offline installs, and installs selected shell tooling on Linux.

This role runs on every host in [main.yml](../../main.yml) (`tags: always`) before OS-specific roles.

For how `common` fits with APT, DNF, and Homebrew under the `base` tag, see the playbook [base install matrix](../../docs/base-install-matrix.md) and [base roles](../../docs/base-roles.md).

## Requirements

- Ansible with fact gathering enabled (`gather_facts: true`).
- **Privilege escalation** (`become: true`) for Red Hat profile/sudoers changes, binary installs under `/usr/local/bin`, and funcoeszz.
- **Network** (when installing tools):
  - Destination can reach `https://github.com` (used to set `common_offline`).
  - Online Starship: `https://starship.rs/install.sh`.
  - Online/offline Starship and direnv: GitHub releases (offline path may use the GitHub API from the **controller**).
  - Optional funcoeszz: `https://funcoeszz.net`.

## Supported platforms

| Platform | Behavior |
|----------|----------|
| **Debian family** | Full Linux path: offline detection, Starship, direnv |
| **Red Hat family** | Same as Debian, plus `/etc/profile.d/local-bin.sh` and `sudoers` `secure_path` |
| **Darwin (macOS)** | Facts (`common_arch`, `common_os`) and `~/.logs` / `~/.config` only. Starship and direnv are **not** installed here; use the Homebrew role and [default.config.yml](../../default.config.yml). |

## What this role installs and configures

This role does **not** manage `apt`/`dnf` package lists (see the `apt` and `dnf` roles). It handles the items below.

| Item | Condition | Result |
|------|-----------|--------|
| **Directories** | Always | `~/.logs`, `~/.config` |
| **starship** | `common_install_starship` and Debian/RedHat | Binary in `common_bin_dir` (default `/usr/local/bin`). Online: official install script. Offline: release tarball fetched on controller, copied to host |
| **direnv** | `common_install_direnv` and Debian/RedHat | Binary in `common_bin_dir`. Online: download on host. Offline: download on controller, copy to host |
| **funcoeszz** | `configure_funcoeszz` | Script at `/usr/local/bin/funcoeszz` from funcoeszz.net |
| **PATH (login shells)** | Red Hat family | `/etc/profile.d/local-bin.sh` prepends `/usr/local/bin` when missing |
| **sudo secure_path** | Red Hat family | `Defaults secure_path` includes `/usr/local/bin` |

## Role variables

Defaults are in `defaults/main.yml`. Play-level overrides often come from [default.config.yml](../../default.config.yml).

| Variable | Default | Description |
|----------|---------|-------------|
| `common_bin_dir` | `/usr/local/bin` | Install location for Starship and direnv binaries |
| `common_install_starship` | `true` | Install Starship on Debian/RedHat |
| `common_install_direnv` | `true` | Install direnv on Debian/RedHat |
| `common_starship_version` | `"1.26.0"` | Fallback Starship version when GitHub API is unreachable from the controller (offline install) |
| `common_direnv_version` | `"2.37.1"` | Fallback direnv version when GitHub API is unreachable from the controller |
| `common_starship_repo` | `https://github.com/starship/starship` | Base URL for Starship release assets |
| `common_direnv_repo` | `https://github.com/direnv/direnv` | Base URL for direnv release assets |
| `configure_funcoeszz` | `false` (in `default.config.yml`) | Enable funcoeszz install task |
| `funcoeszz_version` | `"21.1"` (in `default.config.yml`) | funcoeszz version to install |

`common_offline` is **not** a user input: it is set at runtime when the host cannot reach `https://github.com`, which switches Starship/direnv to controller-assisted downloads.

## Facts set (for other roles)

| Fact | Values | Used by |
|------|--------|---------|
| `common_arch` | `arm64` or `amd64` | e.g. `kubernetes` role client downloads |
| `common_os` | `linux` or `darwin` | e.g. `kubernetes` role client downloads |
| `common_offline` | `true` / `false` | Starship and direnv install strategy |

## Idempotency

**Yes.** Installs are skipped when `starship --version` or `direnv version` succeed; funcoeszz is re-fetched when the installed version does not match `funcoeszz_version`. The Starship install script uses `creates` on the target binary.

## Rollback

There is **no** automated uninstall. To remove tooling or config, delete the binaries under `common_bin_dir`, remove `/usr/local/bin/funcoeszz` if used, and revert Red Hat changes to `/etc/profile.d/local-bin.sh` and `sudoers` manually if needed.

## Dependencies

None (`meta/main.yml` lists no role dependencies).

## Example playbook

```yaml
---
- name: Configure SRE Box
  hosts: all
  gather_facts: true

  vars_files:
    - default.config.yml

  roles:
    - role: common
      tags: ['always']
```

Example overrides:

```yaml
  roles:
    - role: common
      vars:
        common_install_starship: true
        common_install_direnv: false
        configure_funcoeszz: true
        funcoeszz_version: "21.1"
```

## License

Same as the parent [box-dev-playbook](../../README.md) repository.
