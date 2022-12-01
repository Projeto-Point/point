var database = require("../database/config");


function getLocalizacao(idEmpresa){    
        comando = `SELECT longitude, latitude, cidade, pais FROM [dbo].[Localizacao] L
        INNER JOIN Maquina M ON M.idMaquina = L.fkMaquina
        INNER JOIN [dbo].[Funcionario] F on M.fkFuncionario = F.idFuncionario
        INNER JOIN [dbo].[Empresa] E on F.fkEmpresa = E.idEmpresa
        WHERE idEmpresa = ${idEmpresa};`;
        console.log(comando)
        return database.executar(comando);
}


module.exports = {
    getLocalizacao
}