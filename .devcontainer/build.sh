#!/usr/bin/env bash
set -euo pipefail
shopt -qs lastpipe

declare -ar hugo_args=(
  --cleanDestinationDir
  --minify
  --gc
  --printI18nWarnings
  --printPathWarnings
  --printUnusedTemplates
  --templateMetrics
  --templateMetricsHints
)

if [[ ${CI:-} == 'true' ]]; then
  git config --global --add safe.directory "$PWD"
fi

hugo "${hugo_args[@]}" "$@"
pagefind --source public
