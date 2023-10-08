#! /bin/bash

# Loop over each line of the .tool-versions file
while read -r line; do
  IFS=' ' read -r -a tool_and_version <<<"${line}"
  # Split out the tool name and versions
  tool_name="${tool_and_version[0]}"
  global_version="${tool_and_version[1]}"

  # Loop over each version of the tool name
  for version in $(asdf list "${tool_name}"); do
    # When version not in `global_versions` array from .tool-versions file
    if [[ ! "${global_version}" == "${version}" ]]; then
      # Remove the version here if you want
      echo "${tool_name} version ${version} not found in .tool-versions"
      asdf uninstall "${tool_name}" "${version}"
    fi
  done
done <"${HOME}/.tool-versions"
