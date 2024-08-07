[DllImport("kernel32.dll")]
static extern void Sleep(uint dwMilliseconds); //Invoca la Win32 API 'Sleep' a través de la librería Kernel32.

static void Main(string[] args)
{
    DateTime t1 = DateTime.Now;
    Sleep(2000);
    double t2 = DateTime.Now.Subtract(t1).TotalSeconds;
    if(t2 < 1.5)
    {
        return;
    }
}//Guarda la variación de tiempo antes y después de llamar a Sleep() durante 2000 milisegundos. Seguidamente, si el tiempo transcurrido es menor de 1,5 segundos se da por hecho que no se ha ejecutado el Sleep y se sale del código.

