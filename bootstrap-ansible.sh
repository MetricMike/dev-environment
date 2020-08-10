#! /bin/bash
# This script should be idempotent and safe to run multiple times

# Enable universe repo
RELEASE=$(lsb_release -sc)
sudo add-apt-repository "deb http://archive.ubuntu.com/ubuntu ${RELEASE} universe multiverse"
sudo add-apt-repository "deb http://archive.ubuntu.com/ubuntu ${RELEASE}-updates universe multiverse"

# Install asdf and only the bare minimum required for ansible 3
sudo apt -y update
sudo apt -y upgrade
sudo apt -y dist-upgrade
sudo apt -y autoremove
sudo apt -y autoclean

sudo apt -y install curl git

if [[ -d "${HOME}/.asdf" ]];
then
    asdf update
else
    git clone https://github.com/asdf-vm/asdf.git ${HOME}/.asdf
fi

# I don't know and I don't care to learn how to do multiline grep search/replace
# so I'm just stealing from the /etc/profile & /etc/profile.d strategy
mkdir -p ${HOME}/.startup.d
mkdir -p ${HOME}/.shutdown.d

# cat <<-'EOF' > ${HOME}/.startup.d/ssh.sh
# #! /bin/bash
#
# if [[ ! -S ${HOME}/.ssh/ssh_auth_sock ]]; then
#     eval `ssh-agent`
#     ln -sf "$SSH_AUTH_SOCK" ${HOME}/.ssh/ssh_auth_sock
# fi
#
# export SSH_AUTH_SOCK=${HOME}/.ssh/ssh_auth_sock
# ssh-add -l > /dev/null || ssh-add ${HOME}/.ssh/mkey_big
#
# EOF

# cat <<-'EOF' > ${HOME}/.shutdown.d/ssh.sh
# #! /bin/bash
#
# if [[ -n "$SSH_AUTH_SOCK" ]] ; then
#   eval `/usr/bin/ssh-agent -k`
#   rm ${HOME}/.ssh/ssh_auth_sock
# fi
#
# EOF

cat <<-'EOF' > ${HOME}/.startup.d/asdf.sh
#! /bin/bash

source ${HOME}/.asdf/asdf.sh
source ${HOME}/.asdf/completions/asdf.bash

EOF

cat <<-'EOF' > ${HOME}/.startup.sh
#! /bin/bash

if [[ -d ${HOME}/.startup.d ]]; then
    for i in ${HOME}/.startup.d/*.sh; do
        if [ -r $i ]; then
            source $i
        fi
    done
    unset i
fi

EOF

STARTUP_INIT='source ${HOME}/.startup.sh'
grep -qxF "${STARTUP_INIT}" ${HOME}/.bashrc || \
echo -e "${STARTUP_INIT}" >> ${HOME}/.bashrc

cat <<-'EOF' > ${HOME}/.shutdown.sh
#! /bin/bash

if [[ -d ${HOME}/.shutdown.d ]]; then
    for i in ${HOME}/.shutdown.d/*.sh; do
        if [ -r $i ]; then
            source $i
        fi
    done
    unset i
fi

EOF

SHUTDOWN_INIT='source ${HOME}/.shutdown.sh'
grep -qxF "${SHUTDOWN_INIT}" ${HOME}/.bash_logout || \
echo -e "${SHUTDOWN_INIT}" >> ${HOME}/.bash_logout

# Build environment for python
sudo apt -y install make build-essential libssl-dev zlib1g-dev libbz2-dev \
libreadline-dev libsqlite3-dev wget curl llvm libncurses5-dev xz-utils tk-dev \
libxml2-dev libxmlsec1-dev libffi-dev liblzma-dev

source ${HOME}/.bashrc
source ${HOME}/.startup.d/asdf.sh

asdf plugin-add python
asdf install python latest:3
asdf global python $(asdf latest python)

pip install -U pip ansible

asdf reshim python

# Verify
ansible --version

exec ${SHELL} -l
