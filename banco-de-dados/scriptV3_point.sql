create database BDpoint;

use BDpoint;

create table Empresa (
	idEmpresa int primary key auto_increment,
    nome varchar(45) not null,
    cnpj char(14) unique not null,
    descEmpresa varchar(45)
);

create table Funcionario (
	idFuncionario int primary key auto_increment,
    nome varchar(45) not null,
    cpf char(11) unique not null,
    senha varchar(45) not null,
    email varchar(45) unique,
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

-- INSERTS TESTE
INSERT INTO Empresa VALUES (NULL, 'Banco Safra', '12345678912345', 'Somos um banco, queremos dinheiro!');
INSERT INTO Funcionario VALUES (NULL, 'Ivan Miranda', '12345698545', '1234', 'ivan@miranda.com', NULL, 1);
INSERT INTO Endereco VALUES (NULL, 'Rua A', 23, 'Bairro XYV', 'SP', 'São Paulo', 'Brazil', 1, 1);
INSERT INTO Maquina VALUES (NULL, 'Windows 95', 'Lullynho', 1);
INSERT INTO Componente VALUES (NULL, 'CPU', 1);
INSERT INTO Atributo VALUES (NULL, 'Cores', 1.0, 'unidade', 1);


