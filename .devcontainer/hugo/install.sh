#!/usr/bin/env bash
set -euo pipefail
shopt -qs lastpipe

declare -r SASS_REPO='sass/dart-sass'
declare -r PAGEFIND_REPO='CloudCannon/pagefind'
declare -r HUGO_REPO='gohugoio/hugo'

install_sass() {
  local version="${1:-latest}"
  local -A asset

  eval "asset=($(I fetch release "$SASS_REPO" "$version" '^dart-sass-[0-9.]+-linux-x64\.tar\.gz$' '%s'))"

  I fetch "${asset[url]}" to .
  I extract "${asset[filename]}" to .
  mv dart-sass /opt/
  ln -s /opt/dart-sass/sass /usr/local/bin/
}

install_pagefind() {
  local version="${1:-latest}"
  local -A asset

  eval "asset=($(I fetch release "$PAGEFIND_REPO" "$version" '^pagefind-v[0-9.]+-x86_64-unknown-linux-musl\.tar\.gz$'))"

  I fetch "${asset[url]}" to .
  I extract "${asset[filename]}" to /usr/local/bin
}

install_hugo() {
  local version="${1:-latest}" variant="${2:-hugo_extended}" pattern checksums
  local -A asset

  printf -v pattern '^%s_[0-9.]+_linux-amd64\\.tar\\.gz$' "$variant"
  eval "asset=($(I fetch release "$HUGO_REPO" "$version" "$pattern"))"
  version="${asset[tag]#v}"
  checksums="hugo_${version}_checksums.txt"

  I fetch "${asset[url]%/*}/$checksums" to .
  I fetch "${asset[url]}" to .
  sha256sum --check --status --ignore-missing "$checksums"
  I extract "${asset[filename]}" to /usr/local/bin

  # Install bash completion for Hugo
  hugo completion bash > /etc/bash_completion.d/hugo
}

I add package pandoc
if [[ ${SASS_VERSION:-none} != 'none' ]]; then install_sass "$SASS_VERSION"; fi
if [[ ${PAGEFIND_VERSION:-none} != 'none' ]]; then install_pagefind "$PAGEFIND_VERSION"; fi
# shellcheck disable=SC2153
install_hugo "$VERSION" "$VARIANT"
