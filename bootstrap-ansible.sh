#! /bin/bash

# shellcheck disable=SC1091
# This script should be idempotent and safe to run multiple times

# Enable universe/restricted/multiverse repos
RELEASE=$(lsb_release -sc)
sudo add-apt-repository -y "${RELEASE} universe restricted multiverse"

# Enable gh cli repo
(type -p wget >/dev/null || (sudo apt update && sudo apt-get install wget -y)) &&
  sudo mkdir -p -m 755 /etc/apt/keyrings &&
  wget -qO- https://cli.github.com/packages/githubcli-archive-keyring.gpg | sudo tee /etc/apt/keyrings/githubcli-archive-keyring.gpg >/dev/null &&
  sudo chmod go+r /etc/apt/keyrings/githubcli-archive-keyring.gpg &&
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/githubcli-archive-keyring.gpg] https://cli.github.com/packages stable main" | sudo tee /etc/apt/sources.list.d/github-cli.list >/dev/null &&
  sudo apt update &&
  sudo apt install gh --assume-yes

# Install asdf and only the bare minimum required for ansible, asdf, brew
sudo apt update
sudo apt full-upgrade --assume-yes
sudo apt autoremove --assume-yes --purge
sudo apt autoclean --assume-yes

sudo apt --assume-yes install \
  build-essential \
  curl \
  dirmngr \
  file \
  git \
  moreutils \
  procps \
  tree \
  unzip

# Add a local bin dir
mkdir -p "${HOME}/.local/bin"

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
  autoconf \
  bison \
  build-essential \
  libbz2-dev \
  libcurl4-openssl-dev \
  libdb-dev \
  libffi-dev \
  libgdbm-dev \
  libgdbm6 \
  liblzma-dev \
  libncurses5-dev \
  libreadline-dev \
  libsqlite3-dev \
  libssl-dev \
  libxml2-dev \
  libxmlsec1-dev \
  libyaml-dev \
  llvm \
  make \
  tk-dev \
  wget \
  xz-utils \
  zlib1g-dev

. "${HOME}/.bashrc"

asdf plugin-add python
asdf install python latest:3.12
asdf global python latest:3.12
asdf reshim python

# Update pip components first
pip install -U \
  ansible \
  pip \
  setuptools \
  wheel

# Verify
ansible --version

ansible-playbook developer.yml

echo -e "\nFinished bootstrapping."

unset PROMPT_COMMAND

. "${HOME}/.bashrc"
