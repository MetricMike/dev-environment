#! /bin/bash

export ANSIBLE_CALLBACKS_ENABLED="profile_roles, profile_tasks, timer, community.general.unixy"
export ANSIBLE_CACHE_PLUGIN="jsonfile"
export ANSIBLE_CACHE_PLUGIN_CONNECTION="${XDG_CACHE_HOME:-$HOME/.cache}/ansible-cache"
export ANSIBLE_LOCALHOST_WARNING="False"
export ANSIBLE_PIPELINING="True"
export ANSIBLE_USE_PERSISTENT_CONNECTIONS="True"

apd() {
  cd ~/projects/dev-environment || exit
  ansible-playbook developer.yml
  cd - || exit
  # shellcheck disable=SC1091
  . "${HOME}/.bashrc"
}
