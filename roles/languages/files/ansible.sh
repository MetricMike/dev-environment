#! /bin/bash

MITOGEN_LOCATION=$(pip show mitogen | grep Location | awk '{print $2}')

export ANSIBLE_CALLBACKS_ENABLED="profile_roles, profile_tasks, timer"
export ANSIBLE_LOCALHOST_WARNING="False"
export ANSIBLE_STRATEGY_PLUGINS="~/.ansible/plugins/strategy:/usr/share/ansible/plugins/strategy:${MITOGEN_LOCATION}/ansible_mitogen/plugins/strategy"
export ANSIBLE_STRATEGY="mitogen_linear"
