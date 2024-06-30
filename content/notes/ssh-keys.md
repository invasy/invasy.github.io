---
title: SSH keys
categories:
- cheatsheet
tags:
- SSH
- OpenSSH
- key
- private key
- public key
---
# Get public key fingerprint

```bash
ssh-keygen -l [-E "$hash"] -f "$public_key"
```
- `$hash` — fingerprint hash algorithm: `sha256` (_default_) or `md5`.

# Get public key from private key

```bash
ssh-keygen -y -f "$private_key"
```

# Change passphrase

```bash
ssh-keygen -p -P "$old_passphrase" -N "$new_passphrase" -f "$private_key"
```

# Change comment

```bash
ssh-keygen -c -C "$new_comment" -f "$private_key"
```

# See Also

- [ssh-keygen(1)](https://man7.org/linux/man-pages/man1/ssh-keygen.1.html "man 1 ssh-keygen")
