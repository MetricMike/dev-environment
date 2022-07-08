#! /bin/bash

export GPG_TTY=$(tty)
alias g=git
__git_complete g __git_main
