set.seed(1234)

# Colocando dados dos arquivos em variáveis
pop.nomeF <- ibge.fem.10000
pop.nomeM <- ibge.mas.10000

# Pegando uma amostra aleatória de cada arquivo
nomeF <- pop.nomeF$nome[sample(1:800)]
nomeM <- pop.nomeM$nome[sample(1:600)]

# Juntando todos os nomes em um só vetor
todosNomes <- c(nomeF, nomeM)

# Embaralhando nomes de maneira aleatória para não ficar todas as mulheres depois todos os homens
mixed_data <- todosNomes[sample(1:length(todosNomes))]

# Criando o dataframe funcionário (tipo a tabela funcionario)
funcionario <- data.frame(idFuncionario = c(1:length(mixed_data)),
                          nome = mixed_data,
                          cpf= sample(x = 11568654081:91628095032, size = length(mixed_data), replace = FALSE),
                          senha = 123,
                          email = "nome@empresa.com",
                          fkGestor = sample(1:length(mixed_data), size = length(mixed_data), replace = TRUE),
                          fkEmpresa = sample(1:100, size = length(mixed_data), replace = TRUE)
                          )
