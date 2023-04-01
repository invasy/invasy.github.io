#!/usr/bin/env bash
set -euo pipefail
shopt -qs lastpipe

for v in GOROOT GOPATH GOBIN PATH; do
  eval "echo \"$v='\$$v'\""
done
