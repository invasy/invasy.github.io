---
title: Bash startup files
categories:
- cheatsheet
tags:
- Bash
- startup
- config
---
{{< table class="table table-bordered table-hover" >}}
| File              | `-li` | `-l`  | `-i`  |   |
|-------------------|:-----:|:-----:|:-----:|:-:|
| `/etc/profile`    |   1   |   1   |       |   |
| `~/.bash_profile` |  2.1  |  2.1  |       |   |
| `~/.bash_login`   |  2.2  |  2.2  |       |   |
| `~/.profile`      |  2.3  |  2.3  |       |   |
| `~/.bashrc`       |       |       |   1   |   |
| `$BASH_ENV`       |       |       |       | 1 |
| `~/.bash_logout`  |   3   |   3   |       |   |
{{< /table >}}

## Options and modes
- `-l` — login shell
- `-i` — interactive shell

## Notes
- Login Bash sources the first existing and readable file from the following list:
  - `~/.bash_profile`
  - `~/.bash_login`
  - `~/.profile`
- `~/.bashrc` is sourced by Bash as interactive shell only.
- `$BASH_ENV`:
  - environment variable with the filename of init script;
  - sourced only before executing Bash script as non-interactive shell;
  - applied expansions (in order):
    - parameter expansion;
    - arithmetic expansion;
    - command substitution.

## See Also
- [Bash Startup Files (Bash Reference Manual)](https://www.gnu.org/software/bash/manual/html_node/Bash-Startup-Files.html "Bash Startup Files (Bash Reference Manual)")