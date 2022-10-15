INSERT INTO Empresa VALUES (NULL, 'Banco Safra', '12345678912345', 1, 'Somos um banco, queremos dinheiro!');
INSERT INTO Funcionario VALUES (NULL, 'Ivan Miranda', '12345698545', '1234', 'ivan@miranda.com', NULL, NULL, 1);
INSERT INTO Funcionario VALUES (NULL, 'Gabriel Yuuzu', '12345698542', '12345', 'gabriel@yuuzu.com', 'Programador Back-end', 1, 1);
INSERT INTO Funcionario VALUES (NULL, 'Alessandra Baccin', '12345698543', '123456', 'alee@baccin.com.br', 'Programadora Front-end', 1, 1);
INSERT INTO Funcionario VALUES (NULL, 'Grossi Felipe', '12345698540', 'abd3S!s', 'grozi@felipe.com', 'Analista de dados', 1, 1);
INSERT INTO Endereco VALUES (NULL, 'Rua A', 23, 'Bairro XYV', 'São Paulo', 'SP', 'Brazil', 1, 1);
INSERT INTO Endereco VALUES (NULL, 'Rua B', 85, 'Bairro XYZ', 'São Paulo', 'SP', 'Brazil', 2, 1);
INSERT INTO Endereco VALUES (NULL, 'Rua C', 15, 'Bairro XYA', 'São Paulo', 'SP', 'Brazil', 3, 1);
INSERT INTO Endereco VALUES (NULL, 'Rua D', 835, 'Bairro XYZ', 'São Paulo', 'SP', 'Brazil', 4, 1);
INSERT INTO Maquina VALUES (NULL, 'Windows 11', 'Yuuzu Machine', 'desktop', 2);
INSERT INTO Maquina VALUES (NULL, 'Windows 11', 'Baccin Machine', 'desktop', 3);
INSERT INTO Maquina VALUES (NULL, 'Ubuntu Server 20.01', 'Maquina do Grossi', 'servidor', 4);
INSERT INTO Componente VALUES (1, 1, 'CPU');
INSERT INTO Atributo VALUES (NULL, 'núcleos', 4, 'unidade', 1, 1);
INSERT INTO Componente VALUES (2, 1, 'RAM');
INSERT INTO Alerta VALUES (NULL, NOW(), 'CPU - 80% DE USO', 'em aberto', 'https://www.google.com', 1)
INSERT INTO Alerta VALUES (NULL, NOW(), 'RAM - 90% DE USO', 'em aberto', 'https://www.google.com', 1)
INSERT INTO Alerta VALUES (NULL, NOW(), 'CPU - 98% DE DISCO', 'em aberto', 'https://www.google.com', 1)