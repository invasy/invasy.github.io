---
title: Git
category:
- cheatsheet
tags:
- Git
---
{{< img src="git.png" width="100%" title="Git Cheatsheet" alt="Git Cheatsheet" link="." >}}

# Commands
- Initial configuration:
    ```bash
    git config --global user.name "$first_name $last_name"
    git config --global user.email "user@example.com"
    ```
## Init
- Initialize repository:
    ```bash
    git init && git commit --allow-empty -m 'Initial commit'
    ```
- Clone repository:
    ```bash
    git clone "$url" ["$dir"]
    ```
## Working tree and index (staging area)
- :bar_chart: Show the working tree status:
    ```bash
    git status
    ```
- :heavy_plus_sign: Stage changes in a file to the index:
    ```bash
    git add "$filename"
    ```
- Show unstaged changes (diff between the working tree and the index):
    ```bash
    git diff
    ```
- Show staged changes in the index (diff between the index and the `HEAD`):
    ```bash
    git diff --cached
    ```
- :heavy_minus_sign: Unstage a file, keep changes in the working directory:
    ```bash
    git reset "$filename"
    ```
- Clear the index, update the working tree from the specified commit:
    ```bash
    git reset --hard "$commit"
    ```
## Branches
- :scroll: List local branches:
    ```bash
    git branch
    ```
- List all branches (with remote ones):
    ```bash
    git branch -av
    ```
- :green_circle: Create a new branch from the current commit (`HEAD`):
    ```bash
    git checkout -b "$branch"
    ```
    ```bash
    git branch "$branch" && git switch "$branch"
    ```
    ```bash
    git switch -c "$branch"
    ```
- :arrow_right_hook: Switch to a branch (update working tree and index):
    ```bash
    git checkout "$branch"
    ```
    ```bash
    git switch "$branch"
    ```
- Merge the specified branch into the current one:
    ```bash
    git merge "$branch"
    ```
- Apply commits of current branch ahead of the specified one:
    ```bash
    git rebase "$branch"
    ```
- Rename branch:
    ```bash
    git branch -m "$new_branch"
    ```
- :red_circle: Delete branch:
    ```bash
    git branch -d "$branch"
    ```