$wc = new-object system.net.WebClient
$wc.DownloadString("<URL>") 

# This lines imports a Net.WebClient object and run it using a <URL> as an argument.

# We can add some features to this DownloadCradle:


#       $wc.Headers.Add('User-Agent', "<USER-AGENT>") Add a useragent header.
#       $wc.proxy = $null Defines a proxy to use with the request.
#       [System.Net.WebRequest]::DefaultWebProxy.GetProxy("<URL>") Gets proxy configuration 
        
