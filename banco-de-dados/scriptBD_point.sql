create database BDpoint;

use BDpoint;

create table funcionario (
	idFuncionario int primary key auto_increment,
    nome varchar(45),
    cpf char(11),
    senha varchar(45),
    email varchar(45),
    fkGestor int,
    foreign key (fkGestor) references funcionario (idFuncionario)
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
    foreign key (fkFuncionario) references funcionario (idFuncionario)
);

create table dispositivo (
	idDispositivo int primary key auto_increment,
    modeloDispositivo varchar(45),
    fkFuncionario int,
    foreign key (fkFuncionario) references funcionario (idFuncionario)
) auto_increment = 1000;

create table dados (
	fkDispositivo int,
    foreign key(fkDispositivo) references dispositivo (idDispositivo),
    idDados int,
	primary key(fkDispositivo, idDados),
    usoCPU decimal (3,2),
    usoGPU decimal (3,2),
    usoRAM decimal (3,2),
    usodiscoLocal decimal (3,2)
);
