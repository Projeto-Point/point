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
public class Atributo {
    
   

    Looca looca = new Looca();
    Database database = new Database();
    JdbcTemplate connection = database.getConnection();
    Utilitarios utilitarios = new Utilitarios();
    
    
    // É aqui Agda -- Oq pensei foi, como vamos trabalhar com diversos tipos de máquina 
    // eleas podem ter mais de um do mesmo componte. Como por exemplo uma maquina tem varios
    // hds e isso faz com que tenha varios ids. AI queria retornar em um array todos os ids ai na hora 
    // de pegar os atributos ia colocar os atributos nos FkCompontes respesctivos. Porem não estou conseguindo
    // Retornar isso em um array. :( Desculpa! Não me tira do grupo pf

    public int getFksComponente(Maquina maquina, String nomeComponente) {
        
    
        
        List<Map<String, Object>> resultado = connection.queryForList("SELECT idComponente as fk FROM Componente C INNER JOIN Maquina M ON " + maquina.getId() + " = C.fkMaquina WHERE C.tipo like '" + nomeComponente + "';");
        
        if(resultado.size() > 0){
            
        JSONObject jsonResultado = new JSONObject(resultado.get(0));
        int idMaquina = jsonResultado.getInt("idMaquina");
        return idMaquina;
           
        }else{
            System.out.println("Não existe componentes");
            return 0;
        }
    }
    
    // Aqui nos inserts os ids Dos componentes é default - 1-CPU ; 2 - RAM ; 3 - HD
        
    private void inserirAtributo(String atributo, double valor, String unidadeDeMedida, Maquina maquina, int id){
        
        connection.update("INSERT INTO Atributo VALUES(null, ?, ?, ?, ?, ?);",
                    atributo,
                    valor,
                    unidadeDeMedida,
                    id,
                    maquina.getId()
                    
            );
    }
    
    private void inserirAtributo(String atributo, int valor, String unidadeDeMedida, Maquina maquina, int id){
        
        connection.update("INSERT INTO Atributo VALUES(null, ?, ?, ?, ?, ?);",
                    atributo,
                    valor,
                    unidadeDeMedida,
                    id,
                    maquina.getId()
                    
            );
    }
    
    
    private void insertQuantidadeDeCores(Maquina maquina){
        
        System.out.println("Inserindo Quantidade De Core");
        
        int core = looca.getProcessador().getNumeroCpusFisicas();
        
        inserirAtributo("CORE", core, "unidade", maquina, 1);
    }
    
    private void insertQuantidadeDeThreads(Maquina maquina){
        
         System.out.println("Inserindo Quantidade De Threads");
        
        int threads = looca.getProcessador().getNumeroCpusLogicas();
        
        inserirAtributo("THREADS", threads, "unidade", maquina, 1);
        
    }
    
    private void insertTamanhoTotalHD(Maquina maquina){
        
         System.out.println("Inserindo Quantidade De HD");
        
        long threads = looca.getGrupoDeDiscos().getTamanhoTotal();
        Double threadsGiga = utilitarios.converterBytesParaGiga(threads);
        threadsGiga = utilitarios.limitarDuasCasasDecimais(threadsGiga);
        
        
        inserirAtributo("Tamanho", threadsGiga, "GB",maquina, 3);
        
    }
    
    private void insertMemoriaRamTotal(Maquina maquina){
        
         System.out.println("Inserindo Quantidade De Ram");
        
        long memoriaRamTotal = looca.getMemoria().getTotal();
        Double memoriaRamTotalDouble = utilitarios.converterBytesParaGiga(memoriaRamTotal);
        memoriaRamTotalDouble = utilitarios.limitarDuasCasasDecimais(memoriaRamTotalDouble);
        
        inserirAtributo("Tamanho", memoriaRamTotalDouble, "GB", maquina, 2);
        
    }
    
    
    public void inserirTodosValores(Maquina maquina){
        
        insertMemoriaRamTotal(maquina);
        utilitarios.wait(1500);
        insertQuantidadeDeCores(maquina);
        utilitarios.wait(1500);
        insertQuantidadeDeThreads(maquina);
        utilitarios.wait(1500);
        insertTamanhoTotalHD(maquina);
    }
 
    
    

}
