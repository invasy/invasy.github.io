---
title: How to install OpenSSH in Windows 10
categories:
- how to
tags:
- OpenSSH
- SSH
- Windows10
- PowerShell
---
# Steps
1. Run PowerShell _as Administrator_.

2. Check OpenSSH packages:
    ```powershell
    Get-WindowsCapability -Online | ? Name -like 'OpenSSH*'
    ```

    Output:

    ```
    Name  : OpenSSH.Client~~~~0.0.1.0
    State : NotPresent
    
    Name  : OpenSSH.Server~~~~0.0.1.0
    State : NotPresent
    ```

3. Install OpenSSH:
    ```powershell
    # Install the OpenSSH Client
    Add-WindowsCapability -Online -Name OpenSSH.Client~~~~0.0.1.0
    
    # Install the OpenSSH Server
    Add-WindowsCapability -Online -Name OpenSSH.Server~~~~0.0.1.0
    ```

4. [Set up SSH agent in WSL2](/notes/openssh_agent_wsl2) if needed.

# See Also
- [Install OpenSSH | Microsoft Docs](https://docs.microsoft.com/en-us/windows-server/administration/openssh/openssh_install_firstuse)
- [OpenSSH agent in WSL2](/notes/openssh_agent_wsl2)
