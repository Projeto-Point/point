/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package banco;

import java.util.List;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

/**
 *
 * @author ivanm
 */
public class Funcionario {

    private Integer id;
    private String nome;
    

    Database database = new Database();

    JdbcTemplate connection = database.getConnection();

  
    public Boolean isFuncionarioCadastrado(String email, String senha) {
     
         
          List <Funcionario> resultado = connection.query("SELECT nome from Funcionario where email = '" + email + "' AND senha ='" + senha + "';", 
                new BeanPropertyRowMapper(Funcionario.class));
          
          
         for (Funcionario funcionario : resultado) {
            
             return funcionario.toString().length() > 0;
             
         }
             
         return false;
    }
    
    
}
        
  


