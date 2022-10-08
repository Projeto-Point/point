var database = require("../database/config");

function pegarRegistroCPU(){
    instrucaoSql = `SELECT valor FROM vw_registros WHERE tipo = 'CPU' limit 0,10`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function pegarRegistroDISCO(){
    instrucaoSql = `SELECT valor FROM vw_registros WHERE tipo = 'DISCO' limit 0,1`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function pegarRegistroRAM(){
    instrucaoSql = `SELECT valor FROM vw_registros WHERE tipo = 'RAM' limit 0,10`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}


module.exports = {
    pegarRegistroCPU,
    pegarRegistroDISCO,
    pegarRegistroRAM

}