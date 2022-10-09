-- Script SQL Server
DROP DATABASE bd_point;
create database bd_point;

use bd_point;

create table Empresa (
	idEmpresa int primary key auto_increment,
    nome varchar(45) not null,
    cnpj char(14) unique not null,
    plano int,
    descEmpresa varchar(45),
    constraint tipo_plano check (plano >= 1 and plano <= 3)
);

create table Funcionario (
	idFuncionario int primary key auto_increment,
    nome varchar(45) not null,
    cpf char(11) unique not null,
    senha varchar(45) not null,
    email varchar(45) unique not null,
    fkGestor int,
    fkEmpresa int,
    foreign key (fkGestor) references funcionario (idFuncionario),
    foreign key (fkEmpresa) references empresa (idEmpresa)
);

create table Telefone (
	idTelefone int primary key auto_increment,
    telefone char(11),
    fkFuncionario int,
    foreign key (fkFuncionario) references funcionario (idFuncionario)
);

create table Endereco (
	idEndereco int primary key auto_increment,
    rua varchar(45),
    num int,
    bairro varchar(45),
    cidade VARCHAR(45) not null,
    estado char(2) not null,
    pais varchar(45) not null,
    fkFuncionario int,
    foreign key (fkFuncionario) references funcionario (idFuncionario),
    fkEmpresa int,
    foreign key (fkEmpresa) references empresa (idempresa)
);

create table Maquina (
    idMaquina int primary key auto_increment,
    sistemaOperacional varchar(45) not null,
    nomeMaquina varchar(45),
    fkfuncionario int,
    foreign key (fkFuncionario) references funcionario (idFuncionario)
);

create table Componente(
    idComponente int primary key auto_increment,
    tipo varchar(50),
    fkMaquina int,
    foreign key (fkMaquina) references maquina (idMaquina)
);

create table Atributo(
    idAtributo int primary key auto_increment,
    atributo varchar(50),
    valor decimal(6,2),
    unidadeMedida varchar(30),
    fkComponente int,
    foreign key (fkComponente) references componente (idComponente)
);

create table Registro(
    idRegistro int primary key auto_increment,
    valor decimal(6,2),
    unidadeMedida varchar(5),
    dataEhora datetime,
    fkComponente int,
    foreign key (fkComponente) references componente (idComponente)
);

-- Views
CREATE VIEW `vw_componentes` AS
SELECT E.nome AS 'empresa', E.cnpj,
	F.email,
    Endereco.cidade, Endereco.estado, Endereco.pais,
    idMaquina, nomeMaquina, sistemaOperacional,
    tipo,
    atributo, valor, unidadeMedida
FROM Empresa E

INNER JOIN Endereco ON Endereco.fkEmpresa = idEmpresa
INNER JOIN Funcionario F ON F.fkEmpresa = idEmpresa AND Endereco.fkFuncionario = idFuncionario
INNER JOIN Maquina ON Maquina.fkFuncionario = idFuncionario
INNER JOIN Componente ON fkMaquina = idMaquina
INNER JOIN Atributo ON fkComponente = idComponente;

CREATE VIEW `vw_registros` AS
SELECT  E.nome AS 'empresa', E.cnpj,
		email,
        Endereco.cidade, Endereco.estado, Endereco.pais,
        idMaquina, nomeMaquina, sistemaOperacional,
        tipo,
        valor, unidadeMedida, dataEhora
FROM Empresa E
INNER JOIN Endereco ON Endereco.fkEmpresa = idEmpresa
INNER JOIN Funcionario F ON F.fkEmpresa = idEmpresa AND Endereco.fkFuncionario = idFuncionario
INNER JOIN Maquina ON Maquina.fkFuncionario = idFuncionario
INNER JOIN Componente ON fkMaquina = idMaquina
INNER JOIN Registro ON fkComponente = idComponente;

-- Dados Fake para teste -- Dados Funcionario
INSERT INTO Empresa VALUES (null, "Google", "21625996000109", 1, "Tecnologia");
INSERT INTO Funcionario VALUES (null, "Ir","3700421409d","123", "iva@.com", null, 1);
INSERT INTO Telefone VALUES(null, "11992015034", 1);
INSERT INTO Endereco VALUES(null, "Rua armando", 131, "Jardim Holanda", "São Paulo", "SP","Brasil", 1,1);
-- Select para verificar se bate
SELECT f.nome as "Nome Funcionario", t.telefone as "Telefone Funcionario", ed.rua as "Rua Funcionario", ep.nome as "Nome Empresa"

FROM Funcionario as f
INNER JOIN Telefone as t ON t.fkFuncionario = f.idFuncionario
INNER JOIN Empresa as ep ON f.fkEmpresa = ep.idEmpresa
INNER JOIN Endereco as ed ON ed.fkFuncionario = f.idFuncionario
AND ed.fkEmpresa = ep.idEmpresa;


-- Dados Maquina Fake 

SELECT * FROM Funcionario; 
SELECT * FROM Maquina;
