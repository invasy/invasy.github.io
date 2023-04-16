---
title: How to setup OpenSSH agent in WSL2
categories:
- how to
tags:
- OpenSSH
- SSH
- WSL2
- ssh-agent
- npiperelay
- socat
---
# Prerequisites
- [OpenSSH in Windows 10](/notes/openssh_windows10)
- WSL2
- Golang

# Steps
1. Run WSL2 container (e. g. Ubuntu):
    ```powershell
    ubuntu.exe
    ```
2. Make a symlink for `.ssh` directory from Windows in WSL home directory:
    ```bash
    ln -s "/mnt/c/Users/$WINDOWS_USERNAME/.ssh" "$HOME/.ssh"
    chmod -R go= "$HOME/.ssh"
    ```
3. Fetch, build and install [npiperelay]:
    ```bash
    go get -d github.com/jstarks/npiperelay
    GOOS=windows go build -o "$HOME/.ssh/npiperelay.exe" github.com/jstarks/npiperelay
    chmod +x "$HOME/.ssh/npiperelay.exe"
    ```
4. Install `socat`:
    ```bash
    sudo apt install socat
    ```
5. Create state directory for SSH:
    ```bash
    mkdir -p "$XDG_STATE_HOME/ssh" && chmod -R go= "$XDG_STATE_HOME/ssh"
    ```
6. Add the following to `$HOME/.bashrc`:
    ```bash
    export SSH_AUTH_SOCK="$XDG_STATE_HOME/ssh/agent.socket"
    ss -a | grep -q "$SSH_AUTH_SOCK"
    if (( $? != 0 )); then
      rm -f "$SSH_AUTH_SOCK"
      ( setsid socat UNIX-LISTEN:"$SSH_AUTH_SOCK",fork,user=$USER,umask=077 \
      EXEC:"$HOME/.ssh/npiperelay.exe -ei -s //./pipe/openssh-ssh-agent",nofork & ) >/dev/null 2>&1
    fi
    ```
7. Restart WSL2 container (PowerShell or CMD):
    ```powershell
    wsl.exe -t Ubuntu
    ```

[npiperelay]: https://github.com/jstarks/npiperelay "jstarks/npiperelay — GitHub"
