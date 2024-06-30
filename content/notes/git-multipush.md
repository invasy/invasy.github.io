---
title: How to push to multiple remotes in git
categories:
- how to
tags:
- git
- config
- push
- remote
---
# Solution

Add `pushurl` to remote branches in `.git/config`:

```git {title=".git/config"}
[branch "master"]  
	remote = github
	merge = refs/heads/master
[remote "github"]
	fetch = +refs/heads/*:refs/remotes/github/*
	url = git@github.com:$user/$project.git
	pushurl = git@github.com:$user/$project.git
	pushurl = git@gitlab.com:$user/$project.git
	pushurl = git@bitbucket.org:$user/$project.git
[remote "gitlab"]
	fetch = +refs/heads/*:refs/remotes/gitlab/*
	url = git@gitlab.com:$user/$project.git
	pushurl = git@github.com:$user/$project.git
	pushurl = git@gitlab.com:$user/$project.git
	pushurl = git@bitbucket.org:$user/$project.git
[remote "bitbucket"]
	fetch = +refs/heads/*:refs/remotes/bitbucket/*
	url = git@bitbucket.org:$user/$project.git
	pushurl = git@github.com:$user/$project.git
	pushurl = git@gitlab.com:$user/$project.git
	pushurl = git@bitbucket.org:$user/$project.git
```

Change `$user` and `$project` accordinly.

# See Also

- [git push](https://git-scm.com/docs/git-push#_named_remote_in_configuration_file "git push")
- [How to setup OpenSSH agent in WSL2](/notes/openssh_agent_wsl2 "How to setup OpenSSH agent in WSL2")
