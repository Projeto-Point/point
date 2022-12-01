//process.env.AMBIENTE_PROCESSO = "desenvolvimento";
process.env.AMBIENTE_PROCESSO = "producao";

var express = require("express");
var cors = require("cors");
var path = require("path");
var PORTA = 3333;

var app = express();

var indexRouter = require("./src/routes/index");
var usuarioRouter = require("./src/routes/usuarios");
var medidasRouter = require("./src/routes/medidas");
var maquinasRouter = require("./src/routes/maquinas");
var agdaRouter = require("./src/routes/analiseAgda");
var mapaIvan = require("./src/routes/mapaIvan");
var grossizinhoRouter = require("./src/routes/grossizinho");
<<<<<<< HEAD
// var guilhermeRouter = require("./src/routes/guilherme");
=======
>>>>>>> 6fea59db1aee5fc31e29558a8903c70c94fb1488
var gabrielRouter = require("./src/routes/gabriel");

app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(express.static(path.join(__dirname, "public")));

app.use(cors());

app.use("/", indexRouter);
app.use("/usuarios", usuarioRouter);
app.use("/medidas", medidasRouter);
app.use("/maquinas", maquinasRouter);
app.use("/analiseAgda", agdaRouter);
app.use("/mapaIvan", mapaIvan);
app.use("/grossizinho", grossizinhoRouter)
<<<<<<< HEAD
// app.use("/guilherme", guilhermeRouter)
=======
>>>>>>> 6fea59db1aee5fc31e29558a8903c70c94fb1488
app.use("/gabriel", gabrielRouter)

app.listen(PORTA, function () {
    console.log(`Servidor do seu site já está rodando! Acesse o caminho a seguir para visualizar: http://localhost:${PORTA} \n
    Você está rodando sua aplicação em Ambiente de ${process.env.AMBIENTE_PROCESSO} \n
    \t\tSe "desenvolvimento", você está se conectando ao banco LOCAL (MySQL Workbench). \n
    \t\tSe "producao", você está se conectando ao banco REMOTO (SQL Server em nuvem Azure) \n
    \t\t\t\tPara alterar o ambiente, comente ou descomente as linhas 1 ou 2 no arquivo 'app.js'`);
});
