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

fetch_release() {
  local version='latest' asset_filename tag_format='tags/v%s' repo
  local OPT OPTARG
  local -i OPTIND=1 OPTERR=0

  # shellcheck disable=SC2220
  while getopts ':v:a:t:' OPT; do
    case $OPT in
      v) version="$OPTARG" ;;
      a) asset_filename="$OPTARG" ;;
      t) tag_format="$OPTARG" ;;
    esac
  done; shift $(( OPTIND - 1 ))
  repo="${1:?}"

  if [[ $version != 'latest' ]]; then
    # shellcheck disable=SC2059
    printf -v version "$tag_format" "$version"
  fi

  curl "${CURL_FLAGS[@]}" "https://api.github.com/repos/$repo/releases/$version" \
  | jq -r '.tag_name as $tag|.assets|map(select(.name|match("'"$asset_filename"'")))|.[0]|[$tag,.browser_download_url,.name]|join(" ")'
}

extract() {
  local pkg="${1:?}" dest="${2:-/opt}"

  tar -C "$dest" -xf "$pkg"
}

install_sass() {
  local version="${1:-latest}" url pkg

  read -r version url pkg < <(fetch_release \
    -v "$version" \
    -a '^sass_embedded-[0-9.]+-linux-x64\\.tar\\.gz$' \
    -t '%s' \
    'sass/dart-sass-embedded')

  fetch "$url"
  extract "/tmp/$pkg"
  ln -s /opt/sass_embedded/dart-sass-embedded /usr/local/bin/
}

install_hugo() {
  local version="${1:-latest}" variant="${2:-hugo_extended}" url pkg

  read -r version url pkg < <(fetch_release \
    -v "$version" \
    -a '^'"$variant"'_[0-9.]+_linux-amd64\\.tar\\.gz$' \
    'gohugoio/hugo')
  version="${version#v}"

  fetch "${url%/*}/hugo_${version}_checksums.txt"
  fetch "$url"
  pushd /tmp >/dev/null
  sha256sum --check --status --ignore-missing "hugo_${version}_checksums.txt"
  popd >/dev/null
  extract "/tmp/$pkg" '/usr/local/bin'

  hugo completion bash > /etc/bash_completion.d/hugo
}

install_pagefind() {
  local version="${1:-latest}" url pkg

  read -r version url pkg < <(fetch_release \
    -v "$version" \
    -a '^pagefind-v[0-9.]+-x86_64-unknown-linux-musl.tar.gz$' \
    'CloudCannon/pagefind')
  version="${version#v}"

  fetch "$url"
  extract "/tmp/$pkg" '/usr/local/bin'
}

install_sass "$SASS_VERSION"
install_hugo "$VERSION" "$VARIANT"
install_pagefind "$PAGEFIND_VERSION"
