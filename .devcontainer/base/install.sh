#!/usr/bin/env bash
set -euo pipefail
shopt -qs lastpipe

declare -a pkgs=(
  apt-transport-https
  bash-completion
  ca-certificates
  curl
  git
  gnupg
  jq
  less
  xz-utils
)
: "${PACKAGES:=}"
# shellcheck disable=SC2206
pkgs+=(${PACKAGES//,/ })

for script in I release.jq; do
  install "$script" /usr/local/bin/
done

I add packages upgraded "${pkgs[@]}"

if [[ ${ROOT_PASSWORD:-} ]]; then
  I set password root "$ROOT_PASSWORD"
fi
