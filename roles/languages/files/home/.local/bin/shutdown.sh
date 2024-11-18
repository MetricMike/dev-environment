#! /bin/bash

# shellcheck disable=SC1090

if [[ -d "${HOME}/.config/shutdown.d" ]]; then
  for i in "${HOME}"/.config/shutdown.d/*.sh; do
    if [ -r "${i}" ]; then
      . "${i}"
    fi
  done
  unset i
fi
