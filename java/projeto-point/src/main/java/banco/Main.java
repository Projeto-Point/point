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
    
        
        Funcionario func = new Funcionario();
        Maquina maquina = new Maquina();
        Componentes componentes = new Componentes();
    
        
       
//         Colocar como parâmetro o email do usuário criado + senha com aspas
        if(func.isFuncionarioCadastrado("steh@.com", "123")){
           
            System.out.println(maquina.isMaquinaCadastrada(func));
            
            if (maquina.isMaquinaCadastrada(func)) {
                System.out.println("Máquina já cadastrada");
            }else if (maquina.isCadastrarMaquina(func)){
                System.out.println("Máquina Cadastrada");
            }else{
                System.out.println("Não foi possível encontrar máquina/cadastar máquina");
            }
        }else{
            System.out.println("Funcionário não encontrado");
        }
    }

}
