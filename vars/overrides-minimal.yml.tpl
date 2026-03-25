---
# Personal workspace setup automation.
# @file The minimal profile installation variables.
# @author Rodrigo Siqueira <me@rodriados.com>
# @copyright 2026-present Rodrigo Siqueira

enable_installation:
  git: true
  dotfiles: true
  #ohmyzsh: true
  nodejs: true
  essentials: true

git:
  user_name: "Your Name"
  user_email: "you@example.com"

dotfiles:
  repository: https://github.com/you/dotfiles.git
  directory: "{{ ansible_user_home }}/.dotfiles"
  installation_command: setup.sh

extra_packages: []
