#! /bin/bash

export VAGRANT_WSL_ENABLE_WINDOWS_ACCESS="1"
export VAGRANT_DEFAULT_PROVIDER="hyperv"

# Needed until https://github.com/hashicorp/vagrant/issues/11085 is resolved
alias powershell="pwsh"
