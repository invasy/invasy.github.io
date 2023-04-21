---
title: How to update all Python packages
categories:
- how to
tags:
- Python
- venv
- pip
- update
- upgrade
- package
- jq
---
```bash
pip list --outdated --format=json | jq '.[].name' | xargs --max-args=1 pip install --upgrade
```
