#! /bin/bash
# https://www.rebelpeon.com/bitwarden-ssh-agent-on-wsl2/
# https://blog.jkwmoore.dev/bitwarden-desktop-client-as-ssh-agent-with-wsl.html

# Ensure ~/.ssh directory exists with correct permissions
if [ ! -d "$HOME/.ssh" ]; then
  mkdir -m 700 "$HOME/.ssh"
fi

export SSH_AUTH_SOCK=$HOME/.ssh/agent.sock
mkdir --parents "$(dirname "$SSH_AUTH_SOCK")"
[ -S "$SSH_AUTH_SOCK" ] && rm --force "$SSH_AUTH_SOCK"
( setsid socat UNIX-LISTEN:"$SSH_AUTH_SOCK",fork EXEC:"npiperelay.exe -ei -s //./pipe/openssh-ssh-agent",nofork 2>>/tmp/agent-bridge.log & ) >/dev/null 2>&1
