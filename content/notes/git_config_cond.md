---
title: Git config conditional include
categories:
- reference
tags:
- git
- config
- include
---
```ini {title="$XDG_CONFIG_HOME/git/config"}
[include]
	path = user.config

[includeIf "gitdir:**/src/work/**/.git"]
	path = work.config
```

## See Also
- [git-config Documentation: Conditional includes](https://git-scm.com/docs/git-config#_conditional_includes)
- [Comment on Habr](https://habr.com/ru/company/nlmk/blog/673946/#comment_24486046)
