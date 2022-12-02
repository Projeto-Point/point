package banco;

import org.json.JSONObject;

public class Alerta {
    private Maquina maquina;
    private Database banco;

    public Alerta(Database banco, Maquina maquina) {
        this.banco = banco;
        this.maquina = maquina;
    }
    
    public void criarAlerta(String componente, Double valor){
        try {
            banco.inserirRegistro(String.format("INSERT INTO Alerta (dataEhora, titulo, resolucao, componente, valor, fkMaquina) VALUES (DATA, '%s', 'ABERTO', '%s', %s, %d);",
                    String.format("%s está com %.2f%%", componente, valor),
                    componente,
                    Utilitarios.limitarDuasCasasDecimais(valor),
                    maquina.getId()
                )
            );
            
            System.out.println("Alerta inserido");
        }
        catch (Exception e) {
            System.out.println("Não foi possível criar um alerta");
            System.out.println(e);
        }
    }
    
    public String verificarUltimoAlerta(String componente){
        JSONObject consulta = banco.consultarRegistro(String.format("SELECT TOP 1 resolucao FROM Alerta WHERE fkMaquina = %d AND componente = '%s' ORDER BY dataEhora DESC;",
                maquina.getId(), 
                componente
            )
        );   
        
        String resolucao = "FECHADO";
        
        if(!(consulta == null)){
            resolucao = consulta.getString("resolucao");
        }
        
        return resolucao;
    }
    
    public void fecharAlerta(String componente){
        try{
            banco.inserirRegistro(String.format("UPDATE Alerta SET resolucao = 'FECHADO' WHERE fkMaquina = %d AND componente = '%s'", maquina.getId(), componente));
            System.out.println("Alerta atualizado");
        }
        catch (Exception e){
            System.out.println("Houve um erro ao atualizar o alerta!");
            System.out.println(e);
        }
    }
}
