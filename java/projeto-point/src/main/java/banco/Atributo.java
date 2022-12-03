package banco;

import com.github.britooo.looca.api.core.Looca;
import org.json.JSONObject;

public class Atributo {
    private Looca looca = new Looca();
    private Database banco;

    public Atributo(Database banco) {
        this.banco = banco;
    }

    public int getFksComponente(Maquina maquina, String nomeComponente) {
        JSONObject consulta = banco.consultarRegistro(String.format("SELECT idComponente as fk FROM Componente C INNER JOIN Maquina M ON %d = C.fkMaquina WHERE C.tipo like '%s';",
                maquina.getId(),
                nomeComponente
            )
        );

        if(!(consulta == null)){
            int idMaquina = consulta.getInt("idMaquina");
            return idMaquina;
        }
        else {
            System.out.println("Não existe componentes");
            return 0;
        }
    }

    // Aqui nos inserts os ids Dos componentes é default - 1-CPU ; 2 - RAM ; 3 - HD
    private void inserirAtributo(Integer idAtributo, String atributo, double valor, String unidadeDeMedida, Maquina maquina, int id) {
        banco.inserirRegistro(String.format("INSERT INTO Atributo (atributo, valor, unidadeMedida, fkComponente, fkMaquina) VALUES('%s', %s, '%s', %d, %d);",
                atributo,
                Utilitarios.limitarDuasCasasDecimais(valor),
                unidadeDeMedida,
                id,
                maquina.getId()
            )
        );
    }

    private void inserirAtributo(Integer idAtributo, String atributo, int valor, String unidadeDeMedida, Maquina maquina, int id) {
        banco.inserirRegistro(String.format("INSERT INTO Atributo (atributo, valor, unidadeMedida, fkComponente, fkMaquina) VALUES('%s', %d, '%s', %d, %d);",
                atributo,
                valor,
                unidadeDeMedida,
                id,
                maquina.getId()
            )
        );
    }

    private void insertQuantidadeDeCores(Maquina maquina) {
        System.out.println("Inserindo Quantidade De Core");

        int core = looca.getProcessador().getNumeroCpusFisicas();
        inserirAtributo(1, "CORE", core, "unidade", maquina, 1);
    }

    private void insertQuantidadeDeThreads(Maquina maquina) {
        System.out.println("Inserindo Quantidade De Threads");

        int threads = looca.getProcessador().getNumeroCpusLogicas();
        inserirAtributo(1, "THREADS", threads, "unidade", maquina, 1);

    }

    private void insertTamanhoTotalHD(Maquina maquina) {
        System.out.println("Inserindo Quantidade De HD");

        long threads = looca.getGrupoDeDiscos().getTamanhoTotal();
        Double threadsGiga = Utilitarios.converterBytesParaGiga(threads);
        threadsGiga = Utilitarios.limitarDuasCasasDecimais(threadsGiga);
        inserirAtributo(3, "Tamanho", threadsGiga, "GB", maquina, 3);
    }

    private void insertMemoriaRamTotal(Maquina maquina) {
        System.out.println("Inserindo Quantidade De Ram");

        long memoriaRamTotal = looca.getMemoria().getTotal();
        Double memoriaRamTotalDouble = Utilitarios.converterBytesParaGiga(memoriaRamTotal);
        memoriaRamTotalDouble = Utilitarios.limitarDuasCasasDecimais(memoriaRamTotalDouble);
        inserirAtributo(2, "Tamanho", memoriaRamTotalDouble, "GB", maquina, 2);
    }

    public void inserirTodosValores(Maquina maquina) {
        insertMemoriaRamTotal(maquina);
        insertQuantidadeDeCores(maquina);
        insertQuantidadeDeThreads(maquina);
        insertTamanhoTotalHD(maquina);
    }
}
