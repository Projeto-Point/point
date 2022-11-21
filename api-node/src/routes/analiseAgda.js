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

module.exports = router;