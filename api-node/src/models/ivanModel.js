var database = require("../database/config");

function getLocalizacao(idEmpresa, filtro){   
    
        if(filtro == 'geral'){
            comando = `SELECT longitude, latitude, cidade, pais FROM [dbo].[Localizacao] L
            INNER JOIN Maquina M ON M.idMaquina = L.fkMaquina
            INNER JOIN [dbo].[Funcionario] F on M.fkFuncionario = F.idFuncionario
            INNER JOIN [dbo].[Empresa] E on F.fkEmpresa = E.idEmpresa
            WHERE idEmpresa = ${idEmpresa};`;
        }else if(filtro == 'servidor'){
            comando = `SELECT longitude, latitude, cidade, pais FROM [dbo].[Localizacao] L
            INNER JOIN Maquina M ON M.idMaquina = L.fkMaquina
            INNER JOIN [dbo].[Funcionario] F on M.fkFuncionario = F.idFuncionario
            INNER JOIN [dbo].[Empresa] E on F.fkEmpresa = E.idEmpresa
            WHERE idEmpresa = ${idEmpresa} and M.tipo like 'Servidor';`;
        }else if(filtro == 'desktop'){
            comando = `SELECT longitude, latitude, cidade, pais FROM [dbo].[Localizacao] L
            INNER JOIN Maquina M ON M.idMaquina = L.fkMaquina
            INNER JOIN [dbo].[Funcionario] F on M.fkFuncionario = F.idFuncionario
            INNER JOIN [dbo].[Empresa] E on F.fkEmpresa = E.idEmpresa
            WHERE idEmpresa = ${idEmpresa} and M.tipo like 'Desktop';`;
        }else{
            comando = ` SELECT longitude, latitude, cidade, pais FROM [dbo].[Localizacao] L
            INNER JOIN Maquina M ON M.idMaquina = L.fkMaquina
            INNER JOIN [dbo].[Funcionario] F on M.fkFuncionario = F.idFuncionario
            INNER JOIN [dbo].[Empresa] E on F.fkEmpresa = E.idEmpresa
            WHERE idEmpresa = ${idEmpresa} AND L.cidade like '${filtro}';`;
        }
        return database.executar(comando);
}

function getCidades(idEmpresa){

    comando = `SELECT DISTINCT(cidade), pais FROM [dbo].[Localizacao] L
    INNER JOIN [dbo].[Maquina] M on M.idMaquina = L.fkMaquina
    INNER JOIN [dbo].[Funcionario] F on F.idFuncionario = M.fkFuncionario
    INNER JOIN [dbo].[Empresa] E on F.fkEmpresa = E.idEmpresa
    WHERE E.idEmpresa = ${idEmpresa};`;
    return database.executar(comando)
}


module.exports = {
    getLocalizacao,
    getCidades
}