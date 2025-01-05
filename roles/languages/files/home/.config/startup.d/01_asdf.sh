#! /bin/bash

# shellcheck disable=SC1091

. "${HOME}/.asdf/asdf.sh"

# Java
ASDF_JAVA_HOME=$(asdf where java)
export JAVA_HOME="${ASDF_JAVA_HOME}"
export JDK_HOME="${JAVA_HOME}"

# .NET
. "${HOME}/.asdf/plugins/dotnet/set-dotnet-env.bash"
pathmunge "${HOME}/.dotnet/tools" after

# DirEnv
export DIRENV_LOG_FORMAT=
source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/bashrc"
