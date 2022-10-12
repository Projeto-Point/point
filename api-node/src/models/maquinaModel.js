var database = require("../database/config");

function listar(){
    instrucaoSql = `SELECT idMaquina, nomeMaquina, nome FROM maquina INNER JOIN Funcionario ON fkFuncionario = idFuncionario`;
    return database.executar(instrucaoSql);
}

function listarAlertas(){
}

module.exports = {
    listar,
}