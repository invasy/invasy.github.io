---
title: Bash Redirections
date: 2024-07-10T15:20:00Z
categories:
- cheatsheet
tags:
- Bash
- stdin
- stdout
- stderr
---
{{< table class="table table-bordered table-hover" >}}
| Syntax         | Description                                          |
|:--------------:|------------------------------------------------------|
| `< file`       | _stdin_ from `file`                                  |
| `> file`       | _stdout_ to `file`[^1]                               |
| `>\| file`     | _stdout_ to `file`[^2]                               |
| `>> file`      | append _stdout_ to `file`                            |
| `2> file`      | _stderr_ to `file`                                   |
| `2>&1`         | _stderr_ to _stdout_                                 |
| `&> file`      | both _stdout_ and _stderr_ to `file`                 |
| `> file 2>&1`  | both _stdout_ and _stderr_ to `file`                 |
| `&>> file`     | append both _stdout_ and _stderr_ to `file`          |
| `>> file 2>&1` | append both _stdout_ and _stderr_ to `file`          |
| `<<END`        | “here-document”: _stdin_ from lines until `END`      |
| `<<-END`       | “here-document” with leading tabs stripped           |
| `<<'END'`      | “here-document” without expansions and substitutions |
| `<<< string`   | “here-string”: _stdin_ from `string`                 |

[^1]: Fails if option `noclobber` is set (`set -o noclobber`) and file exists.
[^2]: Overwrites file if it exists.
{{< /table >}}

## See Also

- [Redirections (Bash Reference Manual)](https://www.gnu.org/software/bash/manual/html_node/Redirections.html "Redirections (Bash Reference Manual)")
