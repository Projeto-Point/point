/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package banco;

import org.springframework.jdbc.core.JdbcTemplate;
import com.github.britooo.looca.api.core.Looca;
import java.util.List;
import java.util.Map;
import org.json.JSONObject;

/**
 *
 * @author ivanm
 */
public class Registros {

    Looca looca = new Looca();
    Database database = new Database();
    JdbcTemplate connection = database.getConnection();
    Utilitarios utilitarios = new Utilitarios();

    public Double getVolumeTotal() {

        String retornoTotal = looca.getGrupoDeDiscos().getVolumes().toString();

        String[] retornoSeparado = retornoTotal.split(":");

        String total = retornoSeparado[2];

        String[] arrTotal = total.split(" ");

        String palavra = arrTotal[1];

        String[] arrEspacoTotalString = palavra.split("\n");

        String espacoTotalString = arrEspacoTotalString[0];

        Long valorEspaco = Long.parseLong(espacoTotalString);

        Double valorEspacoDouble = utilitarios.converterBytesParaGiga(valorEspaco);

        valorEspacoDouble = utilitarios.limitarDuasCasasDecimais(valorEspacoDouble);

        return valorEspacoDouble;

    }

    public Double getVolumeDisponivel() {

        String retornoTotal = looca.getGrupoDeDiscos().getVolumes().toString();

        String[] retornoSeparado = retornoTotal.split(":");

        String total = retornoSeparado[3];

        String[] arrDisponivel = total.split(" ");

        String palavra = arrDisponivel[1];

        String[] arrEspacoDisponivelString = palavra.split("\n");

        String espacoDisponivelString = arrEspacoDisponivelString[0];

        Long valorEspaco = Long.parseLong(espacoDisponivelString);

        Double valorEspacoDouble = utilitarios.converterBytesParaGiga(valorEspaco);

        valorEspacoDouble = utilitarios.limitarDuasCasasDecimais(valorEspacoDouble);

        return valorEspacoDouble;

    }

    public Double getPorcentagemVolume() {

        Double total = getVolumeTotal();
        Double uso = getVolumeDisponivel();
        Double porcentagemDisponivel = uso / total;
        Double porcentagemUso = 1.0 - porcentagemDisponivel;
        porcentagemUso = utilitarios.limitarDuasCasasDecimais(porcentagemUso);

        return porcentagemUso * 100;
    }

    private void scriptInsert(Maquina maquina, int idComponente, Double valor, String unidadeMedida) {

        int idMaquina = maquina.getId();

        utilitarios.wait(300000);
        connection.update("INSERT INTO Registro VALUES(?, ?, now(), ?, ?);",
                idMaquina,
                idComponente,
                valor,
                unidadeMedida
        );
    }

    private void insertCPURegistro(Maquina maquina) {

        Double percentCPU = looca.getProcessador().getUso();
        percentCPU = utilitarios.limitarDuasCasasDecimais(percentCPU);

        scriptInsert(maquina, 1, percentCPU, "%");
    }

    private void insertRAMRegistro(Maquina maquina) {

        Long memoriaTotal = looca.getMemoria().getTotal();
        Long memoriaUso = looca.getMemoria().getEmUso();
        Double x = utilitarios.converterBytesParaGiga(memoriaTotal);
        Double y = utilitarios.converterBytesParaGiga(memoriaUso);
        Double porc = y / x;
        porc = porc * 100;

        scriptInsert(maquina, 2, porc, "%");

    }
    
    private void insertVolumeRegistro(Maquina maquina){
        
        Double porcentagemVolume = getPorcentagemVolume();
        
        scriptInsert(maquina, 3, porcentagemVolume, "%");
        
    }
    
    public void inserirRegistros(Maquina maquina){
        
        insertCPURegistro(maquina);
        insertRAMRegistro(maquina);
        insertVolumeRegistro(maquina);
        
    }
    
   
}
