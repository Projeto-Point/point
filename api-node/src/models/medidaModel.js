var database = require("../database/config");

function pegarRegistroCPU(idMaquina){
    instrucaoSql = `SELECT valor FROM vw_registros 
    WHERE tipo like "CPU" AND idMaquina = ${idMaquina} order by dataEhora desc limit 0,10;`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function pegarRegistroDISCO(idMaquina){
    instrucaoSql = `SELECT valor FROM vw_registros 
    WHERE tipo like "DISCO" AND idMaquina = ${idMaquina} order by dataEhora desc limit 0,1;`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function pegarRegistroRAM(idMaquina){
    instrucaoSql = `SELECT valor FROM vw_registros 
    WHERE tipo like "RAM" AND idMaquina = ${idMaquina} order by dataEhora desc limit 0,10;`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function pegarRegistroFuncionario(idMaquina){
    instrucaoSql = `SELECT nome, email, cargo, telefone, idMaquina FROM Funcionario, Maquina 
    where Funcionario.idFuncionario = Maquina.fkFuncionario AND Maquina.idMaquina = ${idMaquina};`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function pegarRegistroMaquina(idMaquina){
    instrucaoSql = `SELECT * FROM vw_infoMaquina WHERE idMaquina = ${idMaquina}`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    pegarRegistroCPU,
    pegarRegistroDISCO,
    pegarRegistroRAM,
    pegarRegistroFuncionario,
    pegarRegistroMaquina,
}