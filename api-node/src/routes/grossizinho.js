var express = require("express");
var router = express.Router();

var grossizinhoController = require("../controllers/grossizinhoController");

router.get("/pegarRegistroInstancia", function(req, res){ 
    grossizinhoController.pegarRegistroInstancia(req, res);
});

router.get("/horasAtivas", function (req, res) {
    grossizinhoController.horasAtivas(req, res);
});


module.exports = router;