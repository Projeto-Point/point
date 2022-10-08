var database = require("../database/config");

function buscarUltimasMedidas(idAquario, limite_linhas) {
    instrucaoSql = `select 
                        temperatura, 
                        umidade, 
                        momento,
                        DATE_FORMAT(momento,'%H:%i:%s') as momento_grafico
                    from medida
                    where fk_aquario = ${idAquario}
                    order by id desc limit ${limite_linhas}`;
    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}

function buscarMedidasEmTempoReal(idAquario) {
    instrucaoSql = `select 
                        temperatura, 
                        umidade, DATE_FORMAT(momento,'%H:%i:%s') as momento_grafico, 
                        fk_aquario 
                        from medida where fk_aquario = ${idAquario} 
                    order by id desc limit 1`;

    console.log("Executando a instrução SQL: \n" + instrucaoSql);
    return database.executar(instrucaoSql);
}



function pegarRegistroCPU(){
    instrucaoSql = `SELECT valor FROM vw_registros WHERE tipo = 'CPU' limit 0,10`;
    return database.executar(instrucaoSql);
}

function pegarRegistroDISCO(){
    instrucaoSql = `SELECT valor FROM vw_registros WHERE tipo = 'DISCO' limit 0,10`;
    return database.executar(instrucaoSql);
}

function pegarRegistroRAM(){
    instrucaoSql = `SELECT valor FROM vw_registros WHERE tipo = 'RAM' limit 0,10`;
    return database.executar(instrucaoSql);
}


module.exports = {
    buscarUltimasMedidas,
    buscarMedidasEmTempoReal,
    pegarRegistroCPU,
    pegarRegistroDISCO,
    pegarRegistroRAM

}