#! /bin/bash

# Install anyenv and only the bare minimum required for ansible 3
# This script should be idempotent and safe to run multiple times

sudo apt -y update
sudo apt -y upgrade
sudo apt -y dist-upgrade
sudo apt -y autoremove
sudo apt -y autoclean

if [ ! -d "~/.asdf" ]
then
    git clone https://github.com/asdf-vm/asdf.git ~/.asdf 2> /dev/null
fi

cd ~/.asdf
git fetch --all
git checkout "$(git describe --abbrev=0 --tags)"

# I don't know and I don't care to learn how to do multiline grep search/replace so
# I'm just stealing from the /etc/profile & /etc/profile.d strategy
mkdir -p ~/.startup.d
mkdir -p ~/.shutdown.d

if [ ! -e ~/.startup.d/ssh.sh ]
then
    cat <<-'EOF' > ~/.startup.d/ssh.sh
#! /bin/bash

if [ ! -S ~/.ssh/ssh_auth_sock ]; then
    eval `ssh-agent`
    ln -sf "$SSH_AUTH_SOCK" ~/.ssh/ssh_auth_sock
fi

export SSH_AUTH_SOCK=~/.ssh/ssh_auth_sock
ssh-add -l > /dev/null || ssh-add ~/.ssh/mkey_big

EOF
fi

if [ ! -e ~/.shutdown.d/ssh.sh ]
then
    cat <<-'EOF' > ~/.shutdown.d/ssh.sh
#! /bin/bash

if [ -n "$SSH_AUTH_SOCK" ] ; then
  eval `/usr/bin/ssh-agent -k`
  rm ~/.ssh/ssh_auth_sock
fi

EOF
fi

if [ ! -e ~/.startup.d/asdf.sh ]
then
    cat <<-'EOF' > ~/.startup.d/asdf.sh
#! /bin/bash

source ${HOME}/.asdf/asdf.sh
source ${HOME}/.asdf/completions/asdf.bash

EOF
fi

if [ ! -e ~/.startup.sh ]
then
    cat <<-'EOF' > ~/.startup.sh
#! /bin/bash

if [ -d ~/.startup.d ]; then
    for i in ~/.startup.d/*.sh; do
        if [ -r $i ]; then
            source $i
        fi
    done
    unset i
fi

EOF
fi

STARTUP_INIT='source ~/.startup.sh'
grep -qxF "${STARTUP_INIT}" ~/.bashrc || echo -e "${STARTUP_INIT}" >> ~/.bashrc

if [ ! -e ~/.shutdown.sh ]
then
    cat <<-'EOF' > ~/.shutdown.sh
#! /bin/bash

if [ -d ~/.shutdown.d ]; then
    for i in ~/.shutdown.d/*.sh; do
        if [ -r $i ]; then
            source $i
        fi
    done
    unset i
fi

EOF
fi

SHUTDOWN_INIT='source ~/.shutdown.sh'
grep -qxF "${SHUTDOWN_INIT}" ~/.bash_logout || echo -e "${SHUTDOWN_INIT}" >> ~/.bash_logout

source ~/.bashrc

# Build environment for python
sudo apt -y install make build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm-4.0-dev llvm-4.0-runtime \
libncurses5-dev libncursesw5-dev xz-utils tk-dev libffi-dev liblzma-dev \
python-openssl git

asdf plugin-add python
asdf install python 3.7.3
asdf global python 3.7.3

pip install -U pip
pip install -U ansible

asdf reshim python

# Verify
ansible --version
