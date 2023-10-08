#! /bin/bash

# shellcheck disable=SC1090

if [[ -d "${HOME}/.startup.d" ]]; then
  for i in "${HOME}"/.startup.d/*.sh; do
    if [ -r "${i}" ]; then
      . "${i}"
    fi
  done
  unset i
fi
