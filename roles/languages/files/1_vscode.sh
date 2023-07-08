#! /bin/bash

if [[ "$TERM_PROGRAM" == "vscode" ]]; then
  # shellcheck source=/dev/null
  . "$(code --locate-shell-integration-path bash)"
  export EDITOR=code
else
  export EDITOR=vim
fi
