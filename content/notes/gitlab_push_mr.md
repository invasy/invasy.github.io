---
title: Create merge request in GitLab on push
categories:
- howto
tags:
- Git
- GitLab
- push
- merge request
---
- Push new branch (set upstream):
  ```bash
  git push -o merge_request.create -o merge_request.target=master -o merge_request.assign="$gitlab_username" -u origin "$branch"
  ```
- Push to existing branch (update merge request):
  ```bash
  git push -o merge_request.create -o merge_request.target=master -o merge_request.assign="$gitlab_username"
  ```

## See Also
- [Push options for merge requests — GitLab Documentation](https://docs.gitlab.com/ee/user/project/push_options.html#push-options-for-merge-requests)
