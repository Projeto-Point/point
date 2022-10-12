var maquinaModel = require("../models/maquinaModel");

function listar(req, res) {
    maquinaModel.listar()
    .then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        }
        else {
            res.status(204).send("Nenhuma máquina encontrada!");
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Houve um erro ao listar as máquinas: ", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}

function listarAlertas(req, res){
    maquinaModel.listarAlertas()
    .then(function(resultado) {
        if(resultado.length > 0){
            res.status(200).json(resultado);
        }
        else{
            res.status(204).send("Nenhum alerta encontrado!");
        }
    })
    .catch(function(erro) {
        console.log(erro);
        res.status(500).json(erro.sqlMessage);
    });
}

module.exports = {
    listar,
    listarAlertas,
}