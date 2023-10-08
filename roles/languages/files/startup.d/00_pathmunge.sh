#! /bin/bash

# Stolen from RHEL 9.2's /etc/profile
# Usage: pathmunge /path/to/add [after]
# prepends unless you specify "after"
pathmunge() {
  case ":${PATH}:" in
  *:"$1":*) ;;
  *)
    if [ "$2" = "after" ]; then
      PATH="${PATH}:$1"
    else
      PATH="$1:${PATH}"
    fi
    ;;
  esac
}
