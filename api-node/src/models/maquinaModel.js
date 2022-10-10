var database = require("../database/config");

function listar(){
    instrucaoSql = `SELECT nomeMaquina, sistemaOperacional, nome FROM maquina INNER JOIN funcionario ON fkFuncionario = idFuncionario`;
    return database.executar(instrucaoSql);
}

module.exports = {
    listar,
}