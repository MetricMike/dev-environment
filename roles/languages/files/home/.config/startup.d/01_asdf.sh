#! /bin/bash

# shellcheck disable=SC1091

export ASDF_DATA_DIR="${HOME}/.asdf"
pathmunge "${ASDF_DATA_DIR}/shims"

# Java
. "${HOME}/.asdf/plugins/java/set-java-home.bash"

# .NET
. "${HOME}/.asdf/plugins/dotnet/set-dotnet-env.bash"
pathmunge "${HOME}/.dotnet/tools" after

# NodeJS
export ASDF_NODEJS_LEGACY_FILE_DYNAMIC_STRATEGY=latest_installed
