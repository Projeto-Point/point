var agdaModel = require("../models/agdaModel");

// Página das máquinas
function pegarMovimentacao(req, res) {
    const periodoInicio = req.query.periodoInicio;
    const periodoFim = req.query.periodoFim;
    const idFuncionario = req.query.idFuncionario;
    const cidade = req.query.cidade;
    agdaModel.pegarMovimentacao(periodoInicio, periodoFim, idFuncionario, cidade)
    .then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        }
        else {
            res.status(204).send("Nenhuma entrada encontrada!");
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao pegar a movimentação: ", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

function pegarCpu(req, res) {
    const periodoInicio = req.query.periodoInicio;
    const periodoFim = req.query.periodoFim;
    const idFuncionario = req.query.idFuncionario;
    const cidade = req.query.cidade;
    agdaModel.pegarCpu(periodoInicio, periodoFim, idFuncionario, cidade)
    .then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        }
        else {
            res.status(204).send("Nenhuma CPU encontrada!");
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao pegar a CPU: ", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

function pegarRam(req, res) {
    const periodoInicio = req.query.periodoInicio;
    const periodoFim = req.query.periodoFim;
    const idFuncionario = req.query.idFuncionario;
    const cidade = req.query.cidade;
    agdaModel.pegarRam(periodoInicio, periodoFim, idFuncionario, cidade)
    .then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        }
        else {
            res.status(204).send("Nenhuma CPU encontrada!");
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao pegar a CPU: ", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

module.exports = {
    pegarMovimentacao,
    pegarCpu,
    pegarRam,
}