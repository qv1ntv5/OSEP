using System.Diagnostics;
using System.Runtime.InteropServices;
using System.Windows.Forms;

[ComVisible(true)]
public class TestClass
{
    public TestClass()
    {
        Process process = new Process();
        // Set the StartInfo.FileName property to the path of the CMD executable.
        process.StartInfo.FileName = "cmd.exe";
        process.Start();
    }
    public void RunProcess(string path)
    {
        Process.Start(path);
    }
}