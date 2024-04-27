### PowerShell

In this repository we have some scripts that describes the process to execute a shellcode in PowerShell.

This is done by importing some Win32 APIs over C# code. Then we implement that Win32 APIs over our current powershell session and use it to copy our shellcode in memory and inyect it over the execution flow of the current process.