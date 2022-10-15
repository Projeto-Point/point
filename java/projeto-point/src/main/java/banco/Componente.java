/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package banco;

import com.github.britooo.looca.api.core.Looca;
import java.util.List;
import java.util.Map;
import org.json.JSONObject;
import org.springframework.jdbc.core.JdbcTemplate;

/**
 *
 * @author ivanm
 */
public class Componente {

    Looca looca = new Looca();
    Database database = new Database();
    JdbcTemplate connection = database.getConnection();
    
    
    
    public Integer getMaxId(Maquina maquina) {

        List<Map<String, Object>> resultado = connection.queryForList("SELECT max(C.idComponente) as id FROM Componente C INNER JOIN Maquina M ON M.idMaquina = C.fkMaquina WHERE idMaquina = " + maquina.getId() + ";");

        JSONObject jsonResultado = new JSONObject(resultado.get(0));

        if(jsonResultado.length() > 0){
            return jsonResultado.getInt("id");
        }else{
            
            return 0;
        }

    }
    
    private void insertsComponentes(Maquina maquina, String nomeComponte){
        
        Integer id = getMaxId(maquina);
        id++;
        
         connection.update("INSERT INTO Componente VALUES (?,?,?)",
                        id,
                        maquina.getId(),
                        nomeComponte
                );
        
    }

    public void insertDiscos(Maquina maquina) {

        if (maquina.getId() != null) {
            
            
            
            Integer qtdDisco = looca.getGrupoDeDiscos().getQuantidadeDeDiscos();
            Integer id = getMaxId(maquina);
            id ++;

            for (int i = 0; i < qtdDisco; i++) {
                insertsComponentes(maquina, "HD");
                System.out.println("HD cadastrado");
            }

        }else{
            System.out.println("Maquina está null");
        }
        
    }
    
    public void insertProcessadoresFisicos(Maquina maquina){
        
        if (maquina.getId() != null) {
            
            
            Integer qtdCPU = looca.getProcessador().getNumeroPacotesFisicos();
            Integer id = getMaxId(maquina);
            id ++;

            for (int i = 0; i < qtdCPU; i++) {
                insertsComponentes(maquina, "CPU");
                System.out.println("CPU Cadastrada");
            }

        }else{
            System.out.println("Maquina está null");
        }
        
    }
    
    public void insertMemoriaVirtual(Maquina maquina){
        
        insertsComponentes(maquina, "Memória RAM");
        System.out.println("Memória Ram cadastrada");
    }
    
    
    public void insertComponentesTotal(Maquina maquina){
        
        insertDiscos(maquina);
        insertMemoriaVirtual(maquina);
        insertProcessadoresFisicos(maquina);
        
    }
        
}

