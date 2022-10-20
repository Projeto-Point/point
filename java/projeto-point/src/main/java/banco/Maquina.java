/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package banco;

import com.github.britooo.looca.api.core.Looca;
import java.io.IOException;
import java.io.InputStream;
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
    
    Componente componente = new Componente();
    Atributo atributo = new Atributo();
    Utilitarios utilitarios = new Utilitarios();
   

    private Integer id;
    private String SistemaOperacional;
    private String nomeMaquina;
    
    public void setNomeMaquina(String nomeMaquina){
        
        this.nomeMaquina = nomeMaquina;
    }

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
    
    public String getNomeMaquina()
    {
        try {
 
            // get system name
            String SystemName
                = InetAddress.getLocalHost().getHostName();
           this.nomeMaquina = SystemName;
           return SystemName;
        }
        catch (Exception E) {
            System.err.println(E.getMessage());
            return "Indefinido";
        }
    }
    
    public int selectIdMaquina(Funcionario funcionario){
        
        List<Map<String, Object>> resultado = connection.queryForList("SELECT M.idMaquina FROM Maquina M INNER JOIN Funcionario F ON F.idFuncionario = M.fkFuncionario WHERE F.idFuncionario = " + funcionario.getId() + ";");
        if (!resultado.isEmpty()) {
            JSONObject jsonResultado = new JSONObject(resultado.get(0));
            int idMaquina = jsonResultado.getInt("idMaquina");
            System.out.println(idMaquina);
            return idMaquina;
        }else{
             System.out.println("Não encontrou nada");
             return 0;
        }
       
       
    }

    public Boolean isMaquinaCadastrada(Funcionario funcionario) {
        
        
        List<Map<String, Object>> resultado = connection.queryForList("SELECT idMaquina, sistemaOperacional FROM Maquina INNER JOIN Funcionario ON idFuncionario = fkFuncionario WHERE idFuncionario = " + funcionario.getId() + ";");
        if (!resultado.isEmpty()) {
            JSONObject jsonResultado = new JSONObject(resultado.get(0));
            int idMaquina = jsonResultado.getInt("idMaquina");
            String so = jsonResultado.getString("sistemaOperacional");
            this.id = idMaquina;
            this.SistemaOperacional = so;

            return true;
        }else{
             System.out.println("Não encontrou nada");
             return false;
        }
        
    }

    public Boolean isCadastrarMaquina(Funcionario funcionario) {

        String so = looca.getSistema().getSistemaOperacional();

        try {

            connection.update("INSERT INTO Maquina VALUES(?, ?, ?, ?, ?);",
                    null,
                    so,
                    getNomeMaquina(),
                    "DESKTOP",
                    funcionario.getId()
                    
            );
            
            System.out.println("Cadastrou");
            
            Utilitarios.wait(1000);
            this.id = selectIdMaquina(funcionario);
            componente.insertComponentesTotal(this);
            Utilitarios.wait(1000);
            atributo.inserirTodosValores(this);

            return true;

        } catch (Exception e) {

            System.out.println("Não foi possível cadastrar Máquina");
            System.out.println(e);
            return false;
        }

    }

    

}
