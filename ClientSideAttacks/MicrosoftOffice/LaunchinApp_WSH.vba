Sub Document_Open()
    MyMacro
End Sub

Sub AutoOpen()
    MyMacro
End Sub

' Both methods above make the macro run when document gets open. Only one is required for correct performance.

Sub MyMacro()
    Dim str As  ' Defines str as a String variable.
    str = "cmd.exe"
    CreateObject("Wscript.Shell").Run str, 0
End Sub

' This method create a WSH object and invokes his Run() method to run the application stored on the 'str' path location in a hidden window (0).