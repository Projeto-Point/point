set.seed(1234)
nomeMarca < -marcas$Marca

cnpj = sample(14805473000117:44602859000146, size = length(nomeMarca), replace = FALSE)


for(i in 1:100){
  cnpj[i] <- toString(cnpj[i])
}

empresa <- data.frame (idEmpresa = c(1:length(nomeMarca)),
                       nome = nomeMarca,
                       cnpj = cnpj,
                       descEmpresa = "Sou uma empresa legal")
