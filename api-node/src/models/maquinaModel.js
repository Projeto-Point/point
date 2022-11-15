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

function analiseComponente(tipoComponente, idMaquina, dataInicio, dataFinal){
    instrucaoSql = `SELECT CAST(dataEhora AS DATE) AS 'dataEhora', ROUND(AVG(valor), 2) AS 'media' FROM vw_registros
    WHERE tipo = '${tipoComponente}' AND idMaquina = ${idMaquina} AND CAST(dataEhora AS DATE) BETWEEN '${dataInicio}' AND '${dataFinal}'
    GROUP BY CAST(dataEhora AS DATE)
    ORDER BY dataEhora`;
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
    instrucaoSql = `SELECT TOP 1 dataEhora, acao FROM Localizacao WHERE fkMaquina = ${idMaquina} ORDER BY dataEhora DESC;`
    console.log(instrucaoSql)
    return database.executar(instrucaoSql);
}

module.exports = {
    listar,
    listarAlertas,
    analiseComponente,
    pegarKpis,
    verificarAtividade,
}