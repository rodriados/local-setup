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
  type: repository # repository or archive
  src: "https://github.com/you/dotfiles.git"
  directory: "{{ ansible_user_home }}/.dotfiles"
  installation_command: script/setup.sh
  run_as_root: false

extra_packages: []
