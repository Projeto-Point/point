package banco;

public class Utilitarios {
    public static Double converterBytesParaGiga(Long valorEmBytes){
        double valorEmBytesDouble = (double)valorEmBytes;
        valorEmBytesDouble *= 0.000_000_000_931_322_574_615_48;
        
        return valorEmBytesDouble;
    }
    
    public static Double converterBytesParaGiga(Double valorEmBytes){
        valorEmBytes *= 0.000_000_000_931_322_574_615_48;
        return valorEmBytes;
    }
    
    public static Double limitarDuasCasasDecimais(Double valorDouble){
        return (double) Math.round(valorDouble * 100) / 100;
    }
    
    public static Double limitarDuasCasasDecimais(Long valorDouble){
        return (double) Math.round(valorDouble * 100) / 100;
    }
    
    public static void wait(int ms)
    {
        try {
            Thread.sleep(ms);
        }
        catch (InterruptedException ex) {
            Thread.currentThread().interrupt();
        }
    }
    
}
