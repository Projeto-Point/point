var express = require("express");
var router = express.Router();

var ivanController = require("../controllers/ivanController");


router.get("/getLocalizacao", function (req, res) {
    console.log('IODFJNEWOIFNEIO')
    ivanController.getLocalizacao(req, res);
});


module.exports = router;
