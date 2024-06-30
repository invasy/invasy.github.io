---
title: How to install packages in Dockerfile
categories:
- how to
tags:
- Docker
- Dockerfile
- Debian
- Ubuntu
- Alpine
- APT
- apt-get
- deb
- install
- update
- package
---
# Debian and Ubuntu

```dockerfile {title="Dockerfile"}
RUN set -eu;\
    export DEBIAN_FRONTEND='noninteractive';\
    apt-get update; apt-get -y upgrade;\
    apt-get -y install --no-install-recommends $packages;\
    rm -rf /var/cache/* /var/log/* /var/lib/apt/lists/* /tmp/*
```

# Alpine

```dockerfile {title="Dockerfile"}
RUN apk add --no-cache $packages
```

# Documentation

- [apt-get(8)](https://manpages.debian.org/bullseye/apt/apt-get.8.en.html "man 8 apt-get (Debian Bullseye)") — Debian Bullseye
- [apt-get(8)](https://manpages.ubuntu.com/manpages/focal/en/man8/apt-get.8.html "man 8 apt-get (Ubuntu 20.04 LTS)") — Ubutnu 20.04 LTS (Focal Fossa)
- [apt-get(8)](https://manpages.ubuntu.com/manpages/jammy/en/man8/apt-get.8.html "man 8 apt-get (Ubuntu 22.04 LTS)") — Ubutnu 22.04 LTS (Jammy Jellyfish)
- [Add a Package — Alpine Linux](https://wiki.alpinelinux.org/wiki/Alpine_Package_Keeper#Add_a_Package "Add a Package — Alpine Linux")