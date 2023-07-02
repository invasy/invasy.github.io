#!/usr/bin/env bash
set -euo pipefail
shopt -qs lastpipe

install_go() {
  local version="${1:-latest}"
  if [[ $version == 'latest' ]]; then
    version="$(curl -fsSL 'https://go.dev/VERSION?m=text')"
    version="${version#go}"
  fi
  local pkg="go${version}.linux-amd64.tar.gz"

  I fetch "https://go.dev/dl/$pkg" to .
  I extract "$pkg" to /opt
}

# shellcheck disable=SC2153
install_go "$VERSION"

if [[ ${PACKAGES:-} ]]; then
  # shellcheck disable=SC2086
  for pkg in ${PACKAGES//,/ }; do
    go install "$pkg"
  done
fi
