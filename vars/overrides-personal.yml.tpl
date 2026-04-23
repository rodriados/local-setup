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

dotfiles:
  install: true
  type: repository # repository or archive
  src: "https://github.com/you/dotfiles.git"
  directory: "{{ ansible_user_home }}/.dotfiles"
  installation_command: script/setup.sh
  run_as_root: false

cuda:
  install: true
  version: latest

extra_packages: []

softwares:
  - google-chrome
  - postman
  - spotify
  - vscode
