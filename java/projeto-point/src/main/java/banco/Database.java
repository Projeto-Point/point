package banco;

import java.util.List;
import java.util.Map;
import org.apache.commons.dbcp2.BasicDataSource;
import org.json.JSONObject;
import org.springframework.jdbc.core.JdbcTemplate;

public class Database {
    // Conexões
    private JdbcTemplate conexaoMySQL;
    private JdbcTemplate conexaoSqlServer;
    
    // Credenciais da azure
    private String serverSqlServer = "bd-point.database.windows.net:1433";
    private String usernameSqlServer = "adm-point@bd-point";
    private String passwordSqlServer = "1cco#grupo1";
    private String databaseSqlServer = "bd-point";
    
    // Credenciais do MySQL
    private String databaseMySql = "bd_point";
    private String usernameMySql = "aluno";
    private String passwordMySql = "sptech";
    
    public Database() {
        // Azure
        BasicDataSource dataSourceSqlServer = new BasicDataSource();
        dataSource​SqlServer.setDriverClassName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        
        dataSource​SqlServer.setUrl(String.format("jdbc:sqlserver://%s;database=%s;user=%s;password=%s;encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;", this.serverSqlServer, this.databaseSqlServer, this.usernameSqlServer, this.passwordSqlServer));

        dataSource​SqlServer.setUsername(this.usernameSqlServer);
        dataSource​SqlServer.setPassword(this.passwordSqlServer);

        this.conexaoSqlServer = new JdbcTemplate(dataSourceSqlServer);

        // MySql
        BasicDataSource dataSourceMySQL = new BasicDataSource();
        dataSourceMySQL.setDriverClassName("com.mysql.cj.jdbc.Driver");
        
        dataSourceMySQL.setUrl(String.format("jdbc:mysql://127.0.0.1:3306/%s", this.databaseMySql));
        
        dataSourceMySQL.setUsername(this.usernameMySql);
        dataSourceMySQL.setPassword(this.passwordMySql);
        
        this.conexaoMySQL = new JdbcTemplate(dataSourceMySQL);
    }
    
    public void inserirRegistro(String comando){
        // Inserir no SQL Server da Azure
        String comandoSqlServer = comando.replaceAll("DATA", "GETDATE() AT TIME ZONE 'UTC' AT TIME ZONE 'Bahia Standard Time'");
        String comandoMySQL = comando.replaceAll("DATA", "NOW()");
        
        try{
            conexaoSqlServer.update(comandoSqlServer);
            System.out.println("Registro inserido no SQL Server da Azure!");
            Utilitarios.wait(1000);
        }
        catch(Exception e){
            System.out.println("Não foi possível inserir no SQL Server da Azure!");
            System.out.println(comandoSqlServer);
            System.out.println(e);
        }
        
        // Inserir no MySql Local
        try{
            conexaoMySQL.update(comandoMySQL);
            System.out.println("Registro inserido no MySQL Local!");
            Utilitarios.wait(1000);
        }
        catch(Exception e){
            System.out.println("Não foi possível inserir no MySQL Local!");
            System.out.println(comandoMySQL);
            System.out.println(e);
        }
    }
    
    public JSONObject consultarRegistro(String comando){
        try{
            List<Map<String, Object>> resultado = conexaoSqlServer.queryForList(comando);
            if(resultado.isEmpty()){
               return null;
            }
            
            return new JSONObject(resultado.get(0));
        }
        catch(Exception e){
            System.out.println("Não foi possível consultar o registro!");
            System.out.println(comando);
            System.out.println(e);
        }
        
        return null;
    }
}
