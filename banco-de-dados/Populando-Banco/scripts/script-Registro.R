set.seed(123)

registro <- data.frame(fkMaquina = 1,
                       fkComponte = 3,
                       dataEhora = seq(as.Date("2022/1/1"), as.Date("2022/10/14"), by = "day"),
                       valor = seq(78.9, 90.9, length.out = 287),
                       unidadeDeMedida = "%"
)
write.csv(registro,"C:\\Users\\ivanm\\OneDrive\\Documentos\\SPTECH\\Projeto-Point-Sprint\\point\\banco-de-dados\\Populando-Banco\\base-de-dados\\tabela-registro-disco.csv", row.names = FALSE)


x <- as.Date("2022/1/1")
y <- as.Date("2022/10/14")