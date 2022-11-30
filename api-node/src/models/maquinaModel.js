var database = require("../database/config");

function listar(idEmpresa, ordenarPor){
    let instrucaoSql;

    if(ordenarPor == "alerta"){
        instrucaoSql = `SELECT idMaquina, nomeMaquina, Funcionario.nome, tipo FROM Maquina INNER JOIN Funcionario ON fkFuncionario = idFuncionario INNER JOIN Empresa on idEmpresa = [dbo].[Funcionario].fkEmpresa WHERE idEmpresa = ${idEmpresa};`;
    }
    else if(ordenarPor == "maquina"){
        instrucaoSql = `SELECT idMaquina, nomeMaquina, Funcionario.nome, tipo FROM Maquina INNER JOIN Funcionario ON fkFuncionario = idFuncionario INNER JOIN Empresa on idEmpresa = [dbo].[Funcionario].fkEmpresa WHERE idEmpresa = ${idEmpresa} ORDER BY nomeMaquina;`;
    }
    else if(ordenarPor == "funcionario"){
        instrucaoSql = `SELECT idMaquina, nomeMaquina, Funcionario.nome, tipo FROM Maquina INNER JOIN Funcionario ON fkFuncionario = idFuncionario INNER JOIN Empresa on idEmpresa = [dbo].[Funcionario].fkEmpresa WHERE idEmpresa = ${idEmpresa} ORDER BY Funcionario.nome;`;
    }
    return database.executar(instrucaoSql);
}

function listarAlertas(){
    instrucaoSql = `SELECT * FROM vw_alertas`;
    return database.executar(instrucaoSql);
}

function analiseComponente(tipoComponente, idMaquina, dataInicio, dataFinal, tipoVisualizacao = "dia"){
    if(tipoVisualizacao == "dia"){
        instrucaoSql = `SELECT CAST(dataEhora AS DATE) AS 'dataEhora', ROUND(AVG(valor), 2) AS 'media' FROM vw_registros
        WHERE tipo = '${tipoComponente}' AND idMaquina = ${idMaquina} AND CAST(dataEhora AS DATE) BETWEEN '${dataInicio}' AND '${dataFinal}'
        GROUP BY CAST(dataEhora AS DATE)
        ORDER BY dataEhora`;
    }
    else{
        instrucaoSql = `SELECT DATEPART(MONTH, dataEhora) AS 'dataEhora', ROUND(AVG(valor), 2) AS 'media' FROM vw_registros
        WHERE tipo = '${tipoComponente}' AND idMaquina = ${idMaquina} AND CAST(dataEhora AS DATE) BETWEEN '${dataInicio}' AND '${dataFinal}'
        GROUP BY DATEPART(MONTH, dataEhora)
        ORDER BY dataEhora`;
    }
    console.log(instrucaoSql);
    return database.executar(instrucaoSql);
}

function pegarTempo(fkMaquina, dataInicio, dataFinal){
    instrucaoSql = `SELECT acao,
        CAST(dataEhora AS DATE) AS 'dia',
        CAST(AVG(CAST(dataEhora AS FLOAT)) AS DATETIME) AS 'horario'
    FROM Localizacao
    WHERE fkMaquina = ${fkMaquina} AND CAST(dataEhora AS DATE) BETWEEN '${dataInicio}' AND '${dataFinal}'
    GROUP BY acao, CAST(dataEhora AS DATE);`;
    console.log(instrucaoSql);
    return database.executar(instrucaoSql);
}

function pegarKpis(idMaquina, dataInicio, dataFinal){
    instrucaoSql = `SELECT COUNT(*) / 3 AS 'qtdMinutos',
        (SELECT ROUND(AVG(valor), 2) FROM vw_registros WHERE tipo = 'CPU' AND idMaquina = ${idMaquina} AND CAST(dataEhora AS DATE) BETWEEN '${dataInicio}' AND '${dataFinal}') AS 'mediaProcessador',
        (SELECT ROUND(AVG(valor), 2) FROM vw_registros WHERE tipo = 'RAM' AND idMaquina = ${idMaquina} AND CAST(dataEhora AS DATE) BETWEEN '${dataInicio}' AND '${dataFinal}') AS 'mediaRAM'
    FROM vw_registros WHERE idMaquina = ${idMaquina} AND CAST(dataEhora AS DATE) BETWEEN '${dataInicio}' AND '${dataFinal}';`;
    console.log(instrucaoSql)
    return database.executar(instrucaoSql);
}

function verificarAtividade(idMaquina){
    instrucaoSql = `SELECT TOP 1 dataEhora, acao FROM Localizacao WHERE fkMaquina = ${idMaquina} ORDER BY dataEhora DESC;`;
    console.log(instrucaoSql)
    return database.executar(instrucaoSql);
}

function pegarKpisRede(idMaquina, dataInicio, dataFinal){
    instrucaoSql = `SELECT COUNT(*) / 3 AS 'qtdMinutos',
    (SELECT ROUND(AVG(bytesRecebidos), 2) FROM vw_rede WHERE idMaquina = ${idMaquina} AND CAST(dataEhora AS DATE) BETWEEN '${dataInicio}' AND '${dataFinal}') AS 'mediaDownload',
    (SELECT ROUND(AVG(bytesEnviados), 2) FROM vw_rede WHERE idMaquina = ${idMaquina} AND CAST(dataEhora AS DATE) BETWEEN '${dataInicio}' AND '${dataFinal}') AS 'mediaUpload'
    FROM vw_rede WHERE idMaquina = ${idMaquina} AND CAST(dataEhora AS DATE) BETWEEN '${dataInicio}' AND '${dataFinal}';`;
    console.log(instrucaoSql)
    return database.executar(instrucaoSql);
}

module.exports = {
    listar,
    listarAlertas,
    analiseComponente,
    pegarTempo,
    pegarKpis,
    verificarAtividade,
    pegarKpisRede
}