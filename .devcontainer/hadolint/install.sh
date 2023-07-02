#!/usr/bin/env bash
set -euo pipefail
shopt -qs lastpipe

declare -r HADOLINT_REPO='hadolint/hadolint'

install_hadolint() {
  local version="${1:-latest}"
  local -A asset

  eval "asset=($(I fetch release "$HADOLINT_REPO" "$version" '^hadolint-Linux-x86_64$'))"

  I fetch "${asset[url]}.sha256" to .
  I fetch "${asset[url]}" to .
  sha256sum --check --status --ignore-missing "${asset[filename]}.sha256"
  install "${asset[filename]}" /usr/local/bin/hadolint
}

# shellcheck disable=SC2153
install_hadolint "$VERSION"
