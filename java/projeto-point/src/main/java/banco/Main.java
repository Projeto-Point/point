/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package banco;

import com.github.britooo.looca.api.core.Looca;
import java.net.InetAddress;
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
        Maquina maquina = new Maquina();

        
        if(func.isFuncionarioCadastrado("iva@.com", "123")){
            maquina.isMaquinaCadastrada(func);
            System.out.println(String.format("Nome funcionário: %s\nSO: %s\n", func.getNome(), maquina.getSistemaOperacional()));
        }else{
            System.out.println("Funcionário não encontrado");
        }
  
        
        
       
        
    }

}
