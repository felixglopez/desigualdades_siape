library(readxl)
library(tidyverse)

# ler arquivo
siape_gini <- read_excel("siape_mgi_cargos_ipea_totais_gini_2022_a_2025.xlsx")

# gráfico de barras: coeficiente de Gini por classificação IPEA em 2025
ggplot(
    siape_gini %>% filter(ano == 2025),
    aes(
        x = reorder(classificacao_ipea2026, `coeficiênte_gêni`),
        y = `coeficiênte_gêni`
    )
) +
    geom_col(fill = "steelblue") +
    coord_flip() +
    labs(
        title = "Coeficiente de Gini por Classificação IPEA (2025)",
        x = "Classificação IPEA",
        y = "Coeficiente de Gini"
    ) +
    theme_minimal(base_size = 12)


#comparando 2022 e 2025
r id="s3qk9m"
library(readxl)
library(dplyr)
library(ggplot2)

# ler arquivo
# gráfico comparando 2022 e 2025, excluindo "altos dirigentes"
ggplot(
    siape_gini %>% 
        filter(
            ano %in% c(2022, 2025),
            classificacao_ipea2026 != "Altos Dirigêntes"
        ),
    aes(
        x = reorder(classificacao_ipea2026, `coeficiênte_gêni`),
        y = `coeficiênte_gêni`,
        fill = factor(ano)
    )
) +
    geom_col(position = "dodge") +
    coord_flip() +
    labs(
        title = "Coeficiente de Gini por Classificação IPEA (2022 vs 2025)",
        subtitle = "Exclui Altos Dirigentes",
        x = "Classificação IPEA",
        y = "Coeficiente de Gini",
        fill = "Ano"
    ) +
    scale_fill_manual(values = c("2022" = "gray60", "2025" = "steelblue")) +
    theme_minimal(base_size = 12)


# calcular coeficiente de Gini médio entre grupos
gini_medio_grupos <- siape_gini %>%
    filter(ano %in% c(2022, 2025),
      classificacao_ipea2026 != "Altos Dirigêntes") %>%
    group_by(ano) %>%
    summarise(
        gini_medio_entre_grupos = mean(`coeficiênte_gêni`, na.rm = TRUE),
        n_grupos = n()
    )

gini_medio_grupos


# tabela com gini 2022, gini 2025 e diferenças
    tabela_diferencas <- siape_gini %>%
    filter(ano %in% c(2022, 2025)) %>%
    select(classificacao_ipea2026, ano, `coeficiênte_gêni`) %>%
    pivot_wider(
        names_from = ano,
        values_from = `coeficiênte_gêni`,
        names_prefix = "gini_"
    ) %>%
    mutate(
        diferenca_absoluta = gini_2025 - gini_2022,
        diferenca_percentual = ((gini_2025 - gini_2022) / gini_2022) * 100
    ) %>%
    arrange(desc(diferenca_absoluta))

print(tabela_diferencas, n = 21)




library(dplyr)
library(tidyr)
library(scales)
library(knitr)

# tabela pronta para copiar e colar no Google Docs
tabela_diferencas <- siape_gini %>%
    filter(ano %in% c(2022, 2025)) %>%
    select(classificacao_ipea2026, ano, `coeficiênte_gêni`) %>%
    pivot_wider(
        names_from = ano,
        values_from = `coeficiênte_gêni`,
        names_prefix = "gini_"
    ) %>%
    mutate(
        diferenca_absoluta   = gini_2025 - gini_2022,
        diferenca_percentual = (diferenca_absoluta / gini_2022) * 100
    ) %>%
    arrange(desc(diferenca_absoluta)) %>%
    mutate(
        gini_2022            = number(gini_2022, accuracy = 0.001, decimal.mark = ","),
        gini_2025            = number(gini_2025, accuracy = 0.001, decimal.mark = ","),
        diferenca_absoluta   = number(diferenca_absoluta, accuracy = 0.001, decimal.mark = ","),
        diferenca_percentual = percent(diferenca_percentual / 100, accuracy = 0.1, 
                                       decimal.mark = ",")
    ) %>%
    rename(
        `Classificação IPEA` = classificacao_ipea2026,
        `Gini 2022` = gini_2022,
        `Gini 2025` = gini_2025,
        `Diferença Absoluta` = diferenca_absoluta,
        `Diferença %` = diferenca_percentual
    )

# copiar e colar no Google Docs
kable(
    tabela_diferencas,
    format = "pipe",
    align = c("l", "c", "c", "c", "c")
)

