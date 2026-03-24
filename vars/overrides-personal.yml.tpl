---
# Personal workspace setup automation.
# @file The personal profile installation variables.
# @author Rodrigo Siqueira <me@rodriados.com>
# @copyright 2026-present Rodrigo Siqueira

enable_installation:
  git: true
  dotfiles: true
  essentials: true
  softwares: true

settings:
  git:
    user_name: "Your Name"
    user_email: "you@example.com"

  dotfiles:
    repository: https://github.com/you/dotfiles.git
    installation_command: ./setup.sh

  packages: []

  softwares: []
