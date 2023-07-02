#!/usr/bin/env bash
set -euo pipefail
shopt -qs lastpipe

declare DOCKERFILE

declare -ar _installable=(
  go
  hadolint
  hugo
  pagefind
  sass
)
IFS='|'; installable="^(${_installable[*]})\$"; unset IFS
declare -r installable

declare -Ar repos=(
  [hadolint]='hadolint/hadolint'
  [hugo]='gohugoio/hugo'
  [pagefind]='CloudCannon/pagefind'
  [sass]='sass/dart-sass'
)

declare -ar CURL=(
  curl
  --fail
  --location
  --show-error
  --silent
)

###############################################################################

die() {
  local -i code=1
  if [[ $1 =~ ^[0-9]+$ ]]; then code="$1"; shift; fi

  local fmt="${1:?missing message format}"; shift
  # shellcheck disable=SC2059
  printf "${0##*/}: error: $fmt\n" "$@" >&2
  exit "$code"
}

msg() {
  local fmt="${1:?missing message format}"; shift
  # shellcheck disable=SC2059
  printf "=> $fmt\n" "$@"
}

msg_install() {
  local name="${1:?missing package name}"
  local version="${2:?missing package version}"
  msg 'Installing %s %s...' "$name" "$version"
}

###############################################################################

create_user() {
  local username="${1:?missing username}"
  local OPT OPTARG password comment="${username@u}"
  local -i OPTIND OPTERR=0

  while getopts ':c:p:' OPT; do
    # shellcheck disable=SC2220
    case $OPT in
      c) comment="$OPTARG" ;;
      p) password="$OPTARG" ;;
    esac
  done; shift $(( OPTIND - 1 ))

  msg "Creating user '%s'..." "$username"
  useradd --create-home --comment="$comment" --user-group "$username"
  if [[ $password ]]; then
    set_password "$username" "$password"
  fi
}

set_password() {
  local username="${1:?missing username}"
  local password="${2:-$username}"

  msg 'Setting %s password...' "$username"
  yes "$password" | passwd -q "$username" || :
}

###############################################################################

fetch() {
  local url="${1:?missing URL}"
  local OPT OPTARG dir='/tmp' filename
  local -i OPTERR=0 OPTIND=1
  local -a args=()

  while getopts ':d:f:o:' OPT; do
    # shellcheck disable=SC2220
    case $OPT in
      d) dir="$OPTARG" ;;
      f|o) filename="$OPTARG" ;;
    esac
  done; shift $(( OPTIND - 1 ))

  if [[ $filename ]]; then
    args+=(--output "$filename")
  else
    args+=(--output-dir "$dir" --remote-name)
  fi

  "${CURL[@]}" "${args[@]}" "$url"
}

fetch_release() {
  local version='latest' filename tag_format='v%s' repo
  local OPT OPTARG
  local -i OPTIND=1 OPTERR=0

  while getopts ':v:f:t:' OPT; do
    # shellcheck disable=SC2220
    case $OPT in
      v) version="$OPTARG" ;;
      f) filename="$OPTARG" ;;
      t) tag_format="$OPTARG" ;;
    esac
  done; shift $(( OPTIND - 1 ))
  repo="${1:?}"

  if [[ $version != 'latest' ]]; then
    # shellcheck disable=SC2059
    printf -v version "tags/$tag_format" "$version"
  fi

  "${CURL[@]}" "https://api.github.com/repos/$repo/releases/$version" \
  | jq -r '.tag_name as $tag|.assets|map(select(.name|match("'"$filename"'")))|.[0]|[$tag,.browser_download_url,.name]|join(" ")'
}

latest_release() {
  local repo="${1:?}" tag
  tag="$(curl -fsSL "https://api.github.com/repos/$repo/releases/latest" | jq -r '.tag_name')"
  echo "${tag#v}"
}

extract() {
  local pkg="${1:?}" dest="${2:-/opt}"
  tar -xf "$pkg" -C "$dest"
}


###############################################################################

cmpver() {
  printf '%s\n%s' "$1" "$2" | sort -CV
}

latest() {
  local name="${1:?}"
  if [[ $(type -t "latest_$name") == 'function' ]]; then
    "latest_$name"
  else
    latest_release "${repos[$name]}"
  fi
}

check_version() {
  local name="${1:?}" c_name='' c_new='' r='' old new
  eval "old=\"\$${name@U}_VERSION\""
  new="$(latest "$name")"
  if [[ -z ${NO_COLOR:-} ]]; then
    c_name="\e[1;37m" r="\e[m"
    if [[ "$old" != "$new" ]] && cmpver "$old" "$new"; then
      c_new="\e[1;32m"
    fi
  fi
  printf "$c_name%-10s$r %-8s $c_new%-8s$r\n" "$name" "$old" "$new"
}

update_version() {
  local name="${1:?missing name}" version="${2:-latest}" script
  if [[ $version == 'latest' ]]; then version="$(latest "$name")"; fi
  printf -v script '/^ARG\\s+%s_VERSION=/s/(=")[^"]+(")/\\1%s\\2/' "${name@U}" "$version"
  sed -E "$script" -i "$DOCKERFILE"
}

###############################################################################

install_packages() {
  local OPT OPTARG
  local -i OPTIND OPTERR=0 update=0 upgrade=0
  export DEBIAN_FRONTEND='noninteractive'

  while getopts ':uU' OPT; do
    # shellcheck disable=SC2220
    case $OPT in
      u) update=1 ;;
      U) upgrade=1 ;;
    esac
  done; shift $(( OPTIND - 1 ))

  if (( $# == 0 )); then
    die ""
  fi

  msg 'Installing packages...'
  if (( update )); then
    apt-get -q update
  fi
  if (( upgrade )); then
    apt-get -qy upgrade
  fi
  apt-get -qy install --no-install-recommends "$@"

  # Clean up
  rm -rf /var/lib/apt/lists/*
}

###############################################################################

latest_go() {
  local tag
  tag="$(curl -fsSL 'https://go.dev/VERSION?m=text')"
  echo "${tag#go}"
}

install_go() {
  local version="${1:?}"
  local pkg="go${version}.linux-amd64.tar.gz"

  msg_install 'Go' "$version"
  fetch "https://go.dev/dl/$pkg"
  extract "/tmp/$pkg"
}

install_hadolint() {
  local version="${1:-latest}" url pkg

  read -r version url pkg < <(fetch_release \
    -v "$version" \
    -f '^hadolint-Linux-x86_64$' \
    "${repos[hadolint]}")

  msg_install 'Hadolint' "$version"
  fetch "$url.sha256"
  fetch "$url"
  pushd /tmp >/dev/null
  sha256sum --check --status --ignore-missing "$pkg.sha256"
  install "$pkg" /usr/local/bin/hadolint
  popd >/dev/null
}

install_sass() {
  local version="${1:-latest}" url pkg

  read -r version url pkg < <(fetch_release \
    -v "$version" -t '%s' \
    -f '^dart-sass-[0-9.]+-linux-x64\\.tar\\.gz$' \
    'sass/dart-sass')

  msg_install 'Dart Sass' "$version"
  fetch "$url"
  extract "/tmp/$pkg" '/tmp'
  install /tmp/dart-sass/sass /usr/local/bin/
}

install_hugo() {
  local version="${1:-latest}" variant="${2:-hugo_extended}" url pkg

  read -r version url pkg < <(fetch_release \
    -v "$version" \
    -f '^'"$variant"'_[0-9.]+_linux-amd64\\.tar\\.gz$' \
    "${repos[hugo]}")
  version="${version#v}"
  local checksums="hugo_${version}_checksums.txt"

  msg_install 'Hugo' "$version"
  fetch "${url%/*}/$checksums"
  fetch "$url"
  pushd /tmp >/dev/null
  sha256sum --check --status --ignore-missing "$checksums"
  extract "$pkg" '/usr/local/bin'
  popd >/dev/null

  # Install bash completion for Hugo
  hugo completion bash > /etc/bash_completion.d/hugo
}

install_pagefind() {
  local version="${1:-latest}" url pkg

  read -r version url pkg < <(fetch_release \
    -v "$version" \
    -f '^pagefind-v[0-9.]+-x86_64-unknown-linux-musl.tar.gz$' \
    "${repos[pagefind]}")
  version="${version#v}"

  msg_install 'Pagefind' "$version"
  fetch "$url"
  extract "/tmp/$pkg" '/usr/local/bin'
}

###############################################################################

main() {
  local name="${1:-}"; shift || :
  # shellcheck disable=SC2254
  case $name in
    user) create_user "$@" ;;
    password|passwd) set_password "$@" ;;
    latest) latest "${1:?missing name}" ;;
    check|versions|update)
      local dir
      dir="$(dirname "${BASH_SOURCE[0]}")"
      dir="$(realpath "$dir")"
      : "${DOCKERFILE:=$dir/Dockerfile}"
      eval "$(sed -En 's/^ARG\s+([A-Z]+_VERSION="[^"]+")/\1/p' "$DOCKERFILE")"
      ;;&
    check|versions)
      name="${1:-all}"
      if [[ $name =~ $installable ]]; then
        check_version "$name"
      elif [[ $name == 'all' ]]; then
        for name in "${_installable[@]}"; do
          check_version "$name"
        done
      fi ;;
    update)
      name="${1:?missing name}"
      if [[ $name =~ $installable ]]; then
        update_version "$name" "${2:?missing version}"
      elif [[ $name == 'all' ]]; then
        for name in "${_installable[@]}"; do
          update_version "$name" latest
        done
      fi ;;
    packages|pkg) install_packages "$@" ;;
    *)
      if [[ $name =~ $installable ]]; then
        "install_$name" "$@"
      fi
  esac
}

main "$@"
