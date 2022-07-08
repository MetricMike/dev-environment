#! /bin/bash

# https://github.com/microsoft/WSL/issues/5324
# Needed in at least 20277.1 to force a resync after suspend/hibernate
# https://github.com/microsoft/WSL/issues/8204
# was fixed but regression with win 11 beta push
sudo hwclock -s &> /dev/null
