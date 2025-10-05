#! /bin/bash

# shellcheck disable=SC1091

export ASDF_DATA_DIR="${HOME}/.asdf"
pathmunge "${ASDF_DATA_DIR}/shims"

# Java
ASDF_JAVA_HOME=$(asdf where java)
export JAVA_HOME="${ASDF_JAVA_HOME}"
export JDK_HOME="${JAVA_HOME}"

# .NET
. "${HOME}/.asdf/plugins/dotnet/set-dotnet-env.bash"
pathmunge "${HOME}/.dotnet/tools" after
