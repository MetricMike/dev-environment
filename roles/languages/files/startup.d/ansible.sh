#! /bin/bash

export ANSIBLE_CALLBACKS_ENABLED="profile_roles, profile_tasks, timer"
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
