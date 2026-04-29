library(readxl)
library(dplyr)
library(ggplot2)
library(forcats)
library(scales)
library(janitor)

# Ler base auxiliar de totais por area de atuacao dos orgaos
siape_novo <- read_excel("aux_siape_mgi_cargos_ipea_totais_orgaos_2026.xlsx") %>%
  clean_names()

# Garantir nomes de variaveis em minusculas e sem espacos
names(siape_novo) <- names(siape_novo) %>%
  tolower() %>%
  gsub("\\s+", "_", x = .)

# Conferir estrutura final
glimpse(siape_novo)

# Grafico: numero de vinculos por area de atuacao
siape_novo %>%
  group_by(area_atuacao) %>%
  summarise(
    total_vinculos = sum(vinculos, na.rm = TRUE),
    .groups = "drop"
  ) %>%
  ggplot(aes(
    x = fct_reorder(area_atuacao, total_vinculos),
    y = total_vinculos
  )) +
  geom_col(fill = "steelblue", alpha = 0.85) +
  geom_text(
    aes(label = comma(total_vinculos, big.mark = ".")),
    hjust = -0.1,
    size = 3.5
  ) +
  coord_flip() +
  scale_y_continuous(
    labels = comma_format(big.mark = "."),
    expand = expansion(mult = c(0, 0.12))
  ) +
  labs(
    title = "Numero de vinculos por area de atuacao",
    x = NULL,
    y = "Numero de vinculos"
  ) +
  theme_minimal(base_size = 12)

# Grafico: coeficiente de Gini por area de atuacao em 2022 e 2025
siape_novo %>%
  filter(ano %in% c(2022, 2025)) %>%
  ggplot(aes(
    x = fct_reorder(area_atuacao, coeficiente_gini),
    y = coeficiente_gini,
    fill = factor(ano)
  )) +
  geom_col(position = "dodge", alpha = 0.9) +
  coord_flip() +
  scale_fill_manual(
    values = c("2022" = "gray60", "2025" = "steelblue")
  ) +
  scale_y_continuous(
    labels = number_format(accuracy = 0.01, decimal.mark = ",")
  ) +
  labs(
    title = "Coeficiente de Gini por area de atuacao",
    subtitle = "Comparacao entre 2022 e 2025",
    x = NULL,
    y = "Coeficiente de Gini",
    fill = "Ano"
  ) +
  theme_minimal(base_size = 12)

# Grafico: quantidade de cargos por area de atuacao em 2025
siape_novo %>%
  filter(ano == 2025) %>%
  ggplot(aes(
    x = fct_reorder(area_atuacao, qtde_cargos),
    y = qtde_cargos
  )) +
  geom_col(fill = "darkseagreen4", alpha = 0.85) +
  geom_text(
    aes(label = comma(qtde_cargos, big.mark = ".")),
    hjust = -0.1,
    size = 3.5
  ) +
  coord_flip() +
  scale_y_continuous(
    labels = comma_format(big.mark = "."),
    expand = expansion(mult = c(0, 0.12))
  ) +
  labs(
    title = "Quantidade de cargos por area de atuacao",
    subtitle = "Ano de 2025",
    x = NULL,
    y = "Quantidade de cargos"
  ) +
  theme_minimal(base_size = 12)
