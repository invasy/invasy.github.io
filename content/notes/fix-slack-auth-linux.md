---
title: How to fix Slack authentication on Linux
date: 2023-09-09T22:50:20+05:00
categories:
- how to
tags:
- Slack
- authentication
- Linux
draft: true
---
Replace `xdg-open` with a wrapper:

1. Write a shell script named `xdg-open`:
    ```bash
    #!/usr/bin/env bash
    if [[ "${1:-}" =~ ^slack:// ]]; then
      echo "$1" | sed -E 's|^(slack://)([^/]+)(/.*)$|exec /usr/lib/slack/slack "\1\U\2\E\3"|e'
      exit 0
    fi

    exec /usr/bin/xdg-open "$@"
    ```
2. Place it in some directory in `$PATH`.
3. Make it executable: `chmod +x "$script"`.
