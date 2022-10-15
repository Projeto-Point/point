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
    
    
    // É aqui Agda -- Oq pensei foi, como vamos trabalhar com diversos tipos de máquina 
    // eleas podem ter mais de um do mesmo componte. Como por exemplo uma maquina tem varios
    // hds e isso faz com que tenha varios ids. AI queria retornar em um array todos os ids ai na hora 
    // de pegar os atributos ia colocar os atributos nos FkCompontes respesctivos. Porem não estou conseguindo
    // Retornar isso em um array. :( Desculpa! Não me tira do grupo pf

    public int [] getFksComponente(Maquina maquina, String nomeComponente) {
        
        
        JSONObject jsonResultado = new JSONObject();
        
        List<Map<String, Object>> resultado = connection.queryForList("SELECT idComponente as fk FROM Componente C INNER JOIN Maquina M ON M.idMaquina = C.fkMaquina WHERE C.tipo like '" + nomeComponente + "';");
        
        for (Map<String, Object> map : resultado)
        {
            jsonResultado.append("fk", map);
        }
        
        
        int[] arrFks;
        arrFks = new int[jsonResultado.length()];
        System.out.println("O tamanho do json é: " + jsonResultado.length());
        if (jsonResultado.length() > 0) {
            
            for(int i=0; i<jsonResultado.length();i++){
                
                System.out.println(jsonResultado);
                arrFks[i] = jsonResultado.getInt("fk");
                
            }
            
            return arrFks;
        } else {

            return null;
        }

    }
    

    private void insertTodosAtributos(Maquina maquina){
        
        int[] fksCompontentes = getFksComponente(maquina, "Nome Componente");
        
        int numeroDeComponentes = fksCompontentes.length;
        
        fksCompontentes = new int[numeroDeComponentes];
        
        
        
    }
    
    
}
