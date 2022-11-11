/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package banco;

import javax.sql.DataSource;
import javax.swing.Timer;
import org.apache.commons.dbcp2.BasicDataSource;
import org.springframework.jdbc.core.JdbcTemplate;

/**
 *
 * @author ivanm
 */
public class Database {
    
   
 private JdbcTemplate connection;


    // Criando o construtor para identificar o banco
  public Database() {



    BasicDataSource dataSource = new BasicDataSource();

    dataSource​.setDriverClassName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
    
    // Colocar aqui o caminho do banco e o nome do database -- padrão = localhost:3306
    dataSource​.setUrl("jdbc:sqlserver://bd-point.database.windows.net:1433;database=bd-point;user=adm-point@bd-point;password=1cco#grupo1;encrypt=true;trustServerCertificate=false;hostNameInCertificate=*.database.windows.net;");
    
    // Nome do usuário da conexão 
    dataSource​.setUsername("adm-point@bd-point");
    
    // Senha da conexão 
    dataSource​.setPassword("1cco#grupo1");

    this.connection = new JdbcTemplate(dataSource);

  }
  
  
  public JdbcTemplate getConnection() {

    return connection;

  }
  

}
