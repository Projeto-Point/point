var express = require("express");
var router = express.Router();

var agdaController = require("../controllers/agdaController");

router.get("/pegarMovimentacao", function (req, res) {
    agdaController.pegarMovimentacao(req, res);
});

router.get("/pegarCpu", function (req, res) {
    agdaController.pegarCpu(req, res);
});

router.get("/pegarRam", function (req, res) {
    agdaController.pegarRam(req, res);
});

router.get("/pegarFuncionarios", function(req, res) {
    agdaController.pegarFuncionarios(req, res);
});

router.get("/mediaHorasAtivas", function(req, res) {
    agdaController.mediaHorasAtivas(req, res);
});

module.exports = router;