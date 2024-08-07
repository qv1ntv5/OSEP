### Descripción

Esta es una forma de evadir la detección heuristica del AV a través de la detección del delay en un fragmento de código.

Se incorpora el fragmento de código 'Delay.cs' sobre el payload que será escaneado por el AV de forma que, si no se detecta delay significará que el código está siendo emulado y saldrá sin ejecutar ninguna linea de código maliciosa.