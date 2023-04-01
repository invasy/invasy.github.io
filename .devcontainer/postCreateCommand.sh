#!/usr/bin/env bash
set -euo pipefail
shopt -qs lastpipe

mkdir -p "$GOPATH/src" "$GOPATH/pkg" "$GOPATH/bin"
go install golang.org/x/tools/gopls@latest

pip3 install -r requirements.txt

hugo mod get -u
