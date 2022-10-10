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
INSERT INTO Endereco VALUES (NULL, 'Rua A', 23, 'Bairro XYV', 'São Paulo', 'SP', 'Brazil', 1, 1);
INSERT INTO Maquina VALUES (NULL, 'Windows 95', 'Lullynho', 1);
INSERT INTO Componente VALUES (NULL, 'CPU', 1);
INSERT INTO Atributo VALUES (NULL, 'Cores', 1.0, 'unidade', 1);


INSERT INTO Atributo VALUES (NULL, 'USO', 100, '%', 1);
INSERT INTO Componente VALUES (NULL, 'RAM', 1);
INSERT INTO Atributo VALUES (NULL, 'USO', 100, '%', 2);
INSERT INTO Componente VALUES (NULL, 'DISCO', 1);
INSERT INTO Atributo VALUES (NULL, 'USO', 100, '%', 3);
INSERT INTO Registro VALUES (NULL, 91, '%', '2022-10-06 6:0:0', 1);
INSERT INTO Registro VALUES (NULL, 30, '%', '2022-10-06 6:0:0', 2);
INSERT INTO Registro VALUES (NULL, 10, '%', '2022-10-06 6:0:0', 3);
INSERT INTO Registro VALUES (NULL, 12, '%', '2022-10-06 6:0:15', 1);
INSERT INTO Registro VALUES (NULL, 57, '%', '2022-10-06 6:0:15', 2);
INSERT INTO Registro VALUES (NULL, 34, '%', '2022-10-06 6:0:15', 3);
INSERT INTO Registro VALUES (NULL, 11, '%', '2022-10-06 6:0:30', 1);
INSERT INTO Registro VALUES (NULL, 76, '%', '2022-10-06 6:0:30', 2);
INSERT INTO Registro VALUES (NULL, 97, '%', '2022-10-06 6:0:30', 3);
INSERT INTO Registro VALUES (NULL, 43, '%', '2022-10-06 6:0:45', 1);
INSERT INTO Registro VALUES (NULL, 99, '%', '2022-10-06 6:0:45', 2);
INSERT INTO Registro VALUES (NULL, 56, '%', '2022-10-06 6:0:45', 3);
INSERT INTO Registro VALUES (NULL, 97, '%', '2022-10-06 6:1:0', 1);
INSERT INTO Registro VALUES (NULL, 28, '%', '2022-10-06 6:1:0', 2);
INSERT INTO Registro VALUES (NULL, 63, '%', '2022-10-06 6:1:0', 3);
INSERT INTO Registro VALUES (NULL, 28, '%', '2022-10-06 6:1:15', 1);
INSERT INTO Registro VALUES (NULL, 71, '%', '2022-10-06 6:1:15', 2);
INSERT INTO Registro VALUES (NULL, 64, '%', '2022-10-06 6:1:15', 3);
INSERT INTO Registro VALUES (NULL, 24, '%', '2022-10-06 6:1:30', 1);
INSERT INTO Registro VALUES (NULL, 47, '%', '2022-10-06 6:1:30', 2);
INSERT INTO Registro VALUES (NULL, 49, '%', '2022-10-06 6:1:30', 3);
INSERT INTO Registro VALUES (NULL, 84, '%', '2022-10-06 6:1:45', 1);
INSERT INTO Registro VALUES (NULL, 40, '%', '2022-10-06 6:1:45', 2);
INSERT INTO Registro VALUES (NULL, 5, '%', '2022-10-06 6:1:45', 3);
INSERT INTO Registro VALUES (NULL, 66, '%', '2022-10-06 6:2:0', 1);
INSERT INTO Registro VALUES (NULL, 19, '%', '2022-10-06 6:2:0', 2);
INSERT INTO Registro VALUES (NULL, 83, '%', '2022-10-06 6:2:0', 3);
INSERT INTO Registro VALUES (NULL, 41, '%', '2022-10-06 6:2:15', 1);
INSERT INTO Registro VALUES (NULL, 31, '%', '2022-10-06 6:2:15', 2);
INSERT INTO Registro VALUES (NULL, 5, '%', '2022-10-06 6:2:15', 3);
INSERT INTO Registro VALUES (NULL, 68, '%', '2022-10-06 6:2:30', 1);
INSERT INTO Registro VALUES (NULL, 97, '%', '2022-10-06 6:2:30', 2);
INSERT INTO Registro VALUES (NULL, 98, '%', '2022-10-06 6:2:30', 3);
INSERT INTO Registro VALUES (NULL, 92, '%', '2022-10-06 6:2:45', 1);
INSERT INTO Registro VALUES (NULL, 45, '%', '2022-10-06 6:2:45', 2);
INSERT INTO Registro VALUES (NULL, 6, '%', '2022-10-06 6:2:45', 3);
INSERT INTO Registro VALUES (NULL, 36, '%', '2022-10-06 6:3:0', 1);
INSERT INTO Registro VALUES (NULL, 37, '%', '2022-10-06 6:3:0', 2);
INSERT INTO Registro VALUES (NULL, 33, '%', '2022-10-06 6:3:0', 3);
INSERT INTO Registro VALUES (NULL, 6, '%', '2022-10-06 6:3:15', 1);
INSERT INTO Registro VALUES (NULL, 58, '%', '2022-10-06 6:3:15', 2);
INSERT INTO Registro VALUES (NULL, 27, '%', '2022-10-06 6:3:15', 3);
INSERT INTO Registro VALUES (NULL, 1, '%', '2022-10-06 6:3:30', 1);
INSERT INTO Registro VALUES (NULL, 95, '%', '2022-10-06 6:3:30', 2);
INSERT INTO Registro VALUES (NULL, 4, '%', '2022-10-06 6:3:30', 3);
INSERT INTO Registro VALUES (NULL, 14, '%', '2022-10-06 6:3:45', 1);
INSERT INTO Registro VALUES (NULL, 22, '%', '2022-10-06 6:3:45', 2);
INSERT INTO Registro VALUES (NULL, 51, '%', '2022-10-06 6:3:45', 3);
INSERT INTO Registro VALUES (NULL, 58, '%', '2022-10-06 6:4:0', 1);
INSERT INTO Registro VALUES (NULL, 28, '%', '2022-10-06 6:4:0', 2);
INSERT INTO Registro VALUES (NULL, 64, '%', '2022-10-06 6:4:0', 3);
INSERT INTO Registro VALUES (NULL, 97, '%', '2022-10-06 6:4:15', 1);
INSERT INTO Registro VALUES (NULL, 48, '%', '2022-10-06 6:4:15', 2);
INSERT INTO Registro VALUES (NULL, 91, '%', '2022-10-06 6:4:15', 3);
INSERT INTO Registro VALUES (NULL, 50, '%', '2022-10-06 6:4:30', 1);
INSERT INTO Registro VALUES (NULL, 33, '%', '2022-10-06 6:4:30', 2);
INSERT INTO Registro VALUES (NULL, 28, '%', '2022-10-06 6:4:30', 3);
INSERT INTO Registro VALUES (NULL, 24, '%', '2022-10-06 6:4:45', 1);
INSERT INTO Registro VALUES (NULL, 27, '%', '2022-10-06 6:4:45', 2);
INSERT INTO Registro VALUES (NULL, 54, '%', '2022-10-06 6:4:45', 3);
INSERT INTO Registro VALUES (NULL, 78, '%', '2022-10-06 6:5:0', 1);
INSERT INTO Registro VALUES (NULL, 28, '%', '2022-10-06 6:5:0', 2);
INSERT INTO Registro VALUES (NULL, 34, '%', '2022-10-06 6:5:0', 3);
INSERT INTO Registro VALUES (NULL, 68, '%', '2022-10-06 6:5:15', 1);
INSERT INTO Registro VALUES (NULL, 17, '%', '2022-10-06 6:5:15', 2);
INSERT INTO Registro VALUES (NULL, 57, '%', '2022-10-06 6:5:15', 3);
INSERT INTO Registro VALUES (NULL, 36, '%', '2022-10-06 6:5:30', 1);
INSERT INTO Registro VALUES (NULL, 55, '%', '2022-10-06 6:5:30', 2);
INSERT INTO Registro VALUES (NULL, 63, '%', '2022-10-06 6:5:30', 3);
INSERT INTO Registro VALUES (NULL, 6, '%', '2022-10-06 6:5:45', 1);
INSERT INTO Registro VALUES (NULL, 61, '%', '2022-10-06 6:5:45', 2);
INSERT INTO Registro VALUES (NULL, 58, '%', '2022-10-06 6:5:45', 3);
INSERT INTO Registro VALUES (NULL, 97, '%', '2022-10-06 6:6:0', 1);
INSERT INTO Registro VALUES (NULL, 15, '%', '2022-10-06 6:6:0', 2);
INSERT INTO Registro VALUES (NULL, 57, '%', '2022-10-06 6:6:0', 3);
INSERT INTO Registro VALUES (NULL, 96, '%', '2022-10-06 6:6:15', 1);
INSERT INTO Registro VALUES (NULL, 50, '%', '2022-10-06 6:6:15', 2);
INSERT INTO Registro VALUES (NULL, 2, '%', '2022-10-06 6:6:15', 3);
INSERT INTO Registro VALUES (NULL, 13, '%', '2022-10-06 6:6:30', 1);
INSERT INTO Registro VALUES (NULL, 65, '%', '2022-10-06 6:6:30', 2);
INSERT INTO Registro VALUES (NULL, 57, '%', '2022-10-06 6:6:30', 3);
INSERT INTO Registro VALUES (NULL, 65, '%', '2022-10-06 6:6:45', 1);
INSERT INTO Registro VALUES (NULL, 6, '%', '2022-10-06 6:6:45', 2);
INSERT INTO Registro VALUES (NULL, 37, '%', '2022-10-06 6:6:45', 3);
INSERT INTO Registro VALUES (NULL, 53, '%', '2022-10-06 6:7:0', 1);
INSERT INTO Registro VALUES (NULL, 97, '%', '2022-10-06 6:7:0', 2);
INSERT INTO Registro VALUES (NULL, 81, '%', '2022-10-06 6:7:0', 3);
INSERT INTO Registro VALUES (NULL, 39, '%', '2022-10-06 6:7:15', 1);
INSERT INTO Registro VALUES (NULL, 82, '%', '2022-10-06 6:7:15', 2);
INSERT INTO Registro VALUES (NULL, 42, '%', '2022-10-06 6:7:15', 3);
INSERT INTO Registro VALUES (NULL, 12, '%', '2022-10-06 6:7:30', 1);
INSERT INTO Registro VALUES (NULL, 81, '%', '2022-10-06 6:7:30', 2);
INSERT INTO Registro VALUES (NULL, 39, '%', '2022-10-06 6:7:30', 3);
INSERT INTO Registro VALUES (NULL, 45, '%', '2022-10-06 6:7:45', 1);
INSERT INTO Registro VALUES (NULL, 99, '%', '2022-10-06 6:7:45', 2);
INSERT INTO Registro VALUES (NULL, 61, '%', '2022-10-06 6:7:45', 3);
INSERT INTO Registro VALUES (NULL, 15, '%', '2022-10-06 6:8:0', 1);
INSERT INTO Registro VALUES (NULL, 73, '%', '2022-10-06 6:8:0', 2);
INSERT INTO Registro VALUES (NULL, 76, '%', '2022-10-06 6:8:0', 3);
INSERT INTO Registro VALUES (NULL, 78, '%', '2022-10-06 6:8:15', 1);
INSERT INTO Registro VALUES (NULL, 18, '%', '2022-10-06 6:8:15', 2);
INSERT INTO Registro VALUES (NULL, 83, '%', '2022-10-06 6:8:15', 3);
INSERT INTO Registro VALUES (NULL, 88, '%', '2022-10-06 6:8:30', 1);
INSERT INTO Registro VALUES (NULL, 70, '%', '2022-10-06 6:8:30', 2);
INSERT INTO Registro VALUES (NULL, 42, '%', '2022-10-06 6:8:30', 3);
INSERT INTO Registro VALUES (NULL, 8, '%', '2022-10-06 6:8:45', 1);
INSERT INTO Registro VALUES (NULL, 68, '%', '2022-10-06 6:8:45', 2);
INSERT INTO Registro VALUES (NULL, 67, '%', '2022-10-06 6:8:45', 3);
INSERT INTO Registro VALUES (NULL, 17, '%', '2022-10-06 6:9:0', 1);
INSERT INTO Registro VALUES (NULL, 83, '%', '2022-10-06 6:9:0', 2);
INSERT INTO Registro VALUES (NULL, 7, '%', '2022-10-06 6:9:0', 3);
INSERT INTO Registro VALUES (NULL, 60, '%', '2022-10-06 6:9:15', 1);
INSERT INTO Registro VALUES (NULL, 5, '%', '2022-10-06 6:9:15', 2);
INSERT INTO Registro VALUES (NULL, 78, '%', '2022-10-06 6:9:15', 3);
INSERT INTO Registro VALUES (NULL, 72, '%', '2022-10-06 6:9:30', 1);
INSERT INTO Registro VALUES (NULL, 21, '%', '2022-10-06 6:9:30', 2);
INSERT INTO Registro VALUES (NULL, 12, '%', '2022-10-06 6:9:30', 3);
INSERT INTO Registro VALUES (NULL, 77, '%', '2022-10-06 6:9:45', 1);
INSERT INTO Registro VALUES (NULL, 39, '%', '2022-10-06 6:9:45', 2);
INSERT INTO Registro VALUES (NULL, 86, '%', '2022-10-06 6:9:45', 3);
INSERT INTO Registro VALUES (NULL, 27, '%', '2022-10-06 6:10:0', 1);
INSERT INTO Registro VALUES (NULL, 89, '%', '2022-10-06 6:10:0', 2);
INSERT INTO Registro VALUES (NULL, 51, '%', '2022-10-06 6:10:0', 3);
INSERT INTO Registro VALUES (NULL, 20, '%', '2022-10-06 6:10:15', 1);
INSERT INTO Registro VALUES (NULL, 47, '%', '2022-10-06 6:10:15', 2);
INSERT INTO Registro VALUES (NULL, 7, '%', '2022-10-06 6:10:15', 3);
INSERT INTO Registro VALUES (NULL, 67, '%', '2022-10-06 6:10:30', 1);
INSERT INTO Registro VALUES (NULL, 26, '%', '2022-10-06 6:10:30', 2);
INSERT INTO Registro VALUES (NULL, 43, '%', '2022-10-06 6:10:30', 3);
INSERT INTO Registro VALUES (NULL, 73, '%', '2022-10-06 6:10:45', 1);
INSERT INTO Registro VALUES (NULL, 5, '%', '2022-10-06 6:10:45', 2);
INSERT INTO Registro VALUES (NULL, 47, '%', '2022-10-06 6:10:45', 3);
INSERT INTO Registro VALUES (NULL, 94, '%', '2022-10-06 6:11:0', 1);
INSERT INTO Registro VALUES (NULL, 73, '%', '2022-10-06 6:11:0', 2);
INSERT INTO Registro VALUES (NULL, 73, '%', '2022-10-06 6:11:0', 3);
INSERT INTO Registro VALUES (NULL, 42, '%', '2022-10-06 6:11:15', 1);
INSERT INTO Registro VALUES (NULL, 58, '%', '2022-10-06 6:11:15', 2);
INSERT INTO Registro VALUES (NULL, 88, '%', '2022-10-06 6:11:15', 3);
INSERT INTO Registro VALUES (NULL, 64, '%', '2022-10-06 6:11:30', 1);
INSERT INTO Registro VALUES (NULL, 55, '%', '2022-10-06 6:11:30', 2);
INSERT INTO Registro VALUES (NULL, 60, '%', '2022-10-06 6:11:30', 3);
INSERT INTO Registro VALUES (NULL, 99, '%', '2022-10-06 6:11:45', 1);
INSERT INTO Registro VALUES (NULL, 44, '%', '2022-10-06 6:11:45', 2);
INSERT INTO Registro VALUES (NULL, 16, '%', '2022-10-06 6:11:45', 3);
INSERT INTO Registro VALUES (NULL, 84, '%', '2022-10-06 6:12:0', 1);
INSERT INTO Registro VALUES (NULL, 44, '%', '2022-10-06 6:12:0', 2);
INSERT INTO Registro VALUES (NULL, 10, '%', '2022-10-06 6:12:0', 3);
INSERT INTO Registro VALUES (NULL, 87, '%', '2022-10-06 6:12:15', 1);
INSERT INTO Registro VALUES (NULL, 70, '%', '2022-10-06 6:12:15', 2);
INSERT INTO Registro VALUES (NULL, 82, '%', '2022-10-06 6:12:15', 3);
INSERT INTO Registro VALUES (NULL, 68, '%', '2022-10-06 6:12:30', 1);
INSERT INTO Registro VALUES (NULL, 6, '%', '2022-10-06 6:12:30', 2);
INSERT INTO Registro VALUES (NULL, 97, '%', '2022-10-06 6:12:30', 3);
INSERT INTO Registro VALUES (NULL, 22, '%', '2022-10-06 6:12:45', 1);
INSERT INTO Registro VALUES (NULL, 31, '%', '2022-10-06 6:12:45', 2);
INSERT INTO Registro VALUES (NULL, 46, '%', '2022-10-06 6:12:45', 3);
INSERT INTO Registro VALUES (NULL, 73, '%', '2022-10-06 6:13:0', 1);
INSERT INTO Registro VALUES (NULL, 9, '%', '2022-10-06 6:13:0', 2);
INSERT INTO Registro VALUES (NULL, 30, '%', '2022-10-06 6:13:0', 3);
INSERT INTO Registro VALUES (NULL, 3, '%', '2022-10-06 6:13:15', 1);
INSERT INTO Registro VALUES (NULL, 25, '%', '2022-10-06 6:13:15', 2);
INSERT INTO Registro VALUES (NULL, 17, '%', '2022-10-06 6:13:15', 3);
INSERT INTO Registro VALUES (NULL, 99, '%', '2022-10-06 6:13:30', 1);
INSERT INTO Registro VALUES (NULL, 80, '%', '2022-10-06 6:13:30', 2);
INSERT INTO Registro VALUES (NULL, 54, '%', '2022-10-06 6:13:30', 3);
INSERT INTO Registro VALUES (NULL, 1, '%', '2022-10-06 6:13:45', 1);
INSERT INTO Registro VALUES (NULL, 47, '%', '2022-10-06 6:13:45', 2);
INSERT INTO Registro VALUES (NULL, 35, '%', '2022-10-06 6:13:45', 3);
INSERT INTO Registro VALUES (NULL, 77, '%', '2022-10-06 6:14:0', 1);
INSERT INTO Registro VALUES (NULL, 82, '%', '2022-10-06 6:14:0', 2);
INSERT INTO Registro VALUES (NULL, 61, '%', '2022-10-06 6:14:0', 3);
INSERT INTO Registro VALUES (NULL, 70, '%', '2022-10-06 6:14:15', 1);
INSERT INTO Registro VALUES (NULL, 45, '%', '2022-10-06 6:14:15', 2);
INSERT INTO Registro VALUES (NULL, 17, '%', '2022-10-06 6:14:15', 3);
INSERT INTO Registro VALUES (NULL, 57, '%', '2022-10-06 6:14:30', 1);
INSERT INTO Registro VALUES (NULL, 43, '%', '2022-10-06 6:14:30', 2);
INSERT INTO Registro VALUES (NULL, 86, '%', '2022-10-06 6:14:30', 3);
INSERT INTO Registro VALUES (NULL, 18, '%', '2022-10-06 6:14:45', 1);
INSERT INTO Registro VALUES (NULL, 43, '%', '2022-10-06 6:14:45', 2);
INSERT INTO Registro VALUES (NULL, 8, '%', '2022-10-06 6:14:45', 3);
INSERT INTO Registro VALUES (NULL, 3, '%', '2022-10-06 6:15:0', 1);
INSERT INTO Registro VALUES (NULL, 13, '%', '2022-10-06 6:15:0', 2);
INSERT INTO Registro VALUES (NULL, 9, '%', '2022-10-06 6:15:0', 3);
INSERT INTO Registro VALUES (NULL, 14, '%', '2022-10-06 6:15:15', 1);
INSERT INTO Registro VALUES (NULL, 99, '%', '2022-10-06 6:15:15', 2);
INSERT INTO Registro VALUES (NULL, 49, '%', '2022-10-06 6:15:15', 3);
INSERT INTO Registro VALUES (NULL, 34, '%', '2022-10-06 6:15:30', 1);
INSERT INTO Registro VALUES (NULL, 42, '%', '2022-10-06 6:15:30', 2);
INSERT INTO Registro VALUES (NULL, 21, '%', '2022-10-06 6:15:30', 3);
INSERT INTO Registro VALUES (NULL, 79, '%', '2022-10-06 6:15:45', 1);
INSERT INTO Registro VALUES (NULL, 27, '%', '2022-10-06 6:15:45', 2);
INSERT INTO Registro VALUES (NULL, 12, '%', '2022-10-06 6:15:45', 3);
INSERT INTO Registro VALUES (NULL, 80, '%', '2022-10-06 6:16:0', 1);
INSERT INTO Registro VALUES (NULL, 74, '%', '2022-10-06 6:16:0', 2);
INSERT INTO Registro VALUES (NULL, 76, '%', '2022-10-06 6:16:0', 3);
INSERT INTO Registro VALUES (NULL, 58, '%', '2022-10-06 6:16:15', 1);
INSERT INTO Registro VALUES (NULL, 8, '%', '2022-10-06 6:16:15', 2);
INSERT INTO Registro VALUES (NULL, 98, '%', '2022-10-06 6:16:15', 3);
INSERT INTO Registro VALUES (NULL, 83, '%', '2022-10-06 6:16:30', 1);
INSERT INTO Registro VALUES (NULL, 46, '%', '2022-10-06 6:16:30', 2);
INSERT INTO Registro VALUES (NULL, 59, '%', '2022-10-06 6:16:30', 3);
INSERT INTO Registro VALUES (NULL, 35, '%', '2022-10-06 6:16:45', 1);
INSERT INTO Registro VALUES (NULL, 47, '%', '2022-10-06 6:16:45', 2);
INSERT INTO Registro VALUES (NULL, 1, '%', '2022-10-06 6:16:45', 3);
INSERT INTO Registro VALUES (NULL, 27, '%', '2022-10-06 6:17:0', 1);
INSERT INTO Registro VALUES (NULL, 18, '%', '2022-10-06 6:17:0', 2);
INSERT INTO Registro VALUES (NULL, 74, '%', '2022-10-06 6:17:0', 3);
INSERT INTO Registro VALUES (NULL, 46, '%', '2022-10-06 6:17:15', 1);
INSERT INTO Registro VALUES (NULL, 23, '%', '2022-10-06 6:17:15', 2);
INSERT INTO Registro VALUES (NULL, 11, '%', '2022-10-06 6:17:15', 3);
INSERT INTO Registro VALUES (NULL, 5, '%', '2022-10-06 6:17:30', 1);
INSERT INTO Registro VALUES (NULL, 95, '%', '2022-10-06 6:17:30', 2);
INSERT INTO Registro VALUES (NULL, 90, '%', '2022-10-06 6:17:30', 3);
INSERT INTO Registro VALUES (NULL, 76, '%', '2022-10-06 6:17:45', 1);
INSERT INTO Registro VALUES (NULL, 55, '%', '2022-10-06 6:17:45', 2);
INSERT INTO Registro VALUES (NULL, 59, '%', '2022-10-06 6:17:45', 3);
INSERT INTO Registro VALUES (NULL, 66, '%', '2022-10-06 6:18:0', 1);
INSERT INTO Registro VALUES (NULL, 94, '%', '2022-10-06 6:18:0', 2);
INSERT INTO Registro VALUES (NULL, 92, '%', '2022-10-06 6:18:0', 3);
INSERT INTO Registro VALUES (NULL, 19, '%', '2022-10-06 6:18:15', 1);
INSERT INTO Registro VALUES (NULL, 93, '%', '2022-10-06 6:18:15', 2);
INSERT INTO Registro VALUES (NULL, 54, '%', '2022-10-06 6:18:15', 3);
INSERT INTO Registro VALUES (NULL, 1, '%', '2022-10-06 6:18:30', 1);
INSERT INTO Registro VALUES (NULL, 85, '%', '2022-10-06 6:18:30', 2);
INSERT INTO Registro VALUES (NULL, 41, '%', '2022-10-06 6:18:30', 3);
INSERT INTO Registro VALUES (NULL, 51, '%', '2022-10-06 6:18:45', 1);
INSERT INTO Registro VALUES (NULL, 37, '%', '2022-10-06 6:18:45', 2);
INSERT INTO Registro VALUES (NULL, 84, '%', '2022-10-06 6:18:45', 3);
INSERT INTO Registro VALUES (NULL, 74, '%', '2022-10-06 6:19:0', 1);
INSERT INTO Registro VALUES (NULL, 29, '%', '2022-10-06 6:19:0', 2);
INSERT INTO Registro VALUES (NULL, 58, '%', '2022-10-06 6:19:0', 3);
INSERT INTO Registro VALUES (NULL, 46, '%', '2022-10-06 6:19:15', 1);
INSERT INTO Registro VALUES (NULL, 76, '%', '2022-10-06 6:19:15', 2);
INSERT INTO Registro VALUES (NULL, 40, '%', '2022-10-06 6:19:15', 3);
INSERT INTO Registro VALUES (NULL, 41, '%', '2022-10-06 6:19:30', 1);
INSERT INTO Registro VALUES (NULL, 97, '%', '2022-10-06 6:19:30', 2);
INSERT INTO Registro VALUES (NULL, 70, '%', '2022-10-06 6:19:30', 3);
INSERT INTO Registro VALUES (NULL, 27, '%', '2022-10-06 6:19:45', 1);
INSERT INTO Registro VALUES (NULL, 57, '%', '2022-10-06 6:19:45', 2);
INSERT INTO Registro VALUES (NULL, 44, '%', '2022-10-06 6:19:45', 3);
INSERT INTO Registro VALUES (NULL, 26, '%', '2022-10-06 6:20:0', 1);
INSERT INTO Registro VALUES (NULL, 35, '%', '2022-10-06 6:20:0', 2);
INSERT INTO Registro VALUES (NULL, 63, '%', '2022-10-06 6:20:0', 3);
INSERT INTO Registro VALUES (NULL, 81, '%', '2022-10-06 6:20:15', 1);
INSERT INTO Registro VALUES (NULL, 17, '%', '2022-10-06 6:20:15', 2);
INSERT INTO Registro VALUES (NULL, 90, '%', '2022-10-06 6:20:15', 3);
INSERT INTO Registro VALUES (NULL, 92, '%', '2022-10-06 6:20:30', 1);
INSERT INTO Registro VALUES (NULL, 40, '%', '2022-10-06 6:20:30', 2);
INSERT INTO Registro VALUES (NULL, 69, '%', '2022-10-06 6:20:30', 3);
INSERT INTO Registro VALUES (NULL, 98, '%', '2022-10-06 6:20:45', 1);
INSERT INTO Registro VALUES (NULL, 76, '%', '2022-10-06 6:20:45', 2);
INSERT INTO Registro VALUES (NULL, 25, '%', '2022-10-06 6:20:45', 3);
INSERT INTO Registro VALUES (NULL, 20, '%', '2022-10-06 6:21:0', 1);
INSERT INTO Registro VALUES (NULL, 36, '%', '2022-10-06 6:21:0', 2);
INSERT INTO Registro VALUES (NULL, 58, '%', '2022-10-06 6:21:0', 3);
INSERT INTO Registro VALUES (NULL, 96, '%', '2022-10-06 6:21:15', 1);
INSERT INTO Registro VALUES (NULL, 41, '%', '2022-10-06 6:21:15', 2);
INSERT INTO Registro VALUES (NULL, 44, '%', '2022-10-06 6:21:15', 3);
INSERT INTO Registro VALUES (NULL, 27, '%', '2022-10-06 6:21:30', 1);
INSERT INTO Registro VALUES (NULL, 83, '%', '2022-10-06 6:21:30', 2);
INSERT INTO Registro VALUES (NULL, 91, '%', '2022-10-06 6:21:30', 3);
INSERT INTO Registro VALUES (NULL, 56, '%', '2022-10-06 6:21:45', 1);
INSERT INTO Registro VALUES (NULL, 96, '%', '2022-10-06 6:21:45', 2);
INSERT INTO Registro VALUES (NULL, 88, '%', '2022-10-06 6:21:45', 3);
INSERT INTO Registro VALUES (NULL, 93, '%', '2022-10-06 6:22:0', 1);
INSERT INTO Registro VALUES (NULL, 68, '%', '2022-10-06 6:22:0', 2);
INSERT INTO Registro VALUES (NULL, 19, '%', '2022-10-06 6:22:0', 3);
INSERT INTO Registro VALUES (NULL, 92, '%', '2022-10-06 6:22:15', 1);
INSERT INTO Registro VALUES (NULL, 65, '%', '2022-10-06 6:22:15', 2);
INSERT INTO Registro VALUES (NULL, 44, '%', '2022-10-06 6:22:15', 3);
INSERT INTO Registro VALUES (NULL, 49, '%', '2022-10-06 6:22:30', 1);
INSERT INTO Registro VALUES (NULL, 58, '%', '2022-10-06 6:22:30', 2);
INSERT INTO Registro VALUES (NULL, 12, '%', '2022-10-06 6:22:30', 3);
INSERT INTO Registro VALUES (NULL, 13, '%', '2022-10-06 6:22:45', 1);
INSERT INTO Registro VALUES (NULL, 31, '%', '2022-10-06 6:22:45', 2);
INSERT INTO Registro VALUES (NULL, 60, '%', '2022-10-06 6:22:45', 3);
INSERT INTO Registro VALUES (NULL, 16, '%', '2022-10-06 6:23:0', 1);
INSERT INTO Registro VALUES (NULL, 66, '%', '2022-10-06 6:23:0', 2);
INSERT INTO Registro VALUES (NULL, 72, '%', '2022-10-06 6:23:0', 3);
INSERT INTO Registro VALUES (NULL, 31, '%', '2022-10-06 6:23:15', 1);
INSERT INTO Registro VALUES (NULL, 53, '%', '2022-10-06 6:23:15', 2);
INSERT INTO Registro VALUES (NULL, 71, '%', '2022-10-06 6:23:15', 3);
INSERT INTO Registro VALUES (NULL, 22, '%', '2022-10-06 6:23:30', 1);
INSERT INTO Registro VALUES (NULL, 63, '%', '2022-10-06 6:23:30', 2);
INSERT INTO Registro VALUES (NULL, 70, '%', '2022-10-06 6:23:30', 3);
INSERT INTO Registro VALUES (NULL, 56, '%', '2022-10-06 6:23:45', 1);
INSERT INTO Registro VALUES (NULL, 59, '%', '2022-10-06 6:23:45', 2);
INSERT INTO Registro VALUES (NULL, 79, '%', '2022-10-06 6:23:45', 3);
INSERT INTO Registro VALUES (NULL, 95, '%', '2022-10-06 6:24:0', 1);
INSERT INTO Registro VALUES (NULL, 50, '%', '2022-10-06 6:24:0', 2);
INSERT INTO Registro VALUES (NULL, 36, '%', '2022-10-06 6:24:0', 3);
INSERT INTO Registro VALUES (NULL, 90, '%', '2022-10-06 6:24:15', 1);
INSERT INTO Registro VALUES (NULL, 95, '%', '2022-10-06 6:24:15', 2);
INSERT INTO Registro VALUES (NULL, 51, '%', '2022-10-06 6:24:15', 3);
INSERT INTO Registro VALUES (NULL, 94, '%', '2022-10-06 6:24:30', 1);
INSERT INTO Registro VALUES (NULL, 12, '%', '2022-10-06 6:24:30', 2);
INSERT INTO Registro VALUES (NULL, 68, '%', '2022-10-06 6:24:30', 3);
INSERT INTO Registro VALUES (NULL, 19, '%', '2022-10-06 6:24:45', 1);
INSERT INTO Registro VALUES (NULL, 12, '%', '2022-10-06 6:24:45', 2);
INSERT INTO Registro VALUES (NULL, 26, '%', '2022-10-06 6:24:45', 3);
INSERT INTO Registro VALUES (NULL, 43, '%', '2022-10-06 6:25:0', 1);
INSERT INTO Registro VALUES (NULL, 57, '%', '2022-10-06 6:25:0', 2);
INSERT INTO Registro VALUES (NULL, 28, '%', '2022-10-06 6:25:0', 3);
INSERT INTO Registro VALUES (NULL, 64, '%', '2022-10-06 6:25:15', 1);
INSERT INTO Registro VALUES (NULL, 86, '%', '2022-10-06 6:25:15', 2);
INSERT INTO Registro VALUES (NULL, 31, '%', '2022-10-06 6:25:15', 3);
INSERT INTO Registro VALUES (NULL, 8, '%', '2022-10-06 6:25:30', 1);
INSERT INTO Registro VALUES (NULL, 29, '%', '2022-10-06 6:25:30', 2);
INSERT INTO Registro VALUES (NULL, 15, '%', '2022-10-06 6:25:30', 3);
INSERT INTO Registro VALUES (NULL, 40, '%', '2022-10-06 6:25:45', 1);
INSERT INTO Registro VALUES (NULL, 37, '%', '2022-10-06 6:25:45', 2);
INSERT INTO Registro VALUES (NULL, 48, '%', '2022-10-06 6:25:45', 3);
INSERT INTO Registro VALUES (NULL, 86, '%', '2022-10-06 6:26:0', 1);
INSERT INTO Registro VALUES (NULL, 28, '%', '2022-10-06 6:26:0', 2);
INSERT INTO Registro VALUES (NULL, 84, '%', '2022-10-06 6:26:0', 3);
INSERT INTO Registro VALUES (NULL, 25, '%', '2022-10-06 6:26:15', 1);
INSERT INTO Registro VALUES (NULL, 60, '%', '2022-10-06 6:26:15', 2);
INSERT INTO Registro VALUES (NULL, 91, '%', '2022-10-06 6:26:15', 3);
INSERT INTO Registro VALUES (NULL, 79, '%', '2022-10-06 6:26:30', 1);
INSERT INTO Registro VALUES (NULL, 31, '%', '2022-10-06 6:26:30', 2);
INSERT INTO Registro VALUES (NULL, 65, '%', '2022-10-06 6:26:30', 3);
INSERT INTO Registro VALUES (NULL, 51, '%', '2022-10-06 6:26:45', 1);
INSERT INTO Registro VALUES (NULL, 37, '%', '2022-10-06 6:26:45', 2);
INSERT INTO Registro VALUES (NULL, 41, '%', '2022-10-06 6:26:45', 3);
INSERT INTO Registro VALUES (NULL, 22, '%', '2022-10-06 6:27:0', 1);
INSERT INTO Registro VALUES (NULL, 71, '%', '2022-10-06 6:27:0', 2);
INSERT INTO Registro VALUES (NULL, 78, '%', '2022-10-06 6:27:0', 3);
INSERT INTO Registro VALUES (NULL, 62, '%', '2022-10-06 6:27:15', 1);
INSERT INTO Registro VALUES (NULL, 78, '%', '2022-10-06 6:27:15', 2);
INSERT INTO Registro VALUES (NULL, 85, '%', '2022-10-06 6:27:15', 3);
INSERT INTO Registro VALUES (NULL, 77, '%', '2022-10-06 6:27:30', 1);
INSERT INTO Registro VALUES (NULL, 98, '%', '2022-10-06 6:27:30', 2);
INSERT INTO Registro VALUES (NULL, 3, '%', '2022-10-06 6:27:30', 3);
INSERT INTO Registro VALUES (NULL, 75, '%', '2022-10-06 6:27:45', 1);
INSERT INTO Registro VALUES (NULL, 15, '%', '2022-10-06 6:27:45', 2);
INSERT INTO Registro VALUES (NULL, 60, '%', '2022-10-06 6:27:45', 3);
INSERT INTO Registro VALUES (NULL, 52, '%', '2022-10-06 6:28:0', 1);
INSERT INTO Registro VALUES (NULL, 82, '%', '2022-10-06 6:28:0', 2);
INSERT INTO Registro VALUES (NULL, 78, '%', '2022-10-06 6:28:0', 3);
INSERT INTO Registro VALUES (NULL, 48, '%', '2022-10-06 6:28:15', 1);
INSERT INTO Registro VALUES (NULL, 74, '%', '2022-10-06 6:28:15', 2);
INSERT INTO Registro VALUES (NULL, 96, '%', '2022-10-06 6:28:15', 3);
INSERT INTO Registro VALUES (NULL, 15, '%', '2022-10-06 6:28:30', 1);
INSERT INTO Registro VALUES (NULL, 93, '%', '2022-10-06 6:28:30', 2);
INSERT INTO Registro VALUES (NULL, 24, '%', '2022-10-06 6:28:30', 3);
INSERT INTO Registro VALUES (NULL, 77, '%', '2022-10-06 6:28:45', 1);
INSERT INTO Registro VALUES (NULL, 94, '%', '2022-10-06 6:28:45', 2);
INSERT INTO Registro VALUES (NULL, 69, '%', '2022-10-06 6:28:45', 3);
INSERT INTO Registro VALUES (NULL, 11, '%', '2022-10-06 6:29:0', 1);
INSERT INTO Registro VALUES (NULL, 85, '%', '2022-10-06 6:29:0', 2);
INSERT INTO Registro VALUES (NULL, 84, '%', '2022-10-06 6:29:0', 3);
INSERT INTO Registro VALUES (NULL, 98, '%', '2022-10-06 6:29:15', 1);
INSERT INTO Registro VALUES (NULL, 90, '%', '2022-10-06 6:29:15', 2);
INSERT INTO Registro VALUES (NULL, 20, '%', '2022-10-06 6:29:15', 3);
INSERT INTO Registro VALUES (NULL, 81, '%', '2022-10-06 6:29:30', 1);
INSERT INTO Registro VALUES (NULL, 27, '%', '2022-10-06 6:29:30', 2);
INSERT INTO Registro VALUES (NULL, 33, '%', '2022-10-06 6:29:30', 3);
INSERT INTO Registro VALUES (NULL, 14, '%', '2022-10-06 6:29:45', 1);
INSERT INTO Registro VALUES (NULL, 17, '%', '2022-10-06 6:29:45', 2);
INSERT INTO Registro VALUES (NULL, 41, '%', '2022-10-06 6:29:45', 3);
INSERT INTO Registro VALUES (NULL, 25, '%', '2022-10-06 6:30:0', 1);
INSERT INTO Registro VALUES (NULL, 73, '%', '2022-10-06 6:30:0', 2);
INSERT INTO Registro VALUES (NULL, 7, '%', '2022-10-06 6:30:0', 3);
INSERT INTO Registro VALUES (NULL, 76, '%', '2022-10-06 6:30:15', 1);
INSERT INTO Registro VALUES (NULL, 76, '%', '2022-10-06 6:30:15', 2);
INSERT INTO Registro VALUES (NULL, 93, '%', '2022-10-06 6:30:15', 3);
INSERT INTO Registro VALUES (NULL, 62, '%', '2022-10-06 6:30:30', 1);
INSERT INTO Registro VALUES (NULL, 86, '%', '2022-10-06 6:30:30', 2);
INSERT INTO Registro VALUES (NULL, 90, '%', '2022-10-06 6:30:30', 3);
INSERT INTO Registro VALUES (NULL, 4, '%', '2022-10-06 6:30:45', 1);
INSERT INTO Registro VALUES (NULL, 91, '%', '2022-10-06 6:30:45', 2);
INSERT INTO Registro VALUES (NULL, 9, '%', '2022-10-06 6:30:45', 3);
INSERT INTO Registro VALUES (NULL, 54, '%', '2022-10-06 6:31:0', 1);
INSERT INTO Registro VALUES (NULL, 93, '%', '2022-10-06 6:31:0', 2);
INSERT INTO Registro VALUES (NULL, 24, '%', '2022-10-06 6:31:0', 3);
INSERT INTO Registro VALUES (NULL, 6, '%', '2022-10-06 6:31:15', 1);
INSERT INTO Registro VALUES (NULL, 26, '%', '2022-10-06 6:31:15', 2);
INSERT INTO Registro VALUES (NULL, 45, '%', '2022-10-06 6:31:15', 3);
INSERT INTO Registro VALUES (NULL, 38, '%', '2022-10-06 6:31:30', 1);
INSERT INTO Registro VALUES (NULL, 15, '%', '2022-10-06 6:31:30', 2);
INSERT INTO Registro VALUES (NULL, 71, '%', '2022-10-06 6:31:30', 3);
INSERT INTO Registro VALUES (NULL, 54, '%', '2022-10-06 6:31:45', 1);
INSERT INTO Registro VALUES (NULL, 6, '%', '2022-10-06 6:31:45', 2);
INSERT INTO Registro VALUES (NULL, 43, '%', '2022-10-06 6:31:45', 3);
INSERT INTO Registro VALUES (NULL, 38, '%', '2022-10-06 6:32:0', 1);
INSERT INTO Registro VALUES (NULL, 98, '%', '2022-10-06 6:32:0', 2);
INSERT INTO Registro VALUES (NULL, 89, '%', '2022-10-06 6:32:0', 3);
INSERT INTO Registro VALUES (NULL, 57, '%', '2022-10-06 6:32:15', 1);
INSERT INTO Registro VALUES (NULL, 58, '%', '2022-10-06 6:32:15', 2);
INSERT INTO Registro VALUES (NULL, 97, '%', '2022-10-06 6:32:15', 3);
INSERT INTO Registro VALUES (NULL, 20, '%', '2022-10-06 6:32:30', 1);
INSERT INTO Registro VALUES (NULL, 20, '%', '2022-10-06 6:32:30', 2);
INSERT INTO Registro VALUES (NULL, 29, '%', '2022-10-06 6:32:30', 3);
INSERT INTO Registro VALUES (NULL, 46, '%', '2022-10-06 6:32:45', 1);
INSERT INTO Registro VALUES (NULL, 64, '%', '2022-10-06 6:32:45', 2);
INSERT INTO Registro VALUES (NULL, 42, '%', '2022-10-06 6:32:45', 3);
INSERT INTO Registro VALUES (NULL, 90, '%', '2022-10-06 6:33:0', 1);
INSERT INTO Registro VALUES (NULL, 11, '%', '2022-10-06 6:33:0', 2);
INSERT INTO Registro VALUES (NULL, 57, '%', '2022-10-06 6:33:0', 3);
INSERT INTO Registro VALUES (NULL, 26, '%', '2022-10-06 6:33:15', 1);
INSERT INTO Registro VALUES (NULL, 16, '%', '2022-10-06 6:33:15', 2);
INSERT INTO Registro VALUES (NULL, 63, '%', '2022-10-06 6:33:15', 3);
INSERT INTO Registro VALUES (NULL, 29, '%', '2022-10-06 6:33:30', 1);
INSERT INTO Registro VALUES (NULL, 69, '%', '2022-10-06 6:33:30', 2);
INSERT INTO Registro VALUES (NULL, 70, '%', '2022-10-06 6:33:30', 3);
INSERT INTO Registro VALUES (NULL, 65, '%', '2022-10-06 6:33:45', 1);
INSERT INTO Registro VALUES (NULL, 15, '%', '2022-10-06 6:33:45', 2);
INSERT INTO Registro VALUES (NULL, 32, '%', '2022-10-06 6:33:45', 3);
INSERT INTO Registro VALUES (NULL, 6, '%', '2022-10-06 6:34:0', 1);
INSERT INTO Registro VALUES (NULL, 83, '%', '2022-10-06 6:34:0', 2);
INSERT INTO Registro VALUES (NULL, 33, '%', '2022-10-06 6:34:0', 3);
INSERT INTO Registro VALUES (NULL, 75, '%', '2022-10-06 6:34:15', 1);
INSERT INTO Registro VALUES (NULL, 88, '%', '2022-10-06 6:34:15', 2);
INSERT INTO Registro VALUES (NULL, 26, '%', '2022-10-06 6:34:15', 3);
INSERT INTO Registro VALUES (NULL, 5, '%', '2022-10-06 6:34:30', 1);
INSERT INTO Registro VALUES (NULL, 77, '%', '2022-10-06 6:34:30', 2);
INSERT INTO Registro VALUES (NULL, 52, '%', '2022-10-06 6:34:30', 3);
INSERT INTO Registro VALUES (NULL, 62, '%', '2022-10-06 6:34:45', 1);
INSERT INTO Registro VALUES (NULL, 54, '%', '2022-10-06 6:34:45', 2);
INSERT INTO Registro VALUES (NULL, 29, '%', '2022-10-06 6:34:45', 3);
INSERT INTO Registro VALUES (NULL, 86, '%', '2022-10-06 6:35:0', 1);
INSERT INTO Registro VALUES (NULL, 96, '%', '2022-10-06 6:35:0', 2);
INSERT INTO Registro VALUES (NULL, 46, '%', '2022-10-06 6:35:0', 3);
INSERT INTO Registro VALUES (NULL, 43, '%', '2022-10-06 6:35:15', 1);
INSERT INTO Registro VALUES (NULL, 7, '%', '2022-10-06 6:35:15', 2);
INSERT INTO Registro VALUES (NULL, 24, '%', '2022-10-06 6:35:15', 3);
INSERT INTO Registro VALUES (NULL, 36, '%', '2022-10-06 6:35:30', 1);
INSERT INTO Registro VALUES (NULL, 65, '%', '2022-10-06 6:35:30', 2);
INSERT INTO Registro VALUES (NULL, 25, '%', '2022-10-06 6:35:30', 3);
INSERT INTO Registro VALUES (NULL, 13, '%', '2022-10-06 6:35:45', 1);
INSERT INTO Registro VALUES (NULL, 53, '%', '2022-10-06 6:35:45', 2);
INSERT INTO Registro VALUES (NULL, 85, '%', '2022-10-06 6:35:45', 3);
INSERT INTO Registro VALUES (NULL, 88, '%', '2022-10-06 6:36:0', 1);
INSERT INTO Registro VALUES (NULL, 33, '%', '2022-10-06 6:36:0', 2);
INSERT INTO Registro VALUES (NULL, 98, '%', '2022-10-06 6:36:0', 3);
INSERT INTO Registro VALUES (NULL, 35, '%', '2022-10-06 6:36:15', 1);
INSERT INTO Registro VALUES (NULL, 45, '%', '2022-10-06 6:36:15', 2);
INSERT INTO Registro VALUES (NULL, 47, '%', '2022-10-06 6:36:15', 3);
INSERT INTO Registro VALUES (NULL, 86, '%', '2022-10-06 6:36:30', 1);
INSERT INTO Registro VALUES (NULL, 21, '%', '2022-10-06 6:36:30', 2);
INSERT INTO Registro VALUES (NULL, 9, '%', '2022-10-06 6:36:30', 3);
INSERT INTO Registro VALUES (NULL, 15, '%', '2022-10-06 6:36:45', 1);
INSERT INTO Registro VALUES (NULL, 46, '%', '2022-10-06 6:36:45', 2);
INSERT INTO Registro VALUES (NULL, 6, '%', '2022-10-06 6:36:45', 3);
INSERT INTO Registro VALUES (NULL, 52, '%', '2022-10-06 6:37:0', 1);
INSERT INTO Registro VALUES (NULL, 69, '%', '2022-10-06 6:37:0', 2);
INSERT INTO Registro VALUES (NULL, 30, '%', '2022-10-06 6:37:0', 3);
INSERT INTO Registro VALUES (NULL, 54, '%', '2022-10-06 6:37:15', 1);
INSERT INTO Registro VALUES (NULL, 21, '%', '2022-10-06 6:37:15', 2);
INSERT INTO Registro VALUES (NULL, 46, '%', '2022-10-06 6:37:15', 3);
INSERT INTO Registro VALUES (NULL, 51, '%', '2022-10-06 6:37:30', 1);
INSERT INTO Registro VALUES (NULL, 39, '%', '2022-10-06 6:37:30', 2);
INSERT INTO Registro VALUES (NULL, 72, '%', '2022-10-06 6:37:30', 3);
INSERT INTO Registro VALUES (NULL, 79, '%', '2022-10-06 6:37:45', 1);
INSERT INTO Registro VALUES (NULL, 35, '%', '2022-10-06 6:37:45', 2);
INSERT INTO Registro VALUES (NULL, 64, '%', '2022-10-06 6:37:45', 3);
INSERT INTO Registro VALUES (NULL, 66, '%', '2022-10-06 6:38:0', 1);
INSERT INTO Registro VALUES (NULL, 77, '%', '2022-10-06 6:38:0', 2);
INSERT INTO Registro VALUES (NULL, 89, '%', '2022-10-06 6:38:0', 3);
INSERT INTO Registro VALUES (NULL, 43, '%', '2022-10-06 6:38:15', 1);
INSERT INTO Registro VALUES (NULL, 93, '%', '2022-10-06 6:38:15', 2);
INSERT INTO Registro VALUES (NULL, 5, '%', '2022-10-06 6:38:15', 3);
INSERT INTO Registro VALUES (NULL, 5, '%', '2022-10-06 6:38:30', 1);
INSERT INTO Registro VALUES (NULL, 44, '%', '2022-10-06 6:38:30', 2);
INSERT INTO Registro VALUES (NULL, 29, '%', '2022-10-06 6:38:30', 3);
INSERT INTO Registro VALUES (NULL, 54, '%', '2022-10-06 6:38:45', 1);
INSERT INTO Registro VALUES (NULL, 51, '%', '2022-10-06 6:38:45', 2);
INSERT INTO Registro VALUES (NULL, 29, '%', '2022-10-06 6:38:45', 3);
INSERT INTO Registro VALUES (NULL, 98, '%', '2022-10-06 6:39:0', 1);
INSERT INTO Registro VALUES (NULL, 42, '%', '2022-10-06 6:39:0', 2);
INSERT INTO Registro VALUES (NULL, 66, '%', '2022-10-06 6:39:0', 3);
INSERT INTO Registro VALUES (NULL, 84, '%', '2022-10-06 6:39:15', 1);
INSERT INTO Registro VALUES (NULL, 99, '%', '2022-10-06 6:39:15', 2);
INSERT INTO Registro VALUES (NULL, 17, '%', '2022-10-06 6:39:15', 3);
INSERT INTO Registro VALUES (NULL, 37, '%', '2022-10-06 6:39:30', 1);
INSERT INTO Registro VALUES (NULL, 89, '%', '2022-10-06 6:39:30', 2);
INSERT INTO Registro VALUES (NULL, 91, '%', '2022-10-06 6:39:30', 3);
INSERT INTO Registro VALUES (NULL, 73, '%', '2022-10-06 6:39:45', 1);
INSERT INTO Registro VALUES (NULL, 51, '%', '2022-10-06 6:39:45', 2);
INSERT INTO Registro VALUES (NULL, 23, '%', '2022-10-06 6:39:45', 3);
INSERT INTO Registro VALUES (NULL, 46, '%', '2022-10-06 6:40:0', 1);
INSERT INTO Registro VALUES (NULL, 61, '%', '2022-10-06 6:40:0', 2);
INSERT INTO Registro VALUES (NULL, 63, '%', '2022-10-06 6:40:0', 3);
INSERT INTO Registro VALUES (NULL, 72, '%', '2022-10-06 6:40:15', 1);
INSERT INTO Registro VALUES (NULL, 11, '%', '2022-10-06 6:40:15', 2);
INSERT INTO Registro VALUES (NULL, 44, '%', '2022-10-06 6:40:15', 3);
INSERT INTO Registro VALUES (NULL, 37, '%', '2022-10-06 6:40:30', 1);
INSERT INTO Registro VALUES (NULL, 29, '%', '2022-10-06 6:40:30', 2);
INSERT INTO Registro VALUES (NULL, 85, '%', '2022-10-06 6:40:30', 3);
INSERT INTO Registro VALUES (NULL, 79, '%', '2022-10-06 6:40:45', 1);
INSERT INTO Registro VALUES (NULL, 49, '%', '2022-10-06 6:40:45', 2);
INSERT INTO Registro VALUES (NULL, 55, '%', '2022-10-06 6:40:45', 3);
INSERT INTO Registro VALUES (NULL, 12, '%', '2022-10-06 6:41:0', 1);
INSERT INTO Registro VALUES (NULL, 18, '%', '2022-10-06 6:41:0', 2);
INSERT INTO Registro VALUES (NULL, 99, '%', '2022-10-06 6:41:0', 3);
INSERT INTO Registro VALUES (NULL, 74, '%', '2022-10-06 6:41:15', 1);
INSERT INTO Registro VALUES (NULL, 31, '%', '2022-10-06 6:41:15', 2);
INSERT INTO Registro VALUES (NULL, 42, '%', '2022-10-06 6:41:15', 3);
INSERT INTO Registro VALUES (NULL, 28, '%', '2022-10-06 6:41:30', 1);
INSERT INTO Registro VALUES (NULL, 94, '%', '2022-10-06 6:41:30', 2);
INSERT INTO Registro VALUES (NULL, 5, '%', '2022-10-06 6:41:30', 3);
INSERT INTO Registro VALUES (NULL, 61, '%', '2022-10-06 6:41:45', 1);
INSERT INTO Registro VALUES (NULL, 82, '%', '2022-10-06 6:41:45', 2);
INSERT INTO Registro VALUES (NULL, 29, '%', '2022-10-06 6:41:45', 3);
INSERT INTO Registro VALUES (NULL, 12, '%', '2022-10-06 6:42:0', 1);
INSERT INTO Registro VALUES (NULL, 22, '%', '2022-10-06 6:42:0', 2);
INSERT INTO Registro VALUES (NULL, 14, '%', '2022-10-06 6:42:0', 3);
INSERT INTO Registro VALUES (NULL, 19, '%', '2022-10-06 6:42:15', 1);
INSERT INTO Registro VALUES (NULL, 41, '%', '2022-10-06 6:42:15', 2);
INSERT INTO Registro VALUES (NULL, 49, '%', '2022-10-06 6:42:15', 3);
INSERT INTO Registro VALUES (NULL, 9, '%', '2022-10-06 6:42:30', 1);
INSERT INTO Registro VALUES (NULL, 33, '%', '2022-10-06 6:42:30', 2);
INSERT INTO Registro VALUES (NULL, 19, '%', '2022-10-06 6:42:30', 3);
INSERT INTO Registro VALUES (NULL, 90, '%', '2022-10-06 6:42:45', 1);
INSERT INTO Registro VALUES (NULL, 21, '%', '2022-10-06 6:42:45', 2);
INSERT INTO Registro VALUES (NULL, 19, '%', '2022-10-06 6:42:45', 3);
INSERT INTO Registro VALUES (NULL, 24, '%', '2022-10-06 6:43:0', 1);
INSERT INTO Registro VALUES (NULL, 83, '%', '2022-10-06 6:43:0', 2);
INSERT INTO Registro VALUES (NULL, 99, '%', '2022-10-06 6:43:0', 3);
INSERT INTO Registro VALUES (NULL, 20, '%', '2022-10-06 6:43:15', 1);
INSERT INTO Registro VALUES (NULL, 40, '%', '2022-10-06 6:43:15', 2);
INSERT INTO Registro VALUES (NULL, 14, '%', '2022-10-06 6:43:15', 3);
INSERT INTO Registro VALUES (NULL, 15, '%', '2022-10-06 6:43:30', 1);
INSERT INTO Registro VALUES (NULL, 7, '%', '2022-10-06 6:43:30', 2);
INSERT INTO Registro VALUES (NULL, 84, '%', '2022-10-06 6:43:30', 3);
INSERT INTO Registro VALUES (NULL, 74, '%', '2022-10-06 6:43:45', 1);
INSERT INTO Registro VALUES (NULL, 30, '%', '2022-10-06 6:43:45', 2);
INSERT INTO Registro VALUES (NULL, 35, '%', '2022-10-06 6:43:45', 3);
INSERT INTO Registro VALUES (NULL, 48, '%', '2022-10-06 6:44:0', 1);
INSERT INTO Registro VALUES (NULL, 2, '%', '2022-10-06 6:44:0', 2);
INSERT INTO Registro VALUES (NULL, 64, '%', '2022-10-06 6:44:0', 3);
INSERT INTO Registro VALUES (NULL, 44, '%', '2022-10-06 6:44:15', 1);
INSERT INTO Registro VALUES (NULL, 65, '%', '2022-10-06 6:44:15', 2);
INSERT INTO Registro VALUES (NULL, 12, '%', '2022-10-06 6:44:15', 3);
INSERT INTO Registro VALUES (NULL, 37, '%', '2022-10-06 6:44:30', 1);
INSERT INTO Registro VALUES (NULL, 20, '%', '2022-10-06 6:44:30', 2);
INSERT INTO Registro VALUES (NULL, 17, '%', '2022-10-06 6:44:30', 3);
INSERT INTO Registro VALUES (NULL, 27, '%', '2022-10-06 6:44:45', 1);
INSERT INTO Registro VALUES (NULL, 30, '%', '2022-10-06 6:44:45', 2);
INSERT INTO Registro VALUES (NULL, 46, '%', '2022-10-06 6:44:45', 3);
INSERT INTO Registro VALUES (NULL, 17, '%', '2022-10-06 6:45:0', 1);
INSERT INTO Registro VALUES (NULL, 10, '%', '2022-10-06 6:45:0', 2);
INSERT INTO Registro VALUES (NULL, 60, '%', '2022-10-06 6:45:0', 3);
INSERT INTO Registro VALUES (NULL, 40, '%', '2022-10-06 6:45:15', 1);
INSERT INTO Registro VALUES (NULL, 54, '%', '2022-10-06 6:45:15', 2);
INSERT INTO Registro VALUES (NULL, 83, '%', '2022-10-06 6:45:15', 3);
INSERT INTO Registro VALUES (NULL, 83, '%', '2022-10-06 6:45:30', 1);
INSERT INTO Registro VALUES (NULL, 59, '%', '2022-10-06 6:45:30', 2);
INSERT INTO Registro VALUES (NULL, 89, '%', '2022-10-06 6:45:30', 3);
INSERT INTO Registro VALUES (NULL, 26, '%', '2022-10-06 6:45:45', 1);
INSERT INTO Registro VALUES (NULL, 39, '%', '2022-10-06 6:45:45', 2);
INSERT INTO Registro VALUES (NULL, 64, '%', '2022-10-06 6:45:45', 3);
INSERT INTO Registro VALUES (NULL, 45, '%', '2022-10-06 6:46:0', 1);
INSERT INTO Registro VALUES (NULL, 10, '%', '2022-10-06 6:46:0', 2);
INSERT INTO Registro VALUES (NULL, 84, '%', '2022-10-06 6:46:0', 3);
INSERT INTO Registro VALUES (NULL, 19, '%', '2022-10-06 6:46:15', 1);
INSERT INTO Registro VALUES (NULL, 56, '%', '2022-10-06 6:46:15', 2);
INSERT INTO Registro VALUES (NULL, 97, '%', '2022-10-06 6:46:15', 3);
INSERT INTO Registro VALUES (NULL, 85, '%', '2022-10-06 6:46:30', 1);
INSERT INTO Registro VALUES (NULL, 64, '%', '2022-10-06 6:46:30', 2);
INSERT INTO Registro VALUES (NULL, 98, '%', '2022-10-06 6:46:30', 3);
INSERT INTO Registro VALUES (NULL, 44, '%', '2022-10-06 6:46:45', 1);
INSERT INTO Registro VALUES (NULL, 7, '%', '2022-10-06 6:46:45', 2);
INSERT INTO Registro VALUES (NULL, 93, '%', '2022-10-06 6:46:45', 3);
INSERT INTO Registro VALUES (NULL, 9, '%', '2022-10-06 6:47:0', 1);
INSERT INTO Registro VALUES (NULL, 57, '%', '2022-10-06 6:47:0', 2);
INSERT INTO Registro VALUES (NULL, 76, '%', '2022-10-06 6:47:0', 3);
INSERT INTO Registro VALUES (NULL, 46, '%', '2022-10-06 6:47:15', 1);
INSERT INTO Registro VALUES (NULL, 45, '%', '2022-10-06 6:47:15', 2);
INSERT INTO Registro VALUES (NULL, 59, '%', '2022-10-06 6:47:15', 3);
INSERT INTO Registro VALUES (NULL, 38, '%', '2022-10-06 6:47:30', 1);
INSERT INTO Registro VALUES (NULL, 28, '%', '2022-10-06 6:47:30', 2);
INSERT INTO Registro VALUES (NULL, 47, '%', '2022-10-06 6:47:30', 3);
INSERT INTO Registro VALUES (NULL, 79, '%', '2022-10-06 6:47:45', 1);
INSERT INTO Registro VALUES (NULL, 34, '%', '2022-10-06 6:47:45', 2);
INSERT INTO Registro VALUES (NULL, 68, '%', '2022-10-06 6:47:45', 3);
INSERT INTO Registro VALUES (NULL, 15, '%', '2022-10-06 6:48:0', 1);
INSERT INTO Registro VALUES (NULL, 5, '%', '2022-10-06 6:48:0', 2);
INSERT INTO Registro VALUES (NULL, 90, '%', '2022-10-06 6:48:0', 3);
INSERT INTO Registro VALUES (NULL, 36, '%', '2022-10-06 6:48:15', 1);
INSERT INTO Registro VALUES (NULL, 29, '%', '2022-10-06 6:48:15', 2);
INSERT INTO Registro VALUES (NULL, 76, '%', '2022-10-06 6:48:15', 3);
INSERT INTO Registro VALUES (NULL, 30, '%', '2022-10-06 6:48:30', 1);
INSERT INTO Registro VALUES (NULL, 31, '%', '2022-10-06 6:48:30', 2);
INSERT INTO Registro VALUES (NULL, 58, '%', '2022-10-06 6:48:30', 3);
INSERT INTO Registro VALUES (NULL, 8, '%', '2022-10-06 6:48:45', 1);
INSERT INTO Registro VALUES (NULL, 57, '%', '2022-10-06 6:48:45', 2);
INSERT INTO Registro VALUES (NULL, 15, '%', '2022-10-06 6:48:45', 3);
INSERT INTO Registro VALUES (NULL, 87, '%', '2022-10-06 6:49:0', 1);
INSERT INTO Registro VALUES (NULL, 24, '%', '2022-10-06 6:49:0', 2);
INSERT INTO Registro VALUES (NULL, 13, '%', '2022-10-06 6:49:0', 3);
INSERT INTO Registro VALUES (NULL, 56, '%', '2022-10-06 6:49:15', 1);
INSERT INTO Registro VALUES (NULL, 26, '%', '2022-10-06 6:49:15', 2);
INSERT INTO Registro VALUES (NULL, 23, '%', '2022-10-06 6:49:15', 3);
INSERT INTO Registro VALUES (NULL, 91, '%', '2022-10-06 6:49:30', 1);
INSERT INTO Registro VALUES (NULL, 21, '%', '2022-10-06 6:49:30', 2);
INSERT INTO Registro VALUES (NULL, 31, '%', '2022-10-06 6:49:30', 3);
INSERT INTO Registro VALUES (NULL, 79, '%', '2022-10-06 6:49:45', 1);
INSERT INTO Registro VALUES (NULL, 57, '%', '2022-10-06 6:49:45', 2);
INSERT INTO Registro VALUES (NULL, 20, '%', '2022-10-06 6:49:45', 3);


select * from vw_registros;
SELECT valor FROM vw_registros WHERE tipo = 'CPU' limit 0,5;




