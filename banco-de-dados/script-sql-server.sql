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
    cargo varchar (45) not null default 'Gestor',
    telefone char(11),
    fkGestor int,
    fkEmpresa int,
    foreign key (fkGestor) references funcionario (idFuncionario),
    foreign key (fkEmpresa) references empresa (idEmpresa)
);


-- create table Endereco (
-- 	idEndereco int primary key identity(1,1),
--     rua varchar(45),
--     num int,
--     bairro varchar(45),
--     cidade VARCHAR(45) not null,
--     estado char(2) not null,
--     pais varchar(45) not null,
--     fkFuncionario int,
--     foreign key (fkFuncionario) references funcionario (idFuncionario),
--     fkEmpresa int,
--     foreign key (fkEmpresa) references empresa (idempresa)
-- );

create table Maquina (
    idMaquina int primary key identity(1,1),
    sistemaOperacional varchar(45) not null,
    nomeMaquina varchar(45),
    tipo VARCHAR(30),
    fkfuncionario int,
    foreign key (fkFuncionario) references funcionario (idFuncionario)
);

create table Componente(
    idComponente int,
    tipo varchar(50),
    fkMaquina int,
    foreign key (fkMaquina) references maquina (idMaquina),
    primary key(idComponente, fkMaquina)
);

create table Atributo(
    idAtributo int primary key identity(1,1),
    atributo varchar(50),
    valor decimal(6,2),
    unidadeMedida varchar(30),
    fkComponente int,
    fkMaquina INT,
    foreign key (fkComponente, fkMaquina) references componente (idComponente, fkMaquina)
);

create table Registro(
    fkMaquina int,
    fkComponente int,
    dataEhora datetime,
    valor decimal(6,2),
    unidadeMedida VARCHAR(5),
    foreign key (fkComponente, fkMaquina) references componente (idComponente, fkMaquina)
   
);

GO

CREATE VIEW "vw_componentes" AS
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

GO

CREATE VIEW "vw_registros" AS
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

CREATE VIEW "vw_infoMaquina" AS
SELECT idMaquina, nomeMaquina, sistemaOperacional, M.tipo AS 'tipoMaquina',
	   C.tipo AS 'tipoComponente',
       atributo, valor, unidadeMedida
FROM Maquina M
INNER JOIN Componente C ON C.fkMaquina = idMaquina
INNER JOIN Atributo ON idComponente = fkComponente;

-- Insert 

INSERT INTO dbo.Empresa (nome, cnpj, plano, descEmpresa) VALUES ('Itau', '12345678901232', 1, 'Banco brasileiro');
INSERT INTO dbo.Empresa (nome, cnpj, plano, descEmpresa) VALUES ('VR', '24545675108032', 2, 'Fornecedora de benefícios PAT');
INSERT INTO dbo.Empresa (nome, cnpj, plano, descEmpresa) VALUES ('Banco Caixa', '79905654108012', 2, 'Banco Mercado Empresarial');

INSERT INTO dbo.Funcionario (nome, cpf, senha, email, cargo, telefone, fkGestor,fkEmpresa) values ('Fabio', '34578890212', '123', 'fabio@gmail.com','gestor','12345678922',1,1);
INSERT INTO dbo.Funcionario (nome, cpf, senha, email, cargo, telefone, fkGestor,fkEmpresa) values ('Caio', '90573590267', '121', 'caio@gmail.com','analista','81342878945',1,1);
INSERT INTO dbo.Funcionario (nome, cpf, senha, email, cargo, telefone, fkGestor,fkEmpresa) values ('Marcelo', '73565590202', '133', 'marcelo@gmail.com','desenvovedor','47342248912',1,1);

