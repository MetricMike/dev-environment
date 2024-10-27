#! /bin/bash

# shellcheck disable=SC1090

if [[ "${TERM_PROGRAM}" == "vscode" ]]; then
  # TODO: broken in 1.94.0 will be fixed in November 2024 release (1.95.0?) https://github.com/microsoft/vscode/issues/230584
  # . "$(code --locate-shell-integration-path bash)"
  export EDITOR=code
else
  export EDITOR=vim
fi
