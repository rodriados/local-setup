#!/bin/sh
# Personal workspace setup automation.
# @file The initial setup and workspace installation script.
# @author Rodrigo Siqueira <me@rodriados.com>
# @copyright 2026-present Rodrigo Siqueira
set -e

OSNAME=$(uname -s)
USERNAME=$(whoami)
SCRIPTPATH=$(cd -- "$(dirname "$0")" >/dev/null 2>&1; pwd -P)
PROFILE="$1"

# Auxiliary function to bail out with a message.
# @param $1 The informative message to bail out of the script with.
# @return Never returns and kills execution.
die () {
  echo "$1" >&2
  exit 1
}

# Checks the OS that we are running on and bails out if unknown.
# Running on an unknown OS might cause potentially dangerous unexpected behavior.
if ! echo "$OSNAME" | grep -E -q "^(Darwin|Linux)$"; then
  die "Current OS is not supported."
fi

# Checks whether the script is running as root and bails out if so.
# Whenever root privileges are needed, it will be asked during installation. Doing
# so for the whole process is dangerous and may cause issues.
if [ "$(id -u)" -eq 0 ]; then
  die "Please, do not start installation as root."
fi

cd "$SCRIPTPATH"

# Select the installation profile to use.
# By default, the "minimal" profile is selected, which will lead to the installation
# of the base minimum required to use the workstation.
if [ -z "$PROFILE" ] && [ -t 0 ]; then
  read -p "Inform the profile to install [minimal]: " PROFILE
fi

PROFILE="${PROFILE:-minimal}"
PROFILE_OVERRIDES_TEMPLATE="playbooks/vars/overrides-$PROFILE.yml.tpl"
PROFILE_OVERRIDES_FILE="playbooks/overrides.yml"

if [ ! -f "$PROFILE_OVERRIDES_TEMPLATE" ]; then
  die "Unknown profile: $PROFILE"
fi

if [ ! -f "$PROFILE_OVERRIDES_FILE" ]; then
  # Copy the override variables file according to selected profile.
  # This file contains some variables that may be overridden according to the profile
  # that the user wants to install. This is also a file that can be edited to tweak,
  # enable or disable specific modules, programs or routines during setup.
  cp "$PROFILE_OVERRIDES_TEMPLATE" "$PROFILE_OVERRIDES_FILE"

  # Open the variable override file in editor.
  # Allow the user to have a chance to edit and configure the setup before starting
  # the installation of anything that might change the system.
  if [ -t 0 ]; then
    ${VISUAL:-${EDITOR:-vi}} "$PROFILE_OVERRIDES_FILE"
  fi
fi

# Checks if ansible is installed or install it if needed.
# It is required that python and pip are installed to be able to install ansible
# if needed. As python installation depends on the OS, the user needs to do it.
if ! command -v "ansible" >/dev/null 2>&1; then
  if command -v "pipx" >/dev/null 2>&1; then
    pipx install --include-deps ansible
    pipx ensurepath
    PATH="$PATH:$HOME/.local/bin"
  else
    die "Setup requires pipx to be installed in the system."
  fi
fi

# Start installation process for the selected profile.
# We use ansible to guide the installation process, but we must first verify whether
# it is itself installed and do so if needed.
ansible-playbook playbooks/main.yml -f 1 -t $PROFILE
