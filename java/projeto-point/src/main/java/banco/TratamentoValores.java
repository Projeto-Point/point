/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package banco;

/**
 *
 * @author ivanm
 */
public class TratamentoValores {
    
    
    public Double converterBytesParaGiga(Long valorEmBytes){
        
        
        double valorEmBytesDouble = (double)valorEmBytes;
        
        valorEmBytesDouble *= 0.000_000_000_931_322_574_615_48;
         
        
        return valorEmBytesDouble;
        
    }
    
    public Double converterBytesParaGiga(Double valorEmBytes){
        
        
        valorEmBytes *= 0.000_000_000_931_322_574_615_48;
         
        
        return valorEmBytes;
    }
    
    public Double limitarDuasCasasDecimais(Double valorDouble){
        return (double) Math.round(valorDouble * 100) / 100;
    }
}
