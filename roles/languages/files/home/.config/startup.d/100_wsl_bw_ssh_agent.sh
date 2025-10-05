#! /bin/bash

if [[ -z "${SSH_CLIENT}" ]]; then
  . ~/scripts/agent-bridge.sh
fi
