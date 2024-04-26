$User32 = @"
using System;
using System.Runtime.InteropServices;

public class User32 {
    [DllImport("user32.dll", CharSet=CharSet.Auto)]
    public static extern int MessageBox(IntPtr hWnd, String text, 
        String caption, int options);
}
"@

# We add a block of text to a variable.

Add-Type $User32

# We implement this variable to our powershell session using 'Add-Type' directive.

[User32]::MessageBox(0, "This is an alert", "MyBox", 0)

# We make use of this variable.

# IN SUMMARY; in the upper block of text we have a C# code that invoke a Win32 API imported through a public class. The public class describes a C Win32 API importation through a C# mould. We can find C# moulds of common Win32 APIs in www.pinvoke.net.

# This means that if we want to import another Win32API in a PowerShell session we can reuse this code by reeplacing the public class content with another C Win32 API mould.