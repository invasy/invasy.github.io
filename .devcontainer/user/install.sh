#!/usr/bin/env bash
set -euo pipefail
shopt -qs lastpipe

if (( EUID == 0 )); then
  if [[ $_CONTAINER_USER == 'root' ]]; then exit 0; fi

  I add user "$_CONTAINER_USER"${PASSWORD:+ -p "$PASSWORD"}${COMMENT:+ -c "$COMMENT"}

  declare -ar vars=(
    GOBIN
    GOPATH
    GOROOT
    GO_PACKAGES
    NODE_PACKAGES
    PYTHON_PACKAGES
  )
  IFS=','; whitelist="${vars[*]}"; unset IFS
  exec su -lw "$whitelist" -c "$(realpath -e "$0")" "$_CONTAINER_USER"
fi

if [[ ${GO_PACKAGES:-} ]]; then
  : "${GOROOT:=/opt/go}"
  : "${GOPATH:=$HOME/go}"
  : "${GOBIN:=$GOPATH/bin}"
  export GOROOT GOPATH GOBIN PATH="$GOBIN:$GOROOT/bin:$PATH"

  mkdir -p "$GOPATH/src" "$GOPATH/pkg" "$GOBIN"

  # shellcheck disable=SC2086
  for pkg in ${GO_PACKAGES//,/ }; do
    go install "$pkg"
  done
fi

if [[ ${NODE_PACKAGES:-} ]]; then
  export PATH="/opt/node/bin:$PATH"

  # shellcheck disable=SC2086
  npm install ${NODE_PACKAGES//,/ }
fi

if [[ ${PYTHON_PACKAGES:-} ]]; then
  # shellcheck disable=SC2086
  pip install --break-system-packages --user ${PYTHON_PACKAGES//,/ }
fi
