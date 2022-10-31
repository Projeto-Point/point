var express = require("express");
var router = express.Router();

var usuarioController = require("../controllers/usuarioController");

router.get("/", function (req, res) {
    usuarioController.testar(req, res);
});

//Recebendo os dados do html e direcionando para a função cadastrar de usuarioController.js
router.post("/cadastrarEmpresaGerente", function (req, res) {
    usuarioController.cadastrarEmpresaGerente(req, res);
});

router.post("/cadastrarFuncionario", function (req, res) {
    usuarioController.cadastrarFuncionario(req, res);
});

router.post("/alterarFuncionario", function (req, res) {
    usuarioController.alterarFuncionario(req, res);
});

router.post("/autenticar", function (req, res) {
    usuarioController.entrar(req, res);
});

// router.post("/verificarGerente", function (req, res) {
//     usuarioController.verificarGerente(req, res);
// });

router.get("/listarFuncionarios", function(req, res){
    usuarioController.listarFuncionarios(req, res);
});

router.get("/pegarDadosAtuais", function(req, res){
    usuarioController.pegarDadosAtuais(req, res);
});

module.exports = router;