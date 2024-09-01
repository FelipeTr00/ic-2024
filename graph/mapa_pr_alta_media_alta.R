# Instala os pacotes necessários (se ainda não estiverem instalados)
pacman::p_load(geobr, ggplot2, dplyr, sf, patchwork)

#WD
# setwd("D:/felipe/ic")
setwd("D:/ic/ic-2024")

#Read CSV
indicador <- read.csv("database/indicador.csv")

glimpse(indicador)

# Carrega os dados geográficos dos municípios do Paraná
municipios_pr <- read_municipality(code_muni = "PR", year = 2020)

# Join Indicador

municipios_pr <- municipios_pr %>%
  left_join(indicador, by = c("code_muni" = "cod_municipio"))


# Carrega os dados geográficos das mesorregiões do Paraná
regioes_pr <- read_meso_region(code_meso = "PR", year = 2020)

# Se as mesorregiões não funcionarem, tente usar `read_region`:
# regioes_pr <- read_region(code_region = "PR", year = 2020, level = "meso")


# Mapa Alta Intensidade Quantitativo
ggplot() +
  geom_sf(data = municipios_pr, aes(fill = alta_qtd), color = "darkgrey", size = 0.3) + # Preenche os municípios com base no indicador
  geom_sf(data = regioes_pr, fill = NA, color = "black", size = 0.8) + # Divisas das regiões
  scale_fill_viridis_c(option = "magma", direction = -1) + # Escala de cores para o indicador
  theme_minimal() +
  labs(title = "Alta Intensidade Tecnológica por Município, Paraná – 2022",
       fill = "Quantidade de empresas \ncom alto índice de \nIntensidade Tecnológica",
       caption = "Fonte: geobr, RAIS, IPARDES (2022).")

# Mapa Alta Intensidade Per Capita (1.000 hab.)
ggplot() +
  geom_sf(data = municipios_pr, aes(fill = alta_indic), color = "darkgrey", size = 0.3) + # Preenche os municípios com base no indicador
  geom_sf(data = regioes_pr, fill = NA, color = "black", size = 0.8) + # Divisas das regiões
  scale_fill_viridis_c(option = "magma", direction = -1) + # Escala de cores para o indicador
  theme_minimal() +
  labs(title = "Índicador Per Capita de Alta Intensidade Tecnológica por Município, Paraná – 2022",
       fill = "Indicador per capita \nempresas com alto índice de \nIntensidade Tecnológica \n por 1.000 hab.",
       caption = "Fonte: geobr, RAIS, IPARDES (2022).")

# Color scales: “viridis”, “magma”, “plasma”, “inferno”, “civids”, “mako”, “rocket”, “turbo”.

glimpse(municipios_pr)
