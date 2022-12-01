var database = require("../database/config");

function listarProcessos(idMaquina) {
    instrucaoSql = `SELECT * FROM processos 
    WHERE fkMaquina = 61 order by horario desc;`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}


module.exports = {
    listarProcessos

}