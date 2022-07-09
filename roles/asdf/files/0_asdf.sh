#! /bin/bash

source ${HOME}/.asdf/asdf.sh
source ${HOME}/.asdf/completions/asdf.bash
export JAVA_HOME=$(asdf where java)
export JDK_HOME=${JAVA_HOME}
source ${HOME}/.asdf/plugins/dotnet-core/set-dotnet-home.bash

asdf direnv setup --shell bash --version latest &> /dev/null
