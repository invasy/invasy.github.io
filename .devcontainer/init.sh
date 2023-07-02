#!/usr/bin/env bash
set -euo pipefail
shopt -qs lastpipe

declare -ar VERSION_NAMES=(
  bootstrap
  curl
  eslint
  git
  go
  gopls
  gpg
  hadolint
  hugo
  jq
  less
  markdownlint
  node
  npm
  pandoc
  pip
  python
  remark
  typescript
  xz
  yamllint
)

declare -Ar VERSION_COMMAND=(
  [bootstrap]='grep -F bootstrap go.mod'
  [go]='go version'
  [gopls]='gopls version'
  [hugo]='hugo version'
  [python]='python3 --version'
  [typescript]='tsc --version'
)

declare -Ar VERSION_RE=(
  [bootstrap]='.* v([0-9.]+).*'
  [curl]='curl ([0-9.]+) .*'
  [eslint]='v([0-9.]+)'
  [git]='git version ([0-9.]+)'
  [go]='.* go([0-9.]+) .*'
  [gopls]='.* v([0-9.]+)'
  [gpg]='.* ([0-9.]+)'
  [hadolint]='.* ([0-9.]+)'
  [hugo]='hugo v([0-9.]+).*'
  [jq]='jq-([0-9.]+)'
  [less]='less ([0-9]+) .*'
  [node]='v([0-9.]+)'
  [pandoc]='pandoc ([0-9.]+)'
  [pip]='pip ([0-9.]+) .*'
  [python]='Python ([0-9.]+)'
  [remark]='remark: ([0-9.]+).*'
  [typescript]='Version ([0-9.]+)'
  [xz]='.* ([0-9.]+)'
  [yamllint]='yamllint ([0-9.]+)'
)

msg() {
  local n=''
  if [[ ${1:-} == '-n' ]]; then n='\n'; shift; fi
  local fmt="${1:?missing message format}"; shift
  # shellcheck disable=SC2059
  printf "$n=> $fmt\n" "$@"
}

version() {
  local name="${1:?}" script
  printf -v script '1s/^%s$/\\1/p' "${VERSION_RE[$name]:-(.*)}"
  ${VERSION_COMMAND[$name]:-$name --version} | sed -En "$script"
}

versions() {
  msg -n 'Installed software:'
  for name in "${VERSION_NAMES[@]}"; do
    printf '%-12s  %s\n' "$name" "$(version "$name")"
  done
}

msg -n 'Updating Hugo modules...'
hugo mod get -u

versions
