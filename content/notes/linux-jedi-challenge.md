---
title: Linux Jedi Challenge
categories:
- neat
tags:
- Linux
- challenge
---
- [Based on a thread in /r/linuxmemes, I made an interactive challenge in docker to test if you can delete files with weird characters safely @ Reddit](https://www.reddit.com/r/linux/comments/mu9b63/based_on_a_thread_in_rlinuxmemes_i_made_an/)
- [kjpgit/linux_jedi_challenge @ GitHub](https://github.com/kjpgit/linux_jedi_challenge)
- [kjpgit/linux-jedi-challenge @ ECR](https://gallery.ecr.aws/p5e0b0g4/kjpgit/linux-jedi-challenge)

## Run
```bash
docker run --rm -it public.ecr.aws/p5e0b0g4/kjpgit/linux-jedi-challenge:latest
```

## Level 1
I created 22 bad files in your home directory (`/root/`).  Delete them.\
(The files are in the container, not in your real computer, don't worry.)

Do NOT delete these files: `a`, `b`, `c`, `db-backup`, `.ssh_config`.

### Solution
```bash
find /root/ -type f -regextype posix-extended \
  -not -regex '^[^/]*/(\.profile|\.bashrc|\.ssh_config|[abc]|db-backup)$' -delete
```

## Level 2
I created 22 bad files in `/level2/`.\
Some contain the word "*virus*" in their data, and the others contain "*spam*".\
Move the "*virus*" files to `/level2/virus/`, but don't rename them.\
Leave the "*spam*" files alone.

### Solution
```bash
grep -FZls 'virus' /level2/* | xargs -0 mv -t /level2/virus/
```
