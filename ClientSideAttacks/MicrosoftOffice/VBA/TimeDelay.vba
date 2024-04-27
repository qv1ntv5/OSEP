Sub Wait(n As Long) 
' Accepts a integer as first and unique parameter.
    Dim t As Date 
    t = Now
    ' Defines 't' as a Date type variable and then asigns current time to it.
    Do
        DoEvents
    Loop Until Now >= DateAdd("s", n, t)
    ' Defines a 'Do' loop which DoEvents until certain condition is matched. This condition is 'n' number of seconds pass.
End Sub

' IN SUMMARY; this VBA script defines a function (Wait) which accepts an integer as an argument and makes a delay of that number of seconds.
