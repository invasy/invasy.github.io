---
title: How to fix WSL startup error
categories:
- how to
- fix
tags:
- WSL
- error
- update
---
# Problem

Cannot start a WSL distribution with the following message:
```
Error: 0x80040326
Error code: Wsl/Service/0x80040326
Press any key to continue...
```

# Solution

Just update the WSL:
```powershell
wsl --update
```
