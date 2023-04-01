#!/usr/bin/env bash
set -euo pipefail
shopt -qs lastpipe

declare -a CURL_FLAGS=(
  --silent
  --show-error
  --location
)

fetch() {
  local url="${1:?}"

  curl "${CURL_FLAGS[@]}" --output-dir '/tmp' --remote-name "$url"
}

extract() {
  local pkg="${1:?}" dest="${2:-/opt}"

  tar -C "$dest" -xf "$pkg"
}

pkg="go${VERSION}.linux-amd64.tar.gz"

fetch "https://go.dev/dl/$pkg"
extract "/tmp/$pkg"
