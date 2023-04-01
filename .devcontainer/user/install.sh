#!/usr/bin/env bash
set -euo pipefail
shopt -qs lastpipe

: "${USERNAME:=$_CONTAINER_USER}"
: "${PASSWORD:=$USERNAME}"
: "${COMMENT:=${USERNAME@u}}"

useradd --create-home --comment="$COMMENT" --user-group "$USERNAME"
yes "$PASSWORD" | passwd "$USERNAME" || :
