#! /bin/bash

# shellcheck disable=SC1091
# This script should be idempotent and safe to run multiple times

# Enable universe/restricted/multiverse repos
sudo add-apt-repository -y universe restricted multiverse

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

# cp /mnt/i/Users/Michael/Dropbox/mkey_big "${HOME}/.ssh/id_rsa" ; chmod 0600 "${HOME}/.ssh/id_rsa"
# cp /mnt/i/Users/Michael/Dropbox/mkey_big.pub "${HOME}/.ssh/id_rsa.pub"

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
  add_if_not_present ". ${HOME}/.local/bin/${proc_name}.sh" "${HOME}/.bashrc"
  rm -rf "${HOME}/.config/${proc_name}.d"
  mkdir -p "${HOME}/.config/${proc_name}.d"
done
cp -a ./roles/languages/files/home/. "${HOME}/"

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

# Install UV
asdf plugin-add uv
asdf install uv latest
asdf global uv latest
asdf reshim uv

# Install Python
uv python install

# Create/Activate default venv
uv venv "${HOME}/.venv"
. "${HOME}/.venv/bin/activate"
uv sync

. "${HOME}/.bashrc"

# Verify
ansible --version

ansible-playbook developer.yml

echo -e "\nFinished bootstrapping."

unset PROMPT_COMMAND

. "${HOME}/.bashrc"
