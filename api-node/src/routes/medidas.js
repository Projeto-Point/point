var express = require("express");
var router = express.Router();

var medidaController = require("../controllers/medidaController");

router.get("/ultimas/:idAquario", function (req, res) {
    medidaController.buscarUltimasMedidas(req, res);
});

router.get("/tempo-real/:idAquario", function (req, res) {
    medidaController.buscarMedidasEmTempoReal(req, res);
});


router.get("/pegarRegistroCPU", function(req, res){ 
    medidaController.pegarRegistroCPU(req, res);
});

router.get("/pegarRegistroDISCO", function(req, res){ 
    medidaController.pegarRegistroDISCO(req, res);
});

router.get("/pegarRegistroRAM", function(req, res){ 
    medidaController.pegarRegistroRAM(req, res);
});


module.exports = router;