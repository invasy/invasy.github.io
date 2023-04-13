#!/usr/bin/env bash
set -euo pipefail
shopt -qs lastpipe

: "${USERNAME:=$_CONTAINER_USER}"
: "${PASSWORD:=$USERNAME}"
: "${COMMENT:=${USERNAME@u}}"
: "${ROOT_PASSWORD:=root}"

# Set root password
yes "$ROOT_PASSWORD" | passwd || :

# Create user and group
useradd --create-home --comment="$COMMENT" --user-group "$USERNAME"
yes "$PASSWORD" | passwd "$USERNAME" || :
