var express = require("express");
var router = express.Router();

var grossizinhoController = require("../controllers/grossizinhoController");

router.get("/horasAtivas", function (req, res) {
    grossizinhoController.horasAtivas(req, res);
});


module.exports = router;