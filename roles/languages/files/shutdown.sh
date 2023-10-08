#! /bin/bash

# shellcheck disable=SC1090

if [[ -d "${HOME}/.shutdown.d" ]]; then
  for i in "${HOME}"/.shutdown.d/*.sh; do
    if [ -r "${i}" ]; then
      . "${i}"
    fi
  done
  unset i
fi
