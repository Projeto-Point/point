create database BDpoint;

use BDpoint;

create table empresa (
	idEmpresa int primary key auto_increment,
    nome varchar(45),
    cnpj char(14),
    descEmpresa varchar(45)
);

create table funcionario (
	idFuncionario int primary key auto_increment,
    nome varchar(45),
    cpf char(11),
    senha varchar(45),
    email varchar(45) unique,
    fkGestor int,
    fkEmpresa int,
    foreign key (fkGestor) references funcionario (idFuncionario),
    foreign key (fkEmpresa) references empresa (idEmpresa)
) auto_increment = 100;

create table telefone (
	idTelefone int primary key auto_increment,
    telefone char(11),
    fkFuncionario int,
    foreign key (fkFuncionario) references funcionario (idFuncionario)
);

create table endereco (
	idEndereco int primary key auto_increment,
    rua varchar(45),
    num int,
    bairro varchar(45),
    estado char(2),
    cidade char(2),
    pais varchar(45),
    fkFuncionario int,
    foreign key (fkFuncionario) references funcionario (idFuncionario),
    fkEmpresa int,
    foreign key (fkEmpresa) references empresa (idempresa)
);

create table dispositivo (
	idDispositivo int primary key auto_increment,
    modeloDispositivo varchar(45),
    fkFuncionario int,
    foreign key (fkFuncionario) references funcionario (idFuncionario)
) auto_increment = 1000;

create table dados (
	idDados int primary key auto_increment,
	fkDispositivo int,
    foreign key(fkDispositivo) references dispositivo (idDispositivo),
    usoCPU decimal (3,1),
    usoRAM decimal (3,1),
    usoDiscoLocal decimal (3,1),
    dataEhora datetime
);
INSERT INTO empresa values (null, 'C6 Bank', 11111111111111, 'Banco digital brasileiro'),
						   (null, 'VR', 22222222222222, 'Fornecedora de benefícios PAT'),
                           (null, 'Safra', 33333333333333, 'Banco brasileiro');
INSERT INTO funcionario values (null, 'Antônio', 11111111111, 123, 'antonio@gmail.com', null, 1),
							   (null, 'Augusto', 22222222222, 123, 'augusto@gmail.com', null, 2),
                               (null, 'José', 33333333333, 123, 'jose@gmail.com', null, 3),
                               (null, 'Maria', 44444444444, 123, 'maria@gmail.com', 100, 1),
                               (null, 'Leandro', 55555555555, 123, 'leandro@gmail.com', 101, 2),
                               (null, 'Luana', 66666666666, 123, 'luana@gmail.com', 102, 3);
INSERT INTO dispositivo values (null, 'PC', 103),
							   (null, 'Notebook', 105),
							   (null, 'PC', 104);							
# Leandro, Maria, Luana
truncate dados;
select * from empresa;
select * from dados;
select * from funcionario;
select * from dispositivo;
drop database BDpoint;