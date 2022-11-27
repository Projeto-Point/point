package banco;

import org.springframework.jdbc.core.JdbcTemplate;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.net.URL;


public class Localizacao {
    
    
    Database database = new Database();
    JdbcTemplate connection = database.getConnection();
    
   
       
    public String ip;
    public String city;
    public String region;
    public String country;
    public String loc;
    public String org; 
    public String postal;  
    public String timezone; 
    public String readme;

    
   
    // Inserir no banco
    public void inserirLocalizacao(Localizacao local){
        
        
        
    }
    
    
}
