var database = require("../database/config");

function pegarMovimentacao(periodoInicio, periodoFim, idFuncionario, cidade){
    if(idFuncionario == 0){
        console.log(cidade);
        instrucaoSql = `SELECT acao, CAST(AVG(CAST(dataEhora AS FLOAT)) AS DATETIME) AS dataEhora FROM Localizacao
        WHERE cidade = '${cidade}' AND CAST(dataEhora AS DATE) BETWEEN '${periodoInicio}' AND '${periodoFim}'
        GROUP BY acao, CAST(dataEhora AS DATE);`;
        console.log(instrucaoSql)
    }
    else{
        instrucaoSql = `SELECT acao, CAST(AVG(CAST(dataEhora AS FLOAT)) AS DATETIME) AS dataEhora
        FROM Localizacao
        INNER JOIN Maquina ON idMaquina = fkMaquina
        INNER JOIN Funcionario ON idFuncionario = fkFuncionario
        WHERE idFuncionario = ${idFuncionario} AND CAST(dataEhora AS DATE) BETWEEN '${periodoInicio}' AND '${periodoFim}'
        GROUP BY acao, CAST(dataEhora AS DATE);`;
    }
    return database.executar(instrucaoSql);
}

function pegarCpu(periodoInicio, periodoFim, idFuncionario, cidade){
    if(idFuncionario == 0){
        instrucaoSql = `SELECT DATEPART(hour, R.dataEhora) AS 'hora', ROUND(AVG(valor), 2) AS 'valor' FROM vw_registros R
        INNER JOIN Localizacao ON fkMaquina = fkMaquina AND cidade = '${cidade}'
        WHERE tipo = 'CPU' AND R.dataEhora BETWEEN '${periodoInicio}' AND '${periodoFim}'
        GROUP BY DATEPART(hour, R.dataEhora)
        ORDER BY DATEPART(hour, R.dataEhora);`;
    }
    else{
        instrucaoSql = `SELECT DATEPART(hour, dataEhora) AS 'hora', ROUND(AVG(valor), 2) AS 'valor' FROM vw_registros
        WHERE idFuncionario = ${idFuncionario} AND tipo = 'CPU' AND dataEhora BETWEEN '${periodoInicio}' AND '${periodoFim}'
        GROUP BY DATEPART(hour, dataEhora)
        ORDER BY DATEPART(hour, dataEhora);`;
    }
    console.log(instrucaoSql);
    return database.executar(instrucaoSql);
}

function pegarRam(periodoInicio, periodoFim, idFuncionario, cidade){
    if(idFuncionario == 0){
        instrucaoSql = `SELECT DATEPART(hour, R.dataEhora) AS 'hora', ROUND(AVG(valor), 2) AS 'valor' FROM vw_registros R
        INNER JOIN Localizacao ON fkMaquina = fkMaquina AND cidade = '${cidade}'
        WHERE tipo = 'RAM' AND R.dataEhora BETWEEN '${periodoInicio}' AND '${periodoFim}'
        GROUP BY DATEPART(hour, R.dataEhora)
        ORDER BY DATEPART(hour, R.dataEhora);`;
    }
    else{
        instrucaoSql = `SELECT DATEPART(hour, dataEhora) AS 'hora', ROUND(AVG(valor), 2) AS 'valor' FROM vw_registros
        WHERE idFuncionario = ${idFuncionario} AND tipo = 'RAM' AND dataEhora BETWEEN '${periodoInicio}' AND '${periodoFim}'
        GROUP BY DATEPART(hour, dataEhora)
        ORDER BY DATEPART(hour, dataEhora);`;
    }
    console.log(instrucaoSql);
    return database.executar(instrucaoSql);
}

function pegarFuncionarios(idEmpresa, cidade){
    instrucaoSql = `SELECT DISTINCT nome, idFuncionario FROM Funcionario
    INNER JOIN Maquina ON idFuncionario = fkFuncionario
    INNER JOIN Localizacao ON idMaquina = fkMaquina
    WHERE fkEmpresa = ${idEmpresa} AND cidade = '${cidade}';`;
    console.log(instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    pegarMovimentacao,
    pegarCpu,
    pegarRam,
    pegarFuncionarios,
}