CREATE DATABASE bd_point;

USE bd_point;

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
    email varchar(45) unique,
    cargo varchar (45) not null default 'Gestor',
    telefone char(11),
    fkGestor int,
    fkEmpresa int
);

create table Maquina (
    idMaquina int primary key auto_increment,
    sistemaOperacional varchar(45) not null,
    nomeMaquina varchar(45),
    tipo VARCHAR(30),
    fkfuncionario int
);

create table Localizacao (
    idLocalizacao int primary key auto_increment,
    acao char(1),
    dataEhora datetime,
    ipAdress varchar(16),
    longitude decimal(7,4),
    latitude decimal(7,4),
    cidade varchar(50),
    pais char(2),
    fkMaquina int
);

create table Componente(
    idComponente int,
    tipo varchar(50),
    fkMaquina int,
    primary key(idComponente, fkMaquina)
);

create table Atributo(
    idAtributo int primary key auto_increment,
    atributo varchar(50),
    valor decimal(6,2),
    unidadeMedida varchar(30),
    fkComponente int,
    fkMaquina INT
);

create table Registro(
    fkMaquina int,
    fkComponente int,
    dataEhora datetime,
    valor decimal(6,2),
    unidadeMedida VARCHAR(5)
);

CREATE VIEW vw_componentes AS
SELECT E.nome AS 'empresa', E.cnpj,
	F.email,
    idMaquina, nomeMaquina, sistemaOperacional,
    C.tipo,
    atributo, valor, unidadeMedida
FROM Empresa E
INNER JOIN Funcionario F ON F.fkEmpresa = idEmpresa
INNER JOIN Maquina ON Maquina.fkFuncionario = idFuncionario
INNER JOIN Componente C ON fkMaquina = idMaquina
INNER JOIN Atributo ON fkComponente = idComponente;

CREATE VIEW vw_registros AS
SELECT  E.nome AS 'empresa', E.cnpj,
		email,
        idMaquina, nomeMaquina, sistemaOperacional,
        C.tipo,
        valor, unidadeMedida, dataEhora
FROM Empresa E
INNER JOIN Funcionario F ON F.fkEmpresa = idEmpresa
INNER JOIN Maquina ON Maquina.fkFuncionario = idFuncionario
INNER JOIN Componente C ON fkMaquina = idMaquina
INNER JOIN Registro ON fkComponente = idComponente;

CREATE VIEW vw_infoMaquina AS
SELECT idMaquina, nomeMaquina, sistemaOperacional, M.tipo AS 'tipoMaquina',
	   C.tipo AS 'tipoComponente',
       atributo, valor, unidadeMedida
FROM Maquina M
INNER JOIN Componente C ON C.fkMaquina = idMaquina
INNER JOIN Atributo ON idComponente = fkComponente;