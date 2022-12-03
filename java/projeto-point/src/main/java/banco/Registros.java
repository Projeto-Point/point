package banco;

import org.springframework.jdbc.core.JdbcTemplate;
import com.github.britooo.looca.api.core.Looca;
import java.util.List;
import java.util.Map;
import org.json.JSONObject;

public class Registros {
    private Looca looca = new Looca();
    private Database banco;

    public Registros(Database banco) {
        this.banco = banco;
    }

    public Double getVolumeTotal() {
        String retornoTotal = looca.getGrupoDeDiscos().getVolumes().toString();

        String[] retornoSeparado = retornoTotal.split(":");

        String total = retornoSeparado[2];

        String[] arrTotal = total.split(" ");

        String palavra = arrTotal[1];

        String[] arrEspacoTotalString = palavra.split("\n");

        String espacoTotalString = arrEspacoTotalString[0];

        Long valorEspaco = Long.parseLong(espacoTotalString);

        Double valorEspacoDouble = Utilitarios.converterBytesParaGiga(valorEspaco);

        valorEspacoDouble = Utilitarios.limitarDuasCasasDecimais(valorEspacoDouble);

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

        Double valorEspacoDouble = Utilitarios.converterBytesParaGiga(valorEspaco);

        valorEspacoDouble = Utilitarios.limitarDuasCasasDecimais(valorEspacoDouble);

        return valorEspacoDouble;
    }

    public Double getPorcentagemVolume() {
        Double total = getVolumeTotal();
        Double uso = getVolumeDisponivel();
        Double porcentagemDisponivel = uso / total;
        Double porcentagemUso = 1.0 - porcentagemDisponivel;
        porcentagemUso = Utilitarios.limitarDuasCasasDecimais(porcentagemUso);

        return porcentagemUso * 100;
    }

    private void scriptInsert(Maquina maquina, int idComponente, Double valor, String unidadeMedida) {
        int idMaquina = maquina.getId();

        banco.inserirRegistro(String.format("INSERT INTO Registro (fkMaquina, fkComponente, dataEhora, valor, unidadeMedida) VALUES(%d, %d, DATA, %s, '%s');",
                idMaquina,
                idComponente,
                Utilitarios.limitarDuasCasasDecimais(valor),
                unidadeMedida
            )
        );
    }

    private void insertCPURegistro(Maquina maquina) {
        Double percentCPU = looca.getProcessador().getUso();
        percentCPU = Utilitarios.limitarDuasCasasDecimais(percentCPU);

        scriptInsert(maquina, 1, percentCPU, "%");
    }

    private void insertRAMRegistro(Maquina maquina) {
        Long memoriaTotal = looca.getMemoria().getTotal();
        Long memoriaUso = looca.getMemoria().getEmUso();
        Double x = Utilitarios.converterBytesParaGiga(memoriaTotal);
        Double y = Utilitarios.converterBytesParaGiga(memoriaUso);
        Double porc = y / x;
        porc = porc * 100;

        scriptInsert(maquina, 2, porc, "%");
    }
    
    private void insertVolumeRegistro(Maquina maquina){
        Double porcentagemVolume = getPorcentagemVolume();
        scriptInsert(maquina, 3, porcentagemVolume, "%");
    }
    
    public void insertQtdProcesso(Maquina maquina){
        Integer qtdProcessos = looca.getGrupoDeProcessos().getTotalProcessos();

        banco.inserirRegistro(String.format("INSERT INTO RegistroAgda (qtdProcessos, dataEhora, fkMaquina) VALUES(%d, DATA, %d);",
                qtdProcessos,
                maquina.getId()
            )
        );
    }
    
    public void inserirRegistros(Maquina maquina){
        insertCPURegistro(maquina);
        insertRAMRegistro(maquina);
        insertVolumeRegistro(maquina);
        insertQtdProcesso(maquina);
    }
}
