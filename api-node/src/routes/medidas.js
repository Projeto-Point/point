var express = require("express");
var router = express.Router();

var medidaController = require("../controllers/medidaController");

router.get("/pegarRegistroCPU", function(req, res){ 
    medidaController.pegarRegistroCPU(req, res);
});

router.get("/pegarRegistroDISCO", function(req, res){ 
    medidaController.pegarRegistroDISCO(req, res);
});

router.get("/pegarRegistroRAM", function(req, res){ 
    medidaController.pegarRegistroRAM(req, res);
});

router.get("/pegarRegistroFuncionario", function(req, res){ 
    medidaController.pegarRegistroFuncionario(req, res);
});

router.get("/pegarRegistroMaquina", function(req, res){ 
    medidaController.pegarRegistroMaquina(req, res);
});

module.exports = router;