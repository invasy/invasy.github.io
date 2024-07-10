#!/usr/bin/env bash
set -euo pipefail
shopt -qs lastpipe

if [[ "${CI:-}" == 'true' ]]; then
  export GOPATH='/home/hugo/go'
  export GOBIN='/home/hugo/go/bin'
  export PATH="/home/hugo/bin:/home/hugo/.local/bin:/home/hugo/go/bin:$PATH"
  .devcontainer/init.sh
  git config --global user.name "Bitbucket Pipeline"
  git config --global user.email "$EMAIL"
else
  BITBUCKET_BRANCH="$(git rev-parse --abbrev-ref HEAD)"
  BITBUCKET_COMMIT="$(git rev-parse HEAD)"
  PAGES_REPO_URL='https://invasy@bitbucket.org/invasy/invasy.bitbucket.io.git'
fi
COMMIT_URL='https://bitbucket.org/invasy/invasy.dev/commits/'
export HUGO_BASEURL="https://invasy.bitbucket.io"
export HUGO_ENVIRONMENT='production'

# Clean
rm -rf public resources

# Clone
git clone --branch=public "$PAGES_REPO_URL" public

# Build
.devcontainer/build.sh

# Publish
pushd public
git status --short --branch
git add .
git commit --file=- <<MSG
built from commit ${BITBUCKET_COMMIT:0:8} ($BITBUCKET_BRANCH)

Commit: ${COMMIT_URL}${BITBUCKET_COMMIT}
MSG
git push
popd
