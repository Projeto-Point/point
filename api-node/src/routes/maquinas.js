var express = require("express");
var router = express.Router();

var maquinaController = require("../controllers/maquinaController");

router.get("/listar", function (req, res) {
    maquinaController.listar(req, res);
});

router.get("/listarAlertas", function(req, res){
    maquinaController.listarAlertas(req, res);
});

module.exports = router;