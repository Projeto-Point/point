package banco;

import java.util.List;
import java.util.Map;
import org.springframework.jdbc.core.JdbcTemplate;

public class Alerta {
    private Maquina maquina;
    
    private Database database = new Database();
    private JdbcTemplate connection = database.getConnection();
    
    public void criarAlerta(String componente, Double valor){
        try {
            connection.update(String.format("INSERT INTO Alerta (dataEhora, tituto, resolucao, componentes, valor, fkMaquina) VALUES (GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Bahia Standard Time', '%s está com %.2f', 'Aberto', '%s', %.2f, %d)", componente, valor, componente, valor, maquina.getId()));
            
            System.out.println("Alerta inserido");
            
            Utilitarios.wait(1000);
        } catch (Exception e) {
            System.out.println("Não foi possível criar um alerta");
            System.out.println(e);
        }
    }
    
    public Boolean hasAlerta(){
        List<Map<String, Object>> resultado = connection.queryForList(String.format("SELECT TOP 1 resolucao FROM Alerta WHERE fkMaquina = %d ORDER BY dataEhora DESC;", maquina.getId()));
        
        if(!resultado.isEmpty()){
            return true;
        }
        
        return false;
    }
}
