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
    cargo varchar (45) not null default 'Gestor',
    telefone char(11),
    fkGestor int,
    fkEmpresa int,
    foreign key (fkGestor) references Funcionario (idFuncionario),
    foreign key (fkEmpresa) references Empresa (idEmpresa)
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
    foreign key (fkFuncionario) references Funcionario (idFuncionario),
    fkEmpresa int,
    foreign key (fkEmpresa) references Empresa (idempresa)
);

create table Maquina (
    idMaquina int primary key auto_increment,
    sistemaOperacional varchar(45) not null,
    nomeMaquina varchar(45),
    tipo VARCHAR(30),
    fkfuncionario int,
    foreign key (fkFuncionario) references Funcionario (idFuncionario)
);

CREATE TABLE Alerta (
	idAlerta INT PRIMARY KEY AUTO_INCREMENT,
    dataEhora datetime,
    titulo VARCHAR (100),
    resolucao VARCHAR (30),
    link VARCHAR(100),
    fkMaquina INT, 
    foreign key (fkMaquina) references Maquina(idMaquina)
);

CREATE TABLE Componente (
	idComponente int,
    fkMaquina int,
    tipo VARCHAR(50),
    foreign key (fkMaquina) references Maquina (idMaquina),
    primary key(idComponente, fkMaquina)
);

create table Atributo(
    idAtributo int primary key auto_increment,
    atributo varchar(50),
    valor decimal(6,2),
    unidadeMedida varchar(30),
    fkComponente int,
    fkMaquina INT,
    foreign key (fkComponente) references Componente (idComponente),
    foreign key (fkMaquina) references Maquina (idMaquina)
);

create table Registro(
    fkMaquina int,
    fkComponente int,
    dataEhora datetime,
    valor decimal(6,2),
    unidadeMedida VARCHAR(5)
);

-- Views
CREATE VIEW `vw_componentes` AS
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

CREATE VIEW `vw_registros` AS
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

CREATE VIEW `vw_infoMaquina` AS
SELECT idMaquina, nomeMaquina, sistemaOperacional, M.tipo AS 'tipoMaquina',
	   C.tipo AS 'tipoComponente',
       atributo, valor, unidadeMedida
FROM Maquina M
INNER JOIN Componente C ON C.fkMaquina = idMaquina
INNER JOIN Atributo ON idComponente = fkComponente;

SELECT * FROM vw_infoMaquina;

