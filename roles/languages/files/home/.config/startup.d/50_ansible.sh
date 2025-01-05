#! /bin/bash

export MITOGEN_LOCATION=$(pip show mitogen | grep Location | awk '{print $2}')
export ARA_LOCATION=$(python -m ara.setup.callback_plugins)

export ANSIBLE_CACHE_PLUGIN_CONNECTION="${XDG_CACHE_HOME:-$HOME/.cache}/ansible-cache"

export ANSIBLE_CALLBACK_PLUGINS="${HOME}/.ansible/plugins/strategy:/usr/share/ansible/plugins/strategy:${ARA_LOCATION}"
export ANSIBLE_STRATEGY_PLUGINS="${HOME}/.ansible/plugins/strategy:/usr/share/ansible/plugins/strategy:${MITOGEN_LOCATION}/ansible_mitogen/plugins/strategy"

apd() {
  cd "${HOME}/projects/dev-environment" || exit
  ansible-playbook developer.yml
  cd - || exit
  # shellcheck disable=SC1091
  . "${HOME}/.bashrc"
}
