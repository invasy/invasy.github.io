---
title: SSH escape characters
categories:
- cheatsheet
tags:
- SSH
- documentation
- tilda
- escape
---
{{< table class="table table-bordered" >}}
| Escape | Description |
|:------:|-------------|
| `~.`   | terminate connection (and any multiplexed sessions) |
| `~B`   | send a BREAK to the remote system |
| `~C`   | open a command line |
| `~R`   | request rekey (_SSH protocol 2 only_) |
| `~^Z`  | suspend ssh |
| `~#`   | list forwarded connections |
| `~&`   | background ssh (when waiting for connections to terminate) |
| `~?`   | this message |
| `~~`   | send the escape character by typing it twice |
{{< /table >}}

## See Also

- [ssh(1): ESCAPE CHARACTERS](https://man7.org/linux/man-pages/man1/ssh.1.html#ESCAPE_CHARACTERS "man 1 ssh")
