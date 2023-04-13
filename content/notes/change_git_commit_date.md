---
title: Change Git commit date
categories:
- howto
tags:
- git
- commit
- date
---
```bash
GIT_COMMITTER_DATE="$date" GIT_AUTHOR_DATE="$date" git commit -m "$description"
```

## See Also
- [Commit Information — git-commit Documentation](https://git-scm.com/docs/git-commit/#_commit_information "Commit Information — git-commit Documentation")
