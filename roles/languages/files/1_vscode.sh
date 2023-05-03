#! /bin/bash

if [[ "$TERM_PROGRAM" == "vscode" ]]; then
  # shellcheck source=/dev/null
  source "$(code --locate-shell-integration-path bash)"
fi
