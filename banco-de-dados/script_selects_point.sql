USE bd_point;
SELECT * FROM Funcionario; 
select * from Maquina;
SELECT idMaquina, sistemaOperacional, Funcionario.idFuncionario, fkFuncionario FROM Maquina 
INNER JOIN Funcionario ON idFuncionario = fkFuncionario
WHERE idFuncionario = 1;


SELECT c.tipo, f.nome, f.idFuncionario 
FROM Componente as c
INNER JOIN Maquina as m 
ON m.idMaquina = c.fkMaquina
INNER JOIN Funcionario as f
ON m.fkFuncionario = f.idFuncionario
WHERE idMaquina = 1;


SELECT max(C.idComponente) FROM Componente C
INNER JOIN Maquina M ON M.idMaquina = C.fkMaquina
WHERE idMaquina = 1;


SELECT f.nome as "Nome Funcionario", t.telefone as "Telefone Funcionario", ed.rua as "Rua Funcionario", ep.nome as "Nome Empresa"
FROM Funcionario as f
INNER JOIN Telefone as t ON t.fkFuncionario = f.idFuncionario
INNER JOIN Empresa as ep ON f.fkEmpresa = ep.idEmpresa
INNER JOIN Endereco as ed ON ed.fkFuncionario = f.idFuncionario
AND ed.fkEmpresa = ep.idEmpresa;


SELECT idMaquina, sistemaOperacional FROM Maquina INNER JOIN Funcionario ON idFuncionario = fkFuncionario WHERE idFuncionario = 1;
	
SELECT *
FROM Funcionario F
INNER JOIN Maquina M ON M.fkFuncionario = F.idFuncionario
INNER JOIN Componente C ON C.fkMaquina = M.idMaquina;

SELECT idComponente, tipo as fk FROM Componente C INNER JOIN Maquina M ON 1 = C.fkMaquina;
DESC Atributo;

select * from atributo;
select * from componente;

INSERT INTO Atributo VALUES (null, "core", 6, "unidade", 3, 1);

SELECT * FROM Atributo where fkMaquina = 1; 
SELECT * FROM Funcionario;
DESC Funcionario;

INSERT INTO Empresa VALUES (null, "Google", "72839999999999", 1, "Legal");
INSERT INTO Funcionario VALUES (null, "Ivan", "33333333333", "123", "ivan@.com", "Gerente", "11992015423", null, 1);
INSERT INTO Funcionario VALUES (null, "Agda", "33332323333", "123", "agda@.com", "Gerente", "11992015423", 2, 1);

SELECT * FROM Registro;


SELECT max(valor) FROM Registro WHERE fkComponente = 3;

TRUNCATE TABLE Registro;

SELECT F.nome, M.nomeMaquina, R.valor, R.unidadeMedida, R.dataEhora
FROM Funcionario F
INNER JOIN Maquina M ON fkFuncionario = idFuncionario
INNER JOIN Componente C ON C.fkMaquina = M.idMaquina
INNER JOIN Registro R ON R.fkMaquina = M.idMaquina
AND R.fkComponente = C.idComponente
ORDER BY R.dataEhora DESC
LIMIT 10;

