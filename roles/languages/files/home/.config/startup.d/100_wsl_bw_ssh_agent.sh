#! /bin/bash

if [[ -z "${SSH_CLIENT}" ]]; then
  # shellcheck disable=SC1090
  . ~/scripts/agent-bridge.sh
fi
