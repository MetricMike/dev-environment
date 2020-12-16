#! /bin/bash

# https://github.com/microsoft/WSL/issues/5324
# Needed in at least 20277.1 to force a resync after suspend/hibernate

wsl.exe -u root hwclock -s &> /dev/null
