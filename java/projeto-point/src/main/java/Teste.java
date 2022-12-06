
import com.github.britooo.looca.api.core.Looca;

public class Teste {
    public static void main(String[] args) {
        Looca looca = new Looca();
        
        System.out.println("Numero Cpus Fisicas: " + looca.getProcessador().getNumeroCpusFisicas());
        System.out.println("Numero Cpus Logicas: " + looca.getProcessador().getNumeroCpusLogicas());
    }
}
