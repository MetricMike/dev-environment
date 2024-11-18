#! /bin/bash

# shellcheck disable=SC1090

if [[ -d "${HOME}/.config/startup.d" ]]; then
  for i in "${HOME}"/.config/startup.d/*.sh; do
    if [ -r "${i}" ]; then
      . "${i}"
    fi
  done
  unset i
fi
