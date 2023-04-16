---
title: How to change Git commit date
categories:
- how to
tags:
- git
- commit
- date
---
```bash
GIT_COMMITTER_DATE="$date" GIT_AUTHOR_DATE="$date" git commit -m "$commit_message"
```

## See Also
- [Commit Information — git-commit Documentation](https://git-scm.com/docs/git-commit/#_commit_information "Commit Information — git-commit Documentation")
