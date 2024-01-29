#! /bin/bash

alias g=git
__git_complete g __git_main

# unset GITHUB_TOKEN from gh's process environment and run gh command.
# see https://stackoverflow.com/a/41749660 & https://github.com/cli/cli/issues/3799 for more.
# shellcheck disable=SC2139
alias gh="env -u GITHUB_TOKEN gh $1"

set_gh_token() {
  local gh_token

  gh_token=$(gh auth token)
  export GITHUB_API_TOKEN=${gh_token}
}
