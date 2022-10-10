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

    dataSource​.setDriverClassName("com.mysql.jdbc.Driver");
    
    // Colocar aqui o caminho do banco e o nome do database -- padrão = localhost:3306
    dataSource​.setUrl("jdbc:mysql://127.0.0.1:3306/bd_point");
    
    // Nome do usuário da conexão 
    dataSource​.setUsername("aluno");
    
    // Senha da conexão 
    dataSource​.setPassword("sptech");

    this.connection = new JdbcTemplate(dataSource);

  }
  
  
  public JdbcTemplate getConnection() {

    return connection;

  }
  

}
