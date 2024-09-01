# Instala e carrega pacotes necessários
if (!require("RSQLite")) install.packages("RSQLite", dependencies=TRUE)
if (!require("dplyr")) install.packages("dplyr", dependencies=TRUE)

library(RSQLite)
library(dplyr)

# Caminho para o arquivo SQLite
db_path <- "caminho/para/seu/banco_de_dados.sqlite"

# Conecta ao banco de dados SQLite
con <- dbConnect(SQLite(), db_path)

# Lê os dados do CSV para o dataframe
data <- read.csv("caminho/para/arquivo.csv", stringsAsFactors = FALSE)

# Cria dataframes separados para cada tabela

# Tabela de município
municipio_data <- data %>%
  distinct(id_municipio, sigla_uf, sigla_uf_nome, id_municipio_nome) %>%
  mutate(populacao = NA)  # Substitua NA pela população, se disponível

# Tabela de CNAE
cnae_data <- data %>%
  distinct(cnae_1, cnae_1_descricao, cnae_1_descricao_grupo, cnae_1_descricao_divisao, cnae_1_descricao_secao, subsetor_ibge)

# Tabela RAIS
rais_data <- data %>%
  select(ano, id_municipio, quantidade_vinculos_ativos, quantidade_vinculos_clt, quantidade_vinculos_estatutarios,
         tamanho_estabelecimento, tipo_estabelecimento, indicador_simples, indicador_atividade_ano, cnae_1)

# Insere dados na tabela municipio
dbWriteTable(con, "municipio", municipio_data, append = TRUE, row.names = FALSE)

# Insere dados na tabela cnae
dbWriteTable(con, "cnae", cnae_data, append = TRUE, row.names = FALSE)

# Insere dados na tabela rais
dbWriteTable(con, "rais", rais_data, append = TRUE, row.names = FALSE)

# Fecha a conexão com o banco de dados
dbDisconnect(con)
