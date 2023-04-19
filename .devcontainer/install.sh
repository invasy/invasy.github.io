#!/usr/bin/env bash
set -euo pipefail
shopt -qs lastpipe

declare -a packages=(
  bash-completion
  ca-certificates
  curl
  git
  jq
  less
  make
  pandoc
)

: "${HUGO_VARIANT:=hugo_extended}"
: "${HUGO_VERSION:=latest}"
: "${SASS_VERSION:=latest}"
: "${PAGEFIND_VERSION:=latest}"
: "${GO_VERSION:=1.20.3}"

if [[ $_CONTAINER_USER ]]; then
  : "${ROOT_PASSWORD:=root}"
  : "${USERNAME:=$_CONTAINER_USER}"
  : "${PASSWORD:=$USERNAME}"
  : "${COMMENT:=${USERNAME@u}}"
fi

declare -a CURL=(
  curl
  --silent
  --show-error
  --location
)

msg() {
  local fmt="${1:?}"; shift
  # shellcheck disable=SC2059
  printf "=> $fmt\n" "$@"
}

msg_install() {
  local name="${1:?}" version="${2:?}"
  msg 'Installing %s %s...' "$name" "$version"
}

install_packages() {
  export DEBIAN_FRONTEND='noninteractive'

  msg 'Installing packages...'
  apt-get -q  update
  apt-get -qy upgrade
  apt-get -qy install --no-install-recommends "$@"

  rm -rf /var/lib/apt/lists/*
}

fetch() {
  local url="${1:?}"
  "${CURL[@]}" --output-dir '/tmp' --remote-name "$url"
}

fetch_release() {
  local version='latest' asset_filename tag_format='tags/v%s' repo OPT OPTARG
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

  "${CURL[@]}" "https://api.github.com/repos/$repo/releases/$version" \
  | jq -r '.tag_name as $tag|.assets|map(select(.name|match("'"$asset_filename"'")))|.[0]|[$tag,.browser_download_url,.name]|join(" ")'
}

extract() {
  local pkg="${1:?}" dest="${2:-/opt}"
  tar -xf "$pkg" -C "$dest"
}

install_go() {
  local version="${1:?}"
  local pkg="go${version}.linux-amd64.tar.gz"

  msg_install 'Go' "$version"
  fetch "https://go.dev/dl/$pkg"
  extract "/tmp/$pkg"
}

install_sass() {
  local version="${1:-latest}" url pkg

  read -r version url pkg < <(fetch_release \
    -v "$version" \
    -a '^sass_embedded-[0-9.]+-linux-x64\\.tar\\.gz$' \
    -t '%s' \
    'sass/dart-sass-embedded')

  msg_install 'Dart SASS Embedded' "$version"
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
  local checksums="hugo_${version}_checksums.txt"

  msg_install 'Hugo' "$version"
  fetch "${url%/*}/$checksums"
  fetch "$url"
  pushd /tmp >/dev/null
  sha256sum --check --status --ignore-missing "$checksums"
  popd >/dev/null
  extract "/tmp/$pkg" '/usr/local/bin'

  # Install bash completion for Hugo
  hugo completion bash > /etc/bash_completion.d/hugo
}

install_pagefind() {
  local version="${1:-latest}" url pkg

  read -r version url pkg < <(fetch_release \
    -v "$version" \
    -a '^pagefind-v[0-9.]+-x86_64-unknown-linux-musl.tar.gz$' \
    'CloudCannon/pagefind')
  version="${version#v}"

  msg_install 'Pagefind' "$version"
  fetch "$url"
  extract "/tmp/$pkg" '/usr/local/bin'
}

set_password() {
  local username="${1:?}"
  local password="${2:-$username}"

  msg 'Setting %s password...' "$username"

  yes "$password" | passwd -q "$username" || :
}

create_user() {
  local username="${1:?}"
  local password="${2:-$username}" comment="${3:-${username@u}}"

  msg "Creating user '%s'..." "$username"

  useradd --create-home --comment="$comment" --user-group "$username"
  set_password "$username" "$password"
}

main() {
  install_packages "${packages[@]}"

  install_go "$GO_VERSION"
  install_sass "$SASS_VERSION"
  install_hugo "$HUGO_VERSION" "$HUGO_VARIANT"
  install_pagefind "$PAGEFIND_VERSION"

  if [[ $_CONTAINER_USER ]]; then
    create_user "$USERNAME" "$PASSWORD" "$COMMENT"
    set_password root "$ROOT_PASSWORD"
  fi
}

main "$@"
