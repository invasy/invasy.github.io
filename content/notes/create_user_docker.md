---
title: Create user (Docker)
categories:
- howto
tags:
- Docker
- Dockerfile
- Debian
- Ubuntu
- Alpine
- user
- adduser
- useradd
---
# Dockerfile
Add the following lines with the `RUN` command:

## Debian and Ubuntu
```shell
set -eu;\
useradd --create-home --user-group --comment="$comment" "$user";\
yes "$user" | passwd "$user"
```

## Alpine
```shell
yes "$password" | adduser --gecos "$comment" "$username"
```

# Documentation
- [useradd(8)](https://manpages.debian.org/bullseye/passwd/useradd.8.en.html "man 8 useradd (Debian Bullseye)") — Debian Bullseye
- [useradd(8)](https://manpages.ubuntu.com/manpages/focal/en/man8/useradd.8.html "man 8 useradd (Ubuntu 20.04 LTS)") — Ubutnu 20.04 LTS (Focal Fossa)
- [useradd(8)](https://manpages.ubuntu.com/manpages/jammy/en/man8/useradd.8.html "man 8 useradd (Ubuntu 22.04 LTS)") — Ubutnu 22.04 LTS (Jammy Jellyfish)
- [Setting up a new user — Alpine Linux](https://wiki.alpinelinux.org/wiki/Setting_up_a_new_user)