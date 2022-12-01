var ivanModel = require("../models/ivanModel");


function getLocalizacao(req, res) {

    const idEmpresa = req.query.idEmpresa;
    ivanModel.getLocalizacao(idEmpresa)
    .then(function (resultado) {
        if (resultado.length > 0) {
            res.status(200).json(resultado);
        }
        else {
            res.status(204).send("Nenhuma entrada encontrada!");
        }
    }).catch(function (erro) {
        console.log(erro);
        console.log("Erro no SQL: ", erro.sqlMessage);
        res.status(500).json(erro.sqlMessage);
    });
}



module.exports = {
    getLocalizacao

}