$Assemblies = [AppDomain]::CurrentDomain.GetAssemblies()

# This line imports GetAssemblies() method of the CurrentDomain propierty from the AppDomain .Net framework class and saves the return value on $Assemblies.

$Assemblies |
ForEach-Object {
    $_.GetTypes() |
    ForEach-Object {
        $_ | Get-Member -Static | Where-Object {
            $_.TypeName.Contains('Unsafe')
        }
    } 2> $null
}

# This block of code parse the object and retrieve the types and the static members in search of anyone that contains the 'unsafe' substring retrieve those assemblies that have unsafe static members as types.