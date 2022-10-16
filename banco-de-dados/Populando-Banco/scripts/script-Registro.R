set.seed(123)

registro <- data.frame(fkMaquina = 1,
                       fkComponte = 2,
                       dataEhora = seq(as.Date("2022/1/1"), as.Date("2022/10/14"), by = "day"),
                       valor = sample(x = (34.40:89.30), 287, TRUE),
                       unidadeDeMedida = "%"
                       )
write.csv(registro,"C:\\Users\\corin\\OneDrive\\Área de Trabalho\\point\\point\\banco-de-dados\\Populando-Banco\\scripts\\script-registro-RAM.csv", row.names = FALSE)


x <- as.Date("2022/1/1")
y <- as.Date("2022/10/14")

y-x