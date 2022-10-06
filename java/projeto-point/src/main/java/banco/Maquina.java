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
public class Maquina {
    
    Looca looca = new Looca();
    
    private Integer id;
    private String SistemaOperacional ;
    private String nomeMaquina;
    private Integer fkFuncionario;

    public Maquina(Integer id, String SistemaOperacional, String nomeMaquina, Integer fkFuncionario) {
        
        this.id = null;
        this.SistemaOperacional = looca.getSistema().getSistemaOperacional();
        this.nomeMaquina = nomeMaquina;
        this.fkFuncionario = null;
 
        
    }
    
    
    
    
    
    
    
}
