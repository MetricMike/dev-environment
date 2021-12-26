#! /bin/bash
# This script should be idempotent and safe to run multiple times

# Enable universe repo
RELEASE=$(lsb_release -sc)
sudo add-apt-repository "deb http://archive.ubuntu.com/ubuntu ${RELEASE} universe multiverse"
sudo add-apt-repository "deb http://archive.ubuntu.com/ubuntu ${RELEASE}-updates universe multiverse"

# Install asdf and only the bare minimum required for ansible
sudo apt -y update
sudo apt -y upgrade
sudo apt -y dist-upgrade
sudo apt -y autoremove
sudo apt -y autoclean

sudo apt -y install curl git tree jq unzip dirmngr gpg

if [[ -d "${HOME}/.asdf" ]];
then
    asdf update
    asdf plugin update --all
else
    git clone https://github.com/asdf-vm/asdf.git ${HOME}/.asdf
fi

# I don't know and I don't care to learn how to do multiline grep search/replace
# so I'm just stealing from the /etc/profile & /etc/profile.d strategy
mkdir -p ${HOME}/.startup.d
mkdir -p ${HOME}/.shutdown.d

# gpg import /mnt/i/Users/Michael/Dropbox/mGPG_private.key
# cp /mnt/i/Users/Michael/Dropbox/mkey_big ~/.ssh/id_rsa ; chmod 0600 ~/.ssh/id_rsa
# cp /mnt/i/Users/Michael/Dropbox/mkey_big.pub ~/.ssh/id_rsa.pub

cat <<-'EOF' > ${HOME}/.startup.d/0_asdf.sh
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

cat <<-'EOF' > /etc/sudoers.d/mm_pwdless

metricmike ALL=NOPASSWD: ALL

EOF

# Build environment for python
sudo apt -y install \
autoconf bison build-essential curl libbz2-dev libdb-dev libffi-dev \
libgdbm-dev libgdbm6 liblzma-dev libncurses5-dev libreadline-dev \
libsqlite3-dev libssl-dev libxml2-dev libxmlsec1-dev libyaml-dev \
llvm make tk-dev wget xz-utils zlib1g-dev

source ${HOME}/.bashrc
source ${HOME}/.startup.d/0_asdf.sh

asdf plugin-add python
asdf install python $(asdf latest python)
asdf global python $(asdf latest python)

# Update pip components first
pip install -U pip wheel
pip install -U \
`#mitogen 0.2.x supports ansible < 2.10` \
`#mitogen 0.3.0 supports ansible = 2.10` \
`#mitogen 0.3.1 supports ansible < 2.12` \
ansible~=2.10 \
mitogen~=0.3.0 \
`# ASDF python can't see the python-apt system package, so install it directly` \
`# pypi is 0.7.8, we need at least 2.1.3+, but main's fairly stable` \
git+https://salsa.debian.org/apt-team/python-apt.git@main

asdf reshim python

# Verify
ansible --version

echo -e "\nFinished bootstrapping."
echo -e "Please exit and restart your shell...\n"
