---
title: How to fix extra characters at tmux startup
categories:
- how to
tags:
- tmux
- config
- bug
---
# Problem
Some characters in the terminal at tmux start:
```
0;10;1c
```

# Solution
Change [`escape-time`] option in `tmux.conf` to any non-zero value:
```tmux {title="tmux.conf"}
set -s escape-time 10  # Any value ≠ 0
```

[`escape-time`]: http://man.openbsd.org/OpenBSD-current/man1/tmux.1#escape-time "escape-time // tmux(1)"
