#! /bin/bash

# shellcheck disable=SC1091

. "${HOME}/.asdf/asdf.sh"

# Java
ASDF_JAVA_HOME=$(asdf where java)
export JAVA_HOME="${ASDF_JAVA_HOME}"
export JDK_HOME="${JAVA_HOME}"

# .NET
. "${HOME}/.asdf/plugins/dotnet-core/set-dotnet-home.bash"
pathmunge "${HOME}/.dotnet/tools" after

# DirEnv
asdf direnv setup --shell bash --version latest &>/dev/null
