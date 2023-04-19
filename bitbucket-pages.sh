#!/usr/bin/env bash
set -euo pipefail
shopt -qs lastpipe

declare -r name='invasy.bitbucket.io'
declare -r branch="$(git rev-parse --abbrev-ref HEAD)"
declare -r commit="$(git rev-parse --short=8 HEAD)"

# Clean
rm -rf public resources

# Clone
git clone -b public "https://invasy@bitbucket.org/invasy/$name.git" public

# Build
hugo \
  --baseUrl="https://$name" \
  --environment=production \
  --minify --gc \
  --printI18nWarnings \
  --printPathWarnings \
  --printUnusedTemplates \
  --templateMetrics \
  --templateMetricsHints
pagefind --source public

# Publish
pushd public
git status
git add .
git commit -m "built from commit $commit ($branch)"
git push
popd
