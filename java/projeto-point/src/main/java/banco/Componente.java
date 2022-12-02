package banco;

import com.github.britooo.looca.api.core.Looca;
import org.json.JSONObject;

public class Componente {
    private Looca looca = new Looca();
    private Database banco;
    private Integer id = 0;

    public Componente(Database banco) {
        this.banco = banco;
    }
    
    private void insertsComponentes(Maquina maquina, String nomeComponte){
        id++;
        
        banco.inserirRegistro(String.format("INSERT INTO Componente (idComponente, tipo, fkMaquina) VALUES (%d, '%s', %d)",
                id,
                nomeComponte,
                maquina.getId()
            )
        );
    }

    private void insertDiscos(Maquina maquina) {
        if (maquina.getId() != null) {
            insertsComponentes(maquina, "DISCO");
            System.out.println("HD cadastrado");
        }
        else {
            System.out.println("Maquina está null");
        }
    }
    
    private void insertProcessadoresFisicos(Maquina maquina){
        if (maquina.getId() != null) {
            insertsComponentes(maquina, "CPU");
            System.out.println("CPU Cadastrada");
        }
        else{
            System.out.println("Maquina está null");
        }   
    }
    
    private void insertMemoriaVirtual(Maquina maquina){
        if (maquina.getId() != null) {
            insertsComponentes(maquina, "RAM");
            System.out.println("Memória Ram cadastrada");
        }
        else{
            System.out.println("Maquina está null");
        }
    }
    
    
    public void insertComponentesTotal(Maquina maquina){
        insertProcessadoresFisicos(maquina);
        insertMemoriaVirtual(maquina);
        insertDiscos(maquina);
    }
}


