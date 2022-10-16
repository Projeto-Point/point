set.seed(123)

registro <- data.frame(fkMaquina = 1,
                       fkComponte = 1,
                       dataEhora = seq(as.Date("2022/1/1"), as.Date("2022/10/14"), by = "day"),
                       valor = sample(x = (5.50:90.90), 287, TRUE),
                       unidadeDeMedida = "%"
                       
                       )



x <- as.Date("2022/1/1")
y <- as.Date("2022/10/14")

y-x
