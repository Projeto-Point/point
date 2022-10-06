/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package banco;

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

    dataSource​.setDriverClassName("org.h2.Driver");

    dataSource​.setUrl("jdbc:h2:file:./banco_teste");

    dataSource​.setUsername("aluno");

    dataSource​.setPassword("sptech");



    this.connection = new JdbcTemplate(dataSource);

  }
  
  
  
  public JdbcTemplate getConnection() {

    return connection;

  }


}
