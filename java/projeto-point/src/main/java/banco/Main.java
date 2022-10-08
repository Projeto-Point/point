/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package banco;

import com.github.britooo.looca.api.core.Looca;
import javax.swing.Timer;
import org.apache.commons.logging.Log;
import org.springframework.jdbc.core.JdbcTemplate;

/**
 *
 * @author ivanm
 */
public class Main {

    public static void main(String[] args) {

        Looca looca = new Looca();
        
        Database database = new Database();
        
        JdbcTemplate connection = database.getConnection();
        
        Funcionario func = new Funcionario();
        
        
        
        Boolean x = func.isFuncionarioCadastrado("nome@sptech.school", "123");
        
      
        
     
        

    }

}
