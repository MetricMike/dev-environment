#! /bin/bash

MITOGEN_LOCATION=$(pip show mitogen | grep Location | awk '{print $2}')

export ANSIBLE_CALLBACK_PLUGINS="${HOME}/.ansible/plugins/strategy:/usr/share/ansible/plugins/strategy:$(python -m ara.setup.callback_plugins)"
export ANSIBLE_CALLBACKS_ENABLED="profile_roles, profile_tasks, timer, community.general.unixy"
export ANSIBLE_CACHE_PLUGIN="jsonfile"
export ANSIBLE_CACHE_PLUGIN_CONNECTION="${XDG_CACHE_HOME:-$HOME/.cache}/ansible-cache"
export ANSIBLE_STRATEGY_PLUGINS="${HOME}/.ansible/plugins/strategy:/usr/share/ansible/plugins/strategy:${MITOGEN_LOCATION}/ansible_mitogen/plugins/strategy"
export ANSIBLE_STRATEGY="mitogen_linear"
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
