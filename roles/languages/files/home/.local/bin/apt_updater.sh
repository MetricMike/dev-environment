#! /bin/bash

sudo apt update
sudo apt full-upgrade --assume-yes
sudo apt autoremove --assume-yes --purge
sudo apt autoclean --assume-yes

sudo apt install --assume-yes \
  podman \
  autoconf \
  bash-completion \
  bison \
  build-essential \
  curl \
  gettext \
  gh \
  git \
  libgd-dev \
  libcurl4-openssl-dev \
  libedit-dev \
  libicu-dev \
  libjpeg-dev \
  libmysqlclient-dev \
  libonig-dev \
  libpng-dev \
  libpq-dev \
  libreadline-dev \
  libsqlite3-dev \
  libssl-dev \
  libxml2-dev \
  libzip-dev \
  locate \
  openssl \
  pkg-config \
  re2c \
  zlib1g-dev
