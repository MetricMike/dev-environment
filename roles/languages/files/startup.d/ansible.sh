#! /bin/bash

# shellcheck disable=SC1091

MITOGEN_LOCATION=$(pip show mitogen | grep Location | awk '{print $2}')

export ANSIBLE_CALLBACKS_ENABLED="profile_roles, profile_tasks, timer"
export ANSIBLE_LOCALHOST_WARNING="False"
export ANSIBLE_STRATEGY_PLUGINS="${HOME}/.ansible/plugins/strategy:/usr/share/ansible/plugins/strategy:${MITOGEN_LOCATION}/ansible_mitogen/plugins/strategy"
export ANSIBLE_STRATEGY="mitogen_linear"

apd() {
  cd ~/projects/dev-environment || exit
  ansible-playbook developer.yml
  cd - || exit
  . "${HOME}/.bashrc"
}
