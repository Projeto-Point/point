/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package banco;

import com.github.britooo.looca.api.core.Looca;
import java.io.InputStream;
import java.net.InetAddress;
import javax.swing.Timer;
import org.apache.commons.logging.Log;
import org.springframework.jdbc.core.JdbcTemplate;
import java.net.InetAddress;
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
        Componente componentes = new Componente();
        Atributo atributo = new Atributo();
        
        System.out.println(looca.getMemoria().getTotal());
     
        
       
//        System.out.println(looca.getGrupoDeDiscos().getQuantidadeDeDiscos());
        
//        System.out.println(componentes.getTamanhoDiscoTotal());

        if(func.isFuncionarioCadastrado("ivan@.com", "123")){
           
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

