package banco;

import com.github.britooo.looca.api.core.Looca;
import org.json.JSONObject;
import java.net.InetAddress;

public class Maquina {
    private Database banco;
    private Looca looca = new Looca();

    private Componente componente;
    private Atributo atributo;
    private Utilitarios utilitarios = new Utilitarios();

    private Integer id;
    private String sistemaOperacional;
    private String nomeMaquina;

    public Maquina(Database banco) {
        this.banco = banco;
        componente = new Componente(banco);
        atributo = new Atributo(banco);
    }

    public int selectIdMaquina(Funcionario funcionario) {
        JSONObject consulta = banco.consultarRegistro(String.format("SELECT M.idMaquina FROM Maquina M INNER JOIN Funcionario F ON F.idFuncionario = M.fkFuncionario WHERE F.idFuncionario = %d;", funcionario.getId()));

        if (!(consulta == null)) {
            int idMaquina = consulta.getInt("idMaquina");
            System.out.println("ID da máquina: " + idMaquina);
            return idMaquina;
        } else {
            System.out.println("Não encontrou nada");
            return 0;
        }

    }

    public Boolean isMaquinaCadastrada(Funcionario funcionario) {
        JSONObject consulta = banco.consultarRegistro(String.format("SELECT idMaquina, sistemaOperacional FROM Maquina WHERE nomeMaquina = '%s' AND fkFuncionario = %d;", getNomeMaquina(), funcionario.getId()));
        if (!(consulta == null)) {
            this.id = consulta.getInt("idMaquina");
            this.sistemaOperacional = consulta.getString("sistemaOperacional");
            return true;
        }
        else {
            System.out.println("Não encontrou nada");
            return false;
        }
    }

    public Boolean isCadastrarMaquina(Funcionario funcionario) {
        String so = looca.getSistema().getSistemaOperacional();

        try {
            banco.inserirRegistro(String.format("INSERT INTO Maquina (sistemaOperacional, nomeMaquina, tipo, fkFuncionario) VALUES('%s', '%s', 'DESKTOP', %d);",
                    so,
                    getNomeMaquina(),
                    funcionario.getId()
                )
            );
            
            System.out.println("Máquina cadastrada!");
            this.id = selectIdMaquina(funcionario);
            
            componente.insertComponentesTotal(this);
            Utilitarios.wait(1000);
            atributo.inserirTodosValores(this);

            return true;
        }
        catch (Exception e) {
            System.out.println("Não foi possível cadastrar Máquina");
            System.out.println(e);
            return false;
        }
    }
    
    public void setNomeMaquina(String nomeMaquina) {
        this.nomeMaquina = nomeMaquina;
    }

    public String getNomeMaquina() {
        try {
            // get system name
            String SystemName = InetAddress.getLocalHost().getHostName();
            this.nomeMaquina = SystemName;
            return SystemName;
        } catch (Exception E) {
            System.err.println(E.getMessage());
            return "Indefinido";
        }
    }
    
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getSistemaOperacional() {
        return sistemaOperacional;
    }

    public void setSistemaOperacional(String SistemaOperacional) {
        this.sistemaOperacional = SistemaOperacional;
    }
}
