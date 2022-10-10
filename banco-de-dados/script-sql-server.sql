use [bd-point];

create table Empresa (
	idEmpresa int primary key identity(1,1),
    nome varchar(45) not null,
    cnpj char(14) unique not null,
    plano int,
    descEmpresa varchar(45),
    constraint tipo_plano check (plano >= 1 and plano <= 3)
);

create table Funcionario (
	idFuncionario int primary key identity(1,1),
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
	idTelefone int primary key identity(1,1),
    telefone char(11),
    fkFuncionario int,
    foreign key (fkFuncionario) references funcionario (idFuncionario)
);

create table Endereco (
	idEndereco int primary key identity(1,1),
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
    idMaquina int primary key identity(1,1),
    sistemaOperacional varchar(45) not null,
    nomeMaquina varchar(45),
    fkfuncionario int,
    foreign key (fkFuncionario) references funcionario (idFuncionario)
);

create table Componente(
    idComponente int primary key identity(1,1),
    tipo varchar(50),
    fkMaquina int,
    foreign key (fkMaquina) references maquina (idMaquina)
);

create table Atributo(
    idAtributo int primary key identity(1,1),
    atributo varchar(50),
    valor decimal(6,2),
    unidadeMedida varchar(30),
    fkComponente int,
    foreign key (fkComponente) references componente (idComponente)
);

create table Registro(
    idRegistro int primary key IDENTITY(1,1),
    valor decimal(6,2),
    unidadeMedida varchar(5),
    dataEhora datetime,
    fkComponente int,
    foreign key (fkComponente) references componente (idComponente)
);

GO
-- Views
CREATE VIEW vw_componentes AS
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


SELECT * FROM vw_componentes;

GO

CREATE VIEW vw_registros AS
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


SELECT * FROM vw_registros;