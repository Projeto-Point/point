var database = require("../database/config");


function horasAtivas(idMaquina) {
        instrucaoSql = `SELECT acao,
        CAST(dataEhora AS DATE) AS 'dia',
        CAST(AVG(CAST(dataEhora AS FLOAT)) AS DATETIME) AS 'horario'
        FROM Localizacao
         INNER JOIN Maquina ON fkMaquina = idMaquina
        WHERE idMaquina = ${idMaquina}
        GROUP BY acao, CAST(dataEhora AS DATE)`;
    console.log(instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    horasAtivas

}