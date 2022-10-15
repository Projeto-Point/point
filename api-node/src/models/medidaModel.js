var database = require("../database/config");

function pegarRegistroCPU(idMaquina){
    instrucaoSql = `select M.idMaquina, A.valor FROM Maquina M
    INNER JOIN Componente C ON C.fkMaquina = M.idMaquina
    INNER JOIN Atributo A ON fkComponente = idComponente
    WHERE C.tipo like "CPU" AND M.idMaquina = ${idMaquina} order by idAtributo desc limit 0,10;`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function pegarRegistroDISCO(idMaquina){
    instrucaoSql = `select M.idMaquina, A.valor FROM Maquina M
    INNER JOIN Componente C ON C.fkMaquina = M.idMaquina
    INNER JOIN Atributo A ON fkComponente = idComponente
    WHERE C.tipo like "DISCO" AND M.idMaquina = ${idMaquina} order by idAtributo desc limit 0,10;`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function pegarRegistroRAM(idMaquina){
    instrucaoSql = `select M.idMaquina, A.valor FROM Maquina M
    INNER JOIN Componente C ON C.fkMaquina = M.idMaquina
    INNER JOIN Atributo A ON fkComponente = idComponente
    WHERE C.tipo like "RAM" AND M.idMaquina = ${idMaquina} order by idAtributo desc limit 0,10;`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function pegarRegistroFuncionario(idMaquina){
    instrucaoSql = `SELECT nome, email, cargo, telefone, idMaquina FROM Funcionario, Telefone, maquina 
    where Funcionario.idFuncionario = Telefone.fkFuncionario and Funcionario.idFuncionario = Maquina.fkFuncionario AND Maquina.idMaquina = ${idMaquina};`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}


module.exports = {
    pegarRegistroCPU,
    pegarRegistroDISCO,
    pegarRegistroRAM,
    pegarRegistroFuncionario

}