/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package banco;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.github.britooo.looca.api.core.Looca;
import com.mashape.unirest.http.HttpResponse;
import com.mashape.unirest.http.Unirest;
import com.mashape.unirest.http.exceptions.UnirestException;
import java.io.IOException;
import java.net.URL;
import org.springframework.jdbc.core.JdbcTemplate;

import java.util.List;
import java.util.Map;

/**
 *
 * @author ivanm
 */
public class Main {

    public static void main(String[] args) throws UnirestException {

        Looca looca = new Looca();

        Database database = new Database();
        Utilitarios utilitarios = new Utilitarios();

        Funcionario func = new Funcionario();
        Maquina maquina = new Maquina();
        Componente componentes = new Componente();
        Atributo atributo = new Atributo();
        Registros registro = new Registros();
      
        if (func.isFuncionarioCadastrado("cleber@point.com", "123456")) {

            System.out.println(maquina.isMaquinaCadastrada(func));

            if (maquina.isMaquinaCadastrada(func)) {
                System.out.println("Máquina já cadastrada");
            } else if (maquina.isCadastrarMaquina(func)) {
                System.out.println("Máquina Cadastrada");
            } else {
                System.out.println("Não foi possível encontrar máquina/cadastar máquina");
            }
        }
        else {
            System.out.println("Funcionário não encontrado");
        }
        
        ConexaoPipefySlack conexao = new ConexaoPipefySlack(func);
        Alerta alerta = new Alerta(maquina);
        
        Double porcentagemRam = (double) looca.getMemoria().getEmUso() / looca.getMemoria().getTotal() * 100;
        Double porcentagemCpu = looca.getProcessador().getUso();
        
        porcentagemCpu = 23.00;
        
        
        
        if(porcentagemCpu >= 80){
            if(alerta.verificarUltimoAlerta("CPU").equals("FECHADO")){
                alerta.criarAlerta("CPU", porcentagemCpu);
                conexao.enviarAlerta(String.format("CPU está com %.1f%%!", porcentagemCpu), func);
                System.out.println("Alerta inserido!");
            }
        }
        else{
            if(alerta.verificarUltimoAlerta("CPU").equals("ABERTO")){
                alerta.fecharAlerta("CPU");
            }
        }
    }
}
