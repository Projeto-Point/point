package banco;

import java.text.DecimalFormat;
import java.util.List;
import org.json.JSONObject;

public class TesteBanco {
    public static void main(String[] args) {
        
//        JSONObject consulta = banco.consultarRegistro("SELECT M.idMaquina FROM Maquina M INNER JOIN Funcionario F ON F.idFuncionario = M.fkFuncionario WHERE F.idFuncionario = 20;");
//        System.out.println(consulta);
        
        // banco.inserirRegistro(String.format("INSERT INTO RegistroAgda (numero) VALUES (%s)", Utilitarios.limitarDuasCasasDecimais(34.4).toString()));
    }
}
