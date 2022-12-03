package banco;

import org.json.JSONObject;

public class Funcionario {
    private Integer id;
    private String nome;
    private String email;

    private Database banco;

    public Funcionario(Database banco) {
        this.banco = banco;
    }

    public Boolean isFuncionarioCadastrado(String email, String senha) {
        try {
            JSONObject consulta = banco.consultarRegistro(String.format("SELECT idFuncionario,nome from Funcionario where email = '%s' AND senha ='%s';",
                    email,
                    senha
                )
            );

            this.email = email;
            this.id = consulta.getInt("idFuncionario");
            this.nome = consulta.getString("nome");

            return true;
        }
        catch (Exception e) {
            return false;
        }
    }

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

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }
}