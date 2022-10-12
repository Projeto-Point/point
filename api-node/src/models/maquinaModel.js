var database = require("../database/config");

function listar(){
    instrucaoSql = `SELECT idMaquina, nomeMaquina, nome FROM maquina INNER JOIN funcionario ON fkFuncionario = idFuncionario`;
    return database.executar(instrucaoSql);
}

module.exports = {
    listar,
}