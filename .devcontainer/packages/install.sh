#!/usr/bin/env bash
set -euo pipefail
shopt -qs lastpipe

install_packages() {
  export DEBIAN_FRONTEND='noninteractive'

  apt-get update
  apt-get -y upgrade
  apt-get -y install --no-install-recommends "$@"

  rm -rf /var/lib/apt/lists/*
}

# shellcheck disable=SC2086
install_packages ${PACKAGES//,/ }
