package banco;

import org.springframework.jdbc.core.JdbcTemplate;

public class Localizacao {
    Database database = new Database();
    JdbcTemplate connection = database.getConnection();
    
    
}
