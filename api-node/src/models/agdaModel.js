var database = require("../database/config");

function pegarMovimentacao(periodoInicio, periodoFim, idFuncionario, cidade, idEmpresa){
    if(idFuncionario == 0){
        console.log(cidade);
        instrucaoSql = `SELECT acao, CAST(AVG(CAST(dataEhora AS FLOAT)) AS DATETIME) AS dataEhora FROM Localizacao
        INNER JOIN Maquina ON fkMaquina = idMaquina
        INNER JOIN Funcionario ON fkFuncionario = idFuncionario
        WHERE cidade = '${cidade}' AND CAST(dataEhora AS DATE) BETWEEN '${periodoInicio}' AND '${periodoFim}' AND fkEmpresa = ${idEmpresa}
        GROUP BY acao, CAST(dataEhora AS DATE);`;
        console.log(instrucaoSql)
    }
    else{
        instrucaoSql = `SELECT acao, CAST(AVG(CAST(dataEhora AS FLOAT)) AS DATETIME) AS dataEhora
        FROM Localizacao
        INNER JOIN Maquina ON idMaquina = fkMaquina
        INNER JOIN Funcionario ON idFuncionario = fkFuncionario
        WHERE idFuncionario = ${idFuncionario} AND CAST(dataEhora AS DATE) BETWEEN '${periodoInicio}' AND '${periodoFim}' AND cidade = '${cidade}'
        GROUP BY acao, CAST(dataEhora AS DATE);`;
    }
    return database.executar(instrucaoSql);
}

function pegarCpu(periodoInicio, periodoFim, idFuncionario, cidade, idEmpresa){
    console.log(idFuncionario);
    if(idFuncionario == 0){
        instrucaoSql = `SELECT DATEPART(hour, R.dataEhora) AS 'hora', ROUND(AVG(valor), 2) AS 'valor' FROM vw_registros R
        INNER JOIN Localizacao ON idMaquina = fkMaquina AND cidade = '${cidade}'
        INNER JOIN Funcionario F ON F.idFuncionario = R.idFuncionario
        WHERE tipo = 'CPU' AND CAST(R.dataEhora AS DATE) BETWEEN '${periodoInicio}' AND '${periodoFim}' AND fkEmpresa = ${idEmpresa}
        GROUP BY DATEPART(hour, R.dataEhora)
        ORDER BY DATEPART(hour, R.dataEhora);`;
    }
    else{
        instrucaoSql = `SELECT DATEPART(hour, dataEhora) AS 'hora', ROUND(AVG(valor), 2) AS 'valor' FROM vw_registros
        WHERE idFuncionario = ${idFuncionario} AND tipo = 'CPU' AND CAST(dataEhora AS DATE) BETWEEN '${periodoInicio}' AND '${periodoFim}'
        GROUP BY DATEPART(hour, dataEhora)
        ORDER BY DATEPART(hour, dataEhora);`;
    }
    console.log(instrucaoSql);
    return database.executar(instrucaoSql);
}

function pegarRam(periodoInicio, periodoFim, idFuncionario, cidade, idEmpresa){
    if(idFuncionario == 0){
        instrucaoSql = `SELECT DATEPART(hour, R.dataEhora) AS 'hora', ROUND(AVG(valor), 2) AS 'valor' FROM vw_registros R
        INNER JOIN Localizacao ON idMaquina = fkMaquina AND cidade = '${cidade}'
        INNER JOIN Funcionario F ON F.idFuncionario = R.idFuncionario
        WHERE tipo = 'RAM' AND CAST(R.dataEhora AS DATE) BETWEEN '${periodoInicio}' AND '${periodoFim}' AND fkEmpresa = ${idEmpresa}
        GROUP BY DATEPART(hour, R.dataEhora)
        ORDER BY DATEPART(hour, R.dataEhora);`;
    }
    else{
        instrucaoSql = `SELECT DATEPART(hour, dataEhora) AS 'hora', ROUND(AVG(valor), 2) AS 'valor' FROM vw_registros
        WHERE idFuncionario = ${idFuncionario} AND tipo = 'RAM' AND CAST(dataEhora AS DATE) BETWEEN '${periodoInicio}' AND '${periodoFim}'
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

function mediaHorasAtivas(idFuncionario, dataInicio, dataFinal, cidade, idEmpresa){
    if(idFuncionario != 0){
        instrucaoSql = `SELECT acao,
            CAST(dataEhora AS DATE) AS 'dia',
            CAST(AVG(CAST(dataEhora AS FLOAT)) AS DATETIME) AS 'horario'
        FROM Localizacao
        INNER JOIN Maquina ON fkMaquina = idMaquina
        WHERE fkFuncionario = ${idFuncionario} AND CAST(dataEhora AS DATE) BETWEEN '${dataInicio}' AND '${dataFinal}'
        GROUP BY acao, CAST(dataEhora AS DATE);`;
    }
    else{
        instrucaoSql = `SELECT acao,
            CAST(dataEhora AS DATE) AS 'dia',
            CAST(AVG(CAST(dataEhora AS FLOAT)) AS DATETIME) AS 'horario'
        FROM Localizacao
        INNER JOIN Maquina ON fkMaquina = idMaquina
        INNER JOIN Funcionario ON fkFuncionario = idFuncionario
        WHERE cidade = '${cidade}' AND CAST(dataEhora AS DATE) BETWEEN '${dataInicio}' AND '${dataFinal}' AND fkEmpresa = ${idEmpresa}
        GROUP BY acao, CAST(dataEhora AS DATE);`;
    }
    console.log(instrucaoSql);
    return database.executar(instrucaoSql);
}

function pegarCidades(idEmpresa){
    instrucaoSql = `SELECT DISTINCT cidade, pais FROM Localizacao 
    INNER JOIN Maquina ON fkMaquina = idMaquina
    INNER JOIN Funcionario ON fkFuncionario = idFuncionario
    WHERE fkEmpresa = ${idEmpresa};`;
    console.log(instrucaoSql);
    return database.executar(instrucaoSql);
}

module.exports = {
    pegarMovimentacao,
    pegarCpu,
    pegarRam,
    pegarFuncionarios,
    mediaHorasAtivas,
    pegarCidades,
}