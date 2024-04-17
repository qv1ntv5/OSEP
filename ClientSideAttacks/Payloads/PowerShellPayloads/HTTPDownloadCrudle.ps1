$url = "<URL>" # Defines a variable which store the URL to download the file.
$out = "<OUTFILE>" # Defines a variable which store the location to store the download file.
$wc = New-Object Net.WebClient 
$wc.DownloadFile($url, $out) # Defines a WebClient object and invokes the DonwloadFile() method to make a HTTP request to a URL and stored its contents on OUTFILE.

# IN SUMMARY; this scripts downloads the contents through a HTTP request using a URL and storing its contents on OUTFILE.
