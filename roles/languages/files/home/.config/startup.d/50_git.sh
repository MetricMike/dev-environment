#! /bin/bash

alias g=git
complete -o bashdefault -o default -o nospace -F __git_wrap__git_main g

# unset GITHUB_TOKEN from gh's process environment and run gh command.
# see https://stackoverflow.com/a/41749660 & https://github.com/cli/cli/issues/3799 for more.
# shellcheck disable=SC2139
alias gh="env -u GITHUB_TOKEN gh $1"

set_gh_token() {
  local gh_token

  gh_token=$(gh auth token)
  export GITHUB_API_TOKEN=${gh_token}
}
