### Compiling C# with Visual Studio.

The C# code can be convert both to an executable or a DLL using VisualStudio basic. This can be achieved following the next steps:

- Open 'New Project'.
- Choose C# language and 'Console App' (or Class Library).
- Write your code on Program.cs
- Select on the Top Bar; Build > Build Solution.

Then a .exe or a .dll will be craft.

<br>

### DotNetToJScript.

For our bussiness, we are interested on convert C# Assembly (C# Compiled Code) into JScript.

For that purpouse we gonna use DotNetToJScript tool, which can be clone through the following Github repository:

- https://github.com/tyranid/DotNetToJScript

Then, we open the solution on Visual Studio by by double clicking the SLN file.

Once the Visual Studio IDE opens, we change Debug to Release and click Build > Build Solution.

Then, 

- a DotNetToJscript.exe and a .dll will be crafted 
- and the compilation of a C# code of TestClass.cs on a ExampleAssembly.dll

This ExampleAssembly can be traduced to javascript with the following command:

```cmd
DotNetToJScript.exe ExampleAssembly.dll --lang=Jscript --ver=v4 -o demo.js
```

<br>

### How to use the C# programs on this repository.

So, in order to use the the C# codes present on this repository we have to follow the next steps:

- Copy/paste the code on the TestClass.cs of the DotToNetJScript Visual Studio solution.
- Select Build > Build ExampleAssembly on Visual Studio IDE.
- Get all the componentes of the command above to run on the CMD the DotNetToJScript.exe and convert C# Assembly to JS.




















