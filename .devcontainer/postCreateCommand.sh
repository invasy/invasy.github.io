#!/usr/bin/env bash
set -euo pipefail
shopt -qs lastpipe

# Install Go tools
mkdir -p "$GOPATH/src" "$GOPATH/pkg" "$GOPATH/bin"
go install golang.org/x/tools/gopls@latest

# Install required Python packages
pip3 install -r requirements.txt

# Update Hugo modules
hugo mod get -u
