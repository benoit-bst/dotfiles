[![GitHub release (latest by date)](https://img.shields.io/github/v/release/benoit-bst/dotfiles)](https://github.com/benoit-bst/dotfiles/tags)
[![GitHub Workflow Status](https://img.shields.io/github/workflow/status/benoit-bst/dotfiles/CI%20workflow)](https://github.com/benoit-bst/dotfiles/actions?query=workflow%3A%22CI+workflow%22)
![OS_version](https://img.shields.io/badge/OS-ubuntu%2020.04-yellowgreen)

# Personal work flow and tools

All the configuration is installed with
 [Red Hat Ansible](https://github.com/ansible/ansible) tool.

The main configuration is composed of : I3 + alacrity + Tmux + Zsh + Nvim (lazyvim)<br>
Available for debian/ubuntu

![config_screenshot](config_screenshot.png)

## Set up

Please create **vault_passwd** file at the root of the repository,
 with the vault password inside

Full installation.<br>
It consists in installing all packages and
 configuration files (User password is required for packages installation)

```bash
./install
```

Only update config file

``` bash
./install update
```

## Changelog

[Changelog](https://github.com/benoit-bst/dotfiles/blob/master/changelog.md)
