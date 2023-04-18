#!/usr/bin/env bash
set -euo pipefail
shopt -qs lastpipe

# Install Go tools
mkdir -p "$GOPATH/src" "$GOPATH/pkg" "$GOBIN"
go install golang.org/x/tools/gopls@latest

# Update Hugo modules
hugo mod get -u
