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

    
   
    
    public String[] getLocation(Localizacao local){
        
        String locLat = local.loc;
        
        String[] geoLocation = locLat.split(",");
     
        return geoLocation;
                
        }
       
    
    // Inserir no banco
    public void inserirLocalizacaoEntrada(Localizacao local){
        
       
        
         connection.update("INSERT INTO Localizacao (acao, dataEhora, ipAdress, longitude, latitude, cidade, pais, fkMaquina) VALUES ('E',GETDATE(), ?, ?, ?, ?, ?, ?)",
                 
                 local.ip,
                 getLocation(local)[0],
                 getLocation(local)[1],
                 local.city,
                 local.country,
                 1
      
                );
         
    }
    
}
