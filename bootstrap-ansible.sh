#! /bin/bash

# shellcheck disable=SC1091
# This script should be idempotent and safe to run multiple times

# Enable universe repo
RELEASE=$(lsb_release -sc)
sudo add-apt-repository -y "deb http://archive.ubuntu.com/ubuntu ${RELEASE} universe multiverse"
sudo add-apt-repository -y "deb http://archive.ubuntu.com/ubuntu ${RELEASE}-updates universe multiverse"

# Install asdf and only the bare minimum required for ansible, asdf, brew
sudo apt -y update
sudo apt -y full-upgrade
sudo apt -y autoremove
sudo apt -y autoclean

sudo apt -y install \
  build-essential curl dirmngr file git \
  moreutils procps tree unzip

# Add a local bin dir
mkdir -p "${HOME}/.local/bin"

# Install/update Homebrew
if [[ -d "${HOME}/.linuxbrew" ]]; then
  brew update
else
  NONINTERACTIVE=1 curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh
fi

# Install/update ASDF
if [[ -d "${HOME}/.asdf" ]]; then
  asdf update
  asdf plugin update --all
else
  git clone https://github.com/asdf-vm/asdf.git "${HOME}/.asdf"
fi

# I don't know and I don't care to learn how to do multiline grep search/replace
# so I'm just stealing from the /etc/profile & /etc/profile.d strategy
rm -rf "${HOME}/.startup.d"
mkdir -p "${HOME}/.startup.d"
rm -rf "${HOME}/.shutdown.d"
mkdir -p "${HOME}/.shutdown.d"

# cp /mnt/i/Users/Michael/Dropbox/mkey_big ~/.ssh/id_rsa ; chmod 0600 ~/.ssh/id_rsa
# cp /mnt/i/Users/Michael/Dropbox/mkey_big.pub ~/.ssh/id_rsa.pub

cp -r ./roles/languages/files/startup.d/01_asdf.sh "${HOME}/.startup.d/"
cp -r ./roles/languages/files/startup.d/01_brew.sh "${HOME}/.startup.d/"
cp -r ./roles/languages/files/startup.sh "${HOME}/.startup.sh"
cp -r ./roles/languages/files/shutdown.sh "${HOME}/.shutdown.sh"

# match whole line, if it doesn't exist, add to end
add_if_not_present() {
  local line file
  line=$1
  file=$2

  # no output, match whole lines in file, input is one newline separated string
  grep --quiet --line-regexp --fixed-strings "${line}" "${file}" || echo "${line}" >>"${file}"
}

del_if_present() {
  local line file
  line=$1
  file=$2

  sed '/^.*'"${line}"'.*$/d' "${file}" | sponge "${file}"
}

procs=(startup shutdown)
for proc_name in "${procs[@]}"; do
  del_if_present "${proc_name}.sh" "${HOME}/.bashrc"
  add_if_not_present ". ${HOME}/.${proc_name}.sh" "${HOME}/.bashrc"
done

echo "${USER} ALL=(ALL:ALL) NOPASSWD: ALL" | sudo tee "/etc/sudoers.d/no-prompt-${USER}-for-sudo"

# Build environment for python
sudo apt -y install \
  autoconf bison build-essential libcurl4-openssl-dev libbz2-dev libdb-dev libffi-dev \
  libgdbm-dev libgdbm6 liblzma-dev libncurses5-dev libreadline-dev \
  libsqlite3-dev libssl-dev libxml2-dev libxmlsec1-dev libyaml-dev \
  llvm make tk-dev wget xz-utils zlib1g-dev

. "${HOME}/.bashrc"

asdf plugin-add python
asdf install python "$(asdf latest python 3.11)"
asdf global python "$(asdf latest python 3.11)"
asdf reshim python

# Update pip components first
pip install -U pip wheel
pip install -U \
  `# https://github.com/mitogen-hq/mitogen/blob/master/docs/changelog.rst` \
  `# mitogen support -        0.3.4 : ansible 6 / python 3.10` \
  `#                 - master/0.3.5 : ansible 6 / python 3.11` \
  `#                 -    pull/1017 : ansible 7 / python 3.11` \
  ansible~=7.0 \
  `# - git+https://github.com/mitogen-hq/mitogen.git@master` \
  `# git+https://github.com/moreati/mitogen.git@2.14` \
  `# ASDF python can't see the python-apt system package, so install it directly` \
  `# could steal this from system python, but git's quicker to get updates` \
  git+https://salsa.debian.org/apt-team/python-apt.git@main

# Verify
ansible --version

ansible-playbook developer.yml

echo -e "\nFinished bootstrapping."

unset PROMPT_COMMAND
exec "${SHELL}" -i
