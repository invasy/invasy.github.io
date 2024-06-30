---
title: How to fix curl error in Alpine
categories:
- how to
- fix
tags:
- Alpine
- curl
- error
---
# Problem

Error when running curl in Alpine:
```
curl: (48) An unknown option was passed in to libcurl
```

# Solution

Install packages `curl` _and_ `curl-dev`:
```shell
apk add --no-cache curl curl-dev
```

# See Also

- [curl: (48) An unknown option was passed in to libcurl — StackOverflow](https://stackoverflow.com/questions/11678085/curl-48-an-unknown-option-was-passed-in-to-libcurl "curl: (48) An unknown option was passed in to libcurl — StackOverflow")
