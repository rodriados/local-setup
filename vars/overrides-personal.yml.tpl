---
# Personal workspace setup automation.
# @file The personal profile installation variables.
# @author Rodrigo Siqueira <me@rodriados.com>
# @copyright 2026-present Rodrigo Siqueira

enable_installation:
  git: true
  dotfiles: true
  #ohmyzsh: true
  nodejs: true
  essentials: true
  cuda: true
  haskell: true
  softwares: true

git:
  user_name: "Your Name"
  user_email: "you@example.com"

dotfiles:
  type: repository # repository, archive
  src: "git@github.com:you/dotfiles.git"
  directory: "{{ ansible_user_home }}/.dotfiles"
  installation_command: scripts/setup.sh
  run_as_root: false

cuda:
  version: auto

extra_packages: []

softwares:
  - google-chrome
  - postman
  - spotify
  - vscode
