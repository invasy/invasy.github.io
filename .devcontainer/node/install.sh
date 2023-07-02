#!/usr/bin/env bash
set -euo pipefail
shopt -qs lastpipe

install_node() {
  local version="${1:-lts}"
  case $version in
    lts) version="$(I fetch 'https://nodejs.org/dist/index.json' | jq -r '.|map(select(.lts))|.[0].version')" ;;
    latest) version="$(I fetch 'https://nodejs.org/dist/index.json' | jq -r '.[0].version')" ;;
    *) version="v$version"
  esac

  local url="https://nodejs.org/dist/${version}/" dir="node-${version}-linux-x64"
  local pkg="${dir}.tar.xz"
  I fetch "${url}SHASUMS256.txt" to .
  I fetch "${url}${pkg}" to .
  sha256sum --check --status --ignore-missing SHASUMS256.txt
  I extract "$pkg" to .
  mv "$dir" /opt/node

  npm install -g npm@latest
}

install_yarn() {
  local version="${1:-stable}"

  corepack enable
  corepack prepare "yarn@$version" --activate
}

install_gyp() {
  I add packages gcc g++ make
  npm install -g node-gyp
}

# shellcheck disable=SC2153
install_node "$VERSION"
if [[ ${YARN_VERSION:-none} != 'none' ]]; then install_yarn "$YARN_VERSION"; fi
if [[ ${GYP:-true} == 'true' ]]; then install_gyp; fi

if [[ ${PACKAGES:-} ]]; then
  # shellcheck disable=SC2086
  npm install -g ${PACKAGES//,/ }
fi
