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
import java.net.InetAddress;
/**
 *
 * @author ivanm
 */
public class Maquina {
    
    Looca looca = new Looca();
    
    Database database = new Database();

    JdbcTemplate connection = database.getConnection();
    
    private Integer id;
    private String SistemaOperacional ;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getSistemaOperacional() {
        return SistemaOperacional;
    }

    public void setSistemaOperacional(String SistemaOperacional) {
        this.SistemaOperacional = SistemaOperacional;
    }
    
    
    public Boolean isMaquinaCadastrada(Funcionario funcionario){
         
        try {
            
            List<Map<String, Object>> resultado = connection.queryForList
        ("SELECT idMaquina, sistemaOperacional FROM Maquina INNER JOIN Funcionario ON idFuncionario = fkFuncionario WHERE idFuncionario = " + funcionario.getId() + ";");
            
            JSONObject jsonResultado = new JSONObject(resultado.get(0));
            System.out.println(jsonResultado);
            int idMaquina = jsonResultado.getInt("idMaquina");
            String so = jsonResultado.getString("sistemaOperacional");
 
            this.id = idMaquina;
            this.SistemaOperacional = so;     
            
            return true;
        } catch (Exception e) {
            
            System.out.println(e);
            return false;
        }
    }
    
    
    public Boolean isCadastrarMaquina(Funcionario funcionario){
          
        String so = looca.getSistema().getSistemaOperacional();
        try {
            
            connection.update("INSERT INTO Maquina VALUES(?, ?, ?, ?);", 
            null, 
            so,
            null,
            funcionario.getId()
            );
           
            return true;
         
        } catch (Exception e) {
         
            return false;
        }
         
    }
    
}
