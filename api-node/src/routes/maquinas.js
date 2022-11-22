var express = require("express");
var router = express.Router();

var maquinaController = require("../controllers/maquinaController");

router.get("/listar", function (req, res) {
    maquinaController.listar(req, res);
});

router.get("/listarAlertas", function(req, res){
    maquinaController.listarAlertas(req, res);
});

router.get("/analiseComponente", function(req, res){
    maquinaController.analiseComponente(req, res);
});

router.get("/pegarTempo", function(req, res){
    maquinaController.pegarTempo(req, res);
});

router.get("/pegarKpis", function(req, res){
    maquinaController.pegarKpis(req, res);
});

router.get("/verificarAtividade", function(req, res){
    maquinaController.verificarAtividade(req, res);
});

module.exports = router;