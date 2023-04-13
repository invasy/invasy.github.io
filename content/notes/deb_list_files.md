---
title: List files in a DEB package
categories:
- howto
tags:
- deb
- dpkg
- Debian
- Ubuntu
- HowTo
---
# List files in the installed package
```shell
dpkg-query -L "$package_name"
```

# List files in the `*.deb` file
```shell
dpkg-deb -c "$package_name.deb"
```