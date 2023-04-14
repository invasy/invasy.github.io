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
In a repository:
```git {title=".git/config"}
[remote "github"]
	url = git@github.com:$user/$project.git
	fetch = +refs/heads/*:refs/remotes/github/*
	pushurl = git@github.com:$user/$project.git
	pushurl = git@gitlab.com:$user/$project.git
	pushurl = git@bitbucket.org:$user/$project.git
[remote "gitlab"]
	url = git@gitlab.com:$user/$project.git
	fetch = +refs/heads/*:refs/remotes/gitlab/*
	pushurl = git@github.com:$user/$project.git
	pushurl = git@gitlab.com:$user/$project.git
	pushurl = git@bitbucket.org:$user/$project.git
[remote "bitbucket"]
	url = git@bitbucket.org:$user/$project.git
	fetch = +refs/heads/*:refs/remotes/bitbucket/*
	pushurl = git@github.com:$user/$project.git
	pushurl = git@gitlab.com:$user/$project.git
	pushurl = git@bitbucket.org:$user/$project.git
[branch "master"]  
	remote = github
	merge = refs/heads/master
```

Change `$user` and `$project` accordinly.

## See Also
- [How to setup OpenSSH agent in WSL2](/notes/openssh_agent_wsl2 "How to setup OpenSSH agent in WSL2")
