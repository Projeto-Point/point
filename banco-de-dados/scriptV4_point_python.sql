-- Script SQL Server
create database bd_point_python;

use bd_point_python;

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
    cargo varchar (45) not null default 'gestor',
    telefone char(11),
    fkGestor int,
    fkEmpresa int,
    foreign key (fkGestor) references funcionario (idFuncionario),
    foreign key (fkEmpresa) references empresa (idEmpresa)
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
    tipo VARCHAR(30),
    fkfuncionario int,
    foreign key (fkFuncionario) references funcionario (idFuncionario)
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

INSERT INTO Empresa VALUES (NULL, 'Point', '12345678901234', 1, 'Monitoramento de hardware');
INSERT INTO Funcionario VALUES (NULL, 'Fernando Brandão', '12345678901', '123456', 'brandao@point.com', DEFAULT, '11912345678', NULL, 1);
INSERT INTO Funcionario VALUES (NULL, 'Cleber Machado', '12345678902', '1234', 'cleber@point.com', 'Desenvolvedor Júnior', '11912345679', 1, 1);