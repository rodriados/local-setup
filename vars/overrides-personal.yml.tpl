---
# Personal workspace setup automation.
# @file The personal profile installation variables.
# @author Rodrigo Siqueira <me@rodriados.com>
# @copyright 2026-present Rodrigo Siqueira

essentials:
  install: true

git:
  install: true
  user_name: "Your Name"
  user_email: "you@example.com"

terminal:
  fzf: true
  zoxide: true

dotfiles:
  install: true
  type: repository            # repository or archive
  src: "https://github.com/you/dotfiles.git"
  directory: "{{ ansible_user_home }}/.dotfiles"
  installation_command: script/setup.sh
  run_as_root: false

nvidia:
  driver_version: 580

extra_packages: []

drivers:
  - nvidia

softwares:
  - displaylink
  - docker
  - google-chrome
  - postman
  - spotify
  - vscode
