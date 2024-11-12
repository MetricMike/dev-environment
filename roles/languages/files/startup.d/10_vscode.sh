#! /bin/bash

# shellcheck disable=SC1090

if [[ "${TERM_PROGRAM}" == "vscode" ]]; then
  . "$(code --locate-shell-integration-path bash)"
  export EDITOR=code
else
  export EDITOR=vim
fi
