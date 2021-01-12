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

# Build environment for python
sudo apt -y install \
autoconf bison build-essential curl libbz2-dev libdb-dev libffi-dev \
libgdbm-dev libgdbm6 liblzma-dev libncurses5-dev libreadline-dev \
libsqlite3-dev libssl-dev libxml2-dev libxmlsec1-dev libyaml-dev \
llvm make tk-dev wget xz-utils zlib1g-dev

source ${HOME}/.bashrc
source ${HOME}/.startup.d/asdf.sh

asdf plugin-add python
asdf install python $(asdf latest python)
asdf global python $(asdf latest python)

# pip install -U pip wheel ansible mitogen
# Use this until https://github.com/dw/mitogen/pull/739 gets merged
# Lock to 2.9 until mitogen supports ansible 2.10
pip install -U pip wheel ansible~=2.9.0 git+https://github.com/MetricMike/mitogen.git@master

asdf reshim python

# Install python-apt package to venv (unclear why this is needed)
mkdir -p ${HOME}/projects
pushd ${HOME}/projects
git clone git://git.launchpad.net/python-apt &> /dev/null
cd python-apt
git checkout 2.1.3
sudo apt build-dep -y ./
python setup.py build
PYTHON_MAJ_MIN=$(asdf current python | awk '{print $2}' | awk -F \. '{print $1"."$2}')
ASDF_SITE_PACKAGES=$(asdf where python)/lib/python${PYTHON_MAJ_MIN}/site-packages/
cp -r build/lib.linux-x86_64-${PYTHON_MAJ_MIN}/* ${ASDF_SITE_PACKAGES}
popd

# Verify
ansible --version

exec ${SHELL} -l
