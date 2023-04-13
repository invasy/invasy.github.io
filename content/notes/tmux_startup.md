---
title: Extra characters at tmux startup
categories:
- howto
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
Change the following option in `tmux.conf`:
```tmux
set -s escape-time 10  # Any value ≠ 0
```