---
title: Push to multiple remotes in git
categories:
- howto
tags:
- git
- config
- push
- remote
---
`.git/config` (_in a repository_):
```git
…
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
…
```

# See Also
- [[Using `IdentitiesOnly` Option in `ssh_config`]]
- [[OpenSSH agent in WSL2]]
