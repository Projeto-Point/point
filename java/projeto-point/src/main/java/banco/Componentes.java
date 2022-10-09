/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package banco;

import com.github.britooo.looca.api.core.Looca;

/**
 *
 * @author ivanm
 */
public class Componentes {

    Looca looca = new Looca();
    
    
    public Double converterBytesParaGiga(Long valorEmBytes){
        
        
        double valorEmBytesDouble = (double)valorEmBytes;
        
        valorEmBytesDouble *= 0.000_000_000_931_322_574_615_48;
         
        
        return valorEmBytesDouble;
        
    }
    
    public Double converterBytesParaGiga(Double valorEmBytes){
        
        
        valorEmBytes *= 0.000_000_000_931_322_574_615_48;
         
        
        return valorEmBytes;
    }
    
    
    public void listarComponentes(){
        
        
        
    }
    
}
