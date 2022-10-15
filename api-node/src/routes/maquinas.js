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

router.get("/pegarKpis", function(req, res){
    maquinaController.pegarKpis(req, res);
});

module.exports = router;