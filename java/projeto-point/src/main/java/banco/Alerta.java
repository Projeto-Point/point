package banco;

import java.util.List;
import java.util.Map;
import org.json.JSONObject;
import org.springframework.jdbc.core.JdbcTemplate;

public class Alerta {
    private Maquina maquina;
    private Database database = new Database();
    private JdbcTemplate connection = database.getConnection();

    public Alerta(Maquina maquina) {
        this.maquina = maquina;
    }
    
    public void criarAlerta(String componente, Double valor){
        try {
            connection.update("INSERT INTO Alerta (dataEhora, titulo, resolucao, componente, valor, fkMaquina) VALUES (GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Bahia Standard Time', ?, 'ABERTO', ?, ?, ?);", 
                    String.format("%s está com %.2f%%", componente, valor),
                    componente,
                    valor,
                    maquina.getId()
            );
            
            System.out.println("Alerta inserido");
            
            Utilitarios.wait(1000);
        } catch (Exception e) {
            System.out.println("Não foi possível criar um alerta");
            System.out.println(e);
        }
    }
    
    public String verificarUltimoAlerta(String componente){
        List<Map<String, Object>> resultado = connection.queryForList(String.format("SELECT TOP 1 resolucao FROM Alerta WHERE fkMaquina = %d AND componente = '%s' ORDER BY dataEhora DESC;", maquina.getId(), componente));
        
        String resolucao = "FECHADO";
        
        if(!resultado.isEmpty()){
            JSONObject jsonResultado = new JSONObject(resultado.get(0));
            resolucao = jsonResultado.getString("resolucao");
        }
        
        return resolucao;
    }
    
    public void fecharAlerta(String componente){
        try{
            connection.update(String.format("UPDATE Alerta SET resolucao = 'FECHADO' WHERE fkMaquina = %d AND componente = '%s'", maquina.getId(), componente));
            
            System.out.println("Alerta atualizado");
            
            Utilitarios.wait(1000);
        }
        catch (Exception e){
            System.out.println("Houve um erro ao atualizar o alerta!");
            System.out.println(e);
        }
    }
}
