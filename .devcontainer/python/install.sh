#!/usr/bin/env bash
set -euo pipefail
shopt -qs lastpipe

install_python() {
  I add packages python3-minimal
}

install_pip() {
  I add packages python3-pip
}

# shellcheck disable=SC2153
install_python "$VERSION"
if [[ ${PIP_VERSION:-} != 'none' ]]; then
  install_pip "$PIP_VERSION"

  if [[ ${PACKAGES:-} ]]; then
    # shellcheck disable=SC2086
    pip install --break-system-packages ${PACKAGES//,/ }
  fi
fi
