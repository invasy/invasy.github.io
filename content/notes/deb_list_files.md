---
title: How to list files in a DEB package
categories:
- how to
tags:
- deb
- dpkg
- Debian
- Ubuntu
---
## List files in the installed package
```shell
dpkg-query -L "$package_name"
```

## List files in the `*.deb` file
```shell
dpkg-deb -c "$package_name.deb"
```