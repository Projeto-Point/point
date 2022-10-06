/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package banco;

/**
 *
 * @author ivanm
 */
public class Funcionario {
    
    private Integer id;
    private String nome;
    private String cpf;
    private String senha;
    private String email;
    private Integer fkGestor;
    private Integer fkEmpresa;

    public Funcionario(Integer id, String nome, String cpf, String senha, String email, Integer fkGestor, Integer fkEmpresa) {
        
        if(isFuncionarioValido(cpf, email)){
            
        this.id = id;
        this.nome = nome;
        this.cpf = cpf;
        this.senha = senha;
        this.email = email;
        this.fkGestor = fkGestor;
        this.fkEmpresa = fkEmpresa;
            
        }
          
    }
    
    
    public Boolean isFuncionarioValido(String cpf, String email){
    
        return cpf.length() == 14 && email.indexOf("@") > 0;
        
    }
    
    
    
    
    
    
    
}
