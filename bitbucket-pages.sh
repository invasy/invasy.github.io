#!/usr/bin/env bash
set -euo pipefail
shopt -qs lastpipe

if [[ "${CI:-}" != 'true' ]]; then
  BITBUCKET_BRANCH="$(git rev-parse --abbrev-ref HEAD)"
  BITBUCKET_COMMIT="$(git rev-parse HEAD)"
  PAGES_REPO_URL='git@bitbucket.org:invasy/invasy.bitbucket.io.git'
  export HUGO_BASEURL="https://invasy.bitbucket.io"
  export HUGO_ENVIRONMENT='production'
fi

# Clean
rm -rf public resources

# Clone
git clone --branch=public "$PAGES_REPO_URL" public

# Build
.devcontainer/build.sh

# Publish
pushd public
git status
git add .
git commit --message="built from commit ${BITBUCKET_COMMIT:0:8} ($BITBUCKET_BRANCH)"
popd
