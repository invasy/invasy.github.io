---
title: How to run commands over SSH with sudo
categories:
- how to
tags:
- SSH
- sudo
- Linux
- remote
- terminal
---
1. With password in command line (***insecure***):
    ```bash
    ssh -tt "$username@$hostname" echo "$password" \| sudo -S -- command
    ```
2. With password prompted:
    ```bash
    ssh -tt "$username@$hostname" cat <<END \| sudo -S -- command
    ```
