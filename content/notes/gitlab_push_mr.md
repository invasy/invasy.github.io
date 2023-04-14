---
title: How to create merge request in GitLab on push
categories:
- how to
tags:
- Git
- GitLab
- push
- merge request
---
## New branch
Push new branch and set upstream:
```bash
git push -o merge_request.create -o merge_request.target=master -o merge_request.assign="$gitlab_username" -u origin "$branch"
```

## Existing branch
Push existing branch and update merge request:
```bash
git push -o merge_request.create -o merge_request.target=master -o merge_request.assign="$gitlab_username"
```

## See Also
- [Push options for merge requests — GitLab Documentation](https://docs.gitlab.com/ee/user/project/push_options.html#push-options-for-merge-requests)
