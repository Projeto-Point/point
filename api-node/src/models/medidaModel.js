var database = require("../database/config");

function pegarRegistroCPU(){
    instrucaoSql = `select valor from (
        SELECT valor, dataEhora FROM vw_registros WHERE tipo = 'CPU' order by dataEhora desc limit 0,10) AS sub 
        order by dataEhora asc;`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function pegarRegistroDISCO(){
    instrucaoSql = `select valor from (
        SELECT valor, dataEhora FROM vw_registros WHERE tipo = 'DISCO' order by dataEhora desc limit 0,1) AS sub 
        order by dataEhora asc;`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function pegarRegistroRAM(){
    instrucaoSql = `select valor from (
        SELECT valor, dataEhora FROM vw_registros WHERE tipo = 'RAM' order by dataEhora desc limit 0,10) AS sub 
        order by dataEhora asc;`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function pegarRegistroFuncionario(){
    instrucaoSql = `SELECT nome, email, cargo, telefone FROM Funcionario, Telefone where idFuncionario = fkFuncionario;`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}


module.exports = {
    pegarRegistroCPU,
    pegarRegistroDISCO,
    pegarRegistroRAM,
    pegarRegistroFuncionario

}