var medidaModel = require("../models/medidaModel");

function buscarUltimasMedidas(req, res) {

    const limite_linhas = 7;

    var idAquario = req.params.idAquario;

    console.log(`Recuperando as ultimas ${limite_linhas} medidas`);

    medidaModel.buscarUltimasMedidas(idAquario, limite_linhas).then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar as ultimas medidas.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}


function buscarMedidasEmTempoReal(req, res) {

    var idAquario = req.params.idAquario;

    console.log(`Recuperando medidas em tempo real`);

    medidaModel.buscarMedidasEmTempoReal(idAquario).then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        } else {
            res.status(204).send("Nenhum resultado encontrado!")
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao buscar as ultimas medidas.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}


function pegarRegistroCPU(req, res){
    var idMaquina = req.query.idMaquina;
    medidaModel.pegarRegistroCPU(idMaquina)
    .then(function (resposta) {
        res.status(200).json(resposta);
    })
    .catch(function(erro){
        console.log(erro);
        console.log("Houve um erro ao buscar os registroCPUs.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });

}

function pegarRegistroDISCO(req, res){
    var idMaquina = req.query.idMaquina;
    medidaModel.pegarRegistroDISCO(idMaquina)
    .then(function (resposta) {
        res.status(200).json(resposta);
    })
    .catch(function(erro){
        console.log(erro);
        console.log("Houve um erro ao buscar os registroDISCO.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });

}

function pegarRegistroRAM(req, res){
    var idMaquina = req.query.idMaquina;
    medidaModel.pegarRegistroRAM(idMaquina)
    .then(function (resposta) {
        res.status(200).json(resposta);
    })
    .catch(function(erro){
        console.log(erro);
        console.log("Houve um erro ao buscar os registroRAM.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });

}

function pegarRegistroFuncionario(req, res){
    var idMaquina = req.query.idMaquina;
    medidaModel.pegarRegistroFuncionario(idMaquina)
    .then(function (resposta) {
        res.status(200).json(resposta);
    })
    .catch(function(erro){
        console.log(erro);
        console.log("Houve um erro ao buscar os registroINFO.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

function pegarRegistroMaquina(req, res){
    var idMaquina = req.query.idMaquina;
    medidaModel.pegarRegistroMaquina(idMaquina)
    .then(function (resposta) {
        res.status(200).json(resposta);
    })
    .catch(function(erro){
        console.log(erro);
        console.log("Houve um erro ao buscar os registros da máquina.", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}



module.exports = {
    buscarUltimasMedidas,
    buscarMedidasEmTempoReal,
    pegarRegistroCPU,
    pegarRegistroDISCO,
    pegarRegistroRAM,
    pegarRegistroFuncionario,
    pegarRegistroMaquina,
}