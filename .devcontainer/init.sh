#!/usr/bin/env bash
set -euo pipefail
shopt -qs lastpipe

echo '=> Installing Node packages: eslint and remark...'
npm install

echo '=> Installing Go tools...'
mkdir -p "$GOPATH/src" "$GOPATH/pkg" "$GOBIN"
go install golang.org/x/tools/gopls@latest

echo '=> Updating Hugo modules...'
hugo mod get -u
