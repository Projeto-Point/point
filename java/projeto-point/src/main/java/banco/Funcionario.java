/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package banco;

import java.util.List;
import java.util.Map;
import org.json.JSONObject;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.JdbcTemplate;

/**
 *
 * @author ivanm
 */
public class Funcionario {

    private Integer id;
    private String nome;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getNome() {
        return nome;
    }

    public void setNome(String nome) {
        this.nome = nome;
    }
    

    Database database = new Database();

    JdbcTemplate connection = database.getConnection();

    public Boolean isFuncionarioCadastrado(String email, String senha) {

        try {
            List<Map<String, Object>> resultado = connection.queryForList("SELECT idFuncionario,nome from Funcionario where email = '" + email + "' AND senha ='" + senha + "';");

            JSONObject jsonResultado = new JSONObject(resultado.get(0));

            int id = jsonResultado.getInt("idFuncionario");
            String nome = jsonResultado.getString("nome");

           this.id = id;
           this.nome = nome;

            return true;
        } catch (Exception e) {
  
            return false;
        }

    }

}
