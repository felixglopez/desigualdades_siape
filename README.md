# desigualdades_siape

Repositório com análise exploratória das desigualdades remuneratórias no Executivo Civil Federal brasileiro, a partir de dados agregados do SIAPE para os anos de 2022 a 2025.

O foco principal é comparar medidas de desigualdade entre grupos ocupacionais classificados pela tipologia `classificacao_ipea2026`, com destaque para o coeficiente de Gini e indicadores derivados de remuneração e rendimento.

## Conteúdo

- `siape_gini.Rmd`: relatório principal em RMarkdown, com leitura da base, diagnóstico das colunas, tabelas, gráficos e interpretação dos resultados.
- `siape_gini.html`: versão renderizada em HTML do relatório.
- `siape_gini.docx`: versão renderizada em Word do relatório.
- `siape_gini.R`: script exploratório com gráficos e tabelas preliminares.
- `siape_mgi_cargos_ipea_totais_gini_2022_a_2025.xlsx`: base principal usada no relatório.
- `aux_siape_mgi_cargos_ipea_totais_orgaos_2026.xlsx`: base auxiliar.
- `desigualdades_siape.Rproj`: projeto RStudio.

## Objetivo da análise

O relatório investiga como a desigualdade remuneratória varia:

- entre anos, de 2022 a 2025;
- entre grupos ocupacionais;
- dentro dos grupos, por meio do coeficiente de Gini;
- entre faixas da distribuição, usando quartis, medianas, máximos e razões como `P75/P25` e `Max/P25`;
- em relação ao tamanho dos grupos, medido por vínculos e servidores.

## Principais indicadores

O relatório calcula e apresenta, entre outros:

- coeficiente médio de Gini por ano;
- Gini por grupo ocupacional em 2025;
- comparação do Gini entre 2022 e 2025;
- diferenças absolutas e percentuais entre anos;
- intervalos interquartis de rendimento e remuneração;
- razões entre topo, mediana e base da distribuição;
- tabelas comparativas por grupo ocupacional;
- gráficos de barras, linhas, dispersão e boxplots construídos a partir de estatísticas agregadas.

## Requisitos

O projeto usa R e os seguintes pacotes:

```r
readxl
dplyr
tidyr
ggplot2
janitor
stringr
scales
knitr
forcats
broom
```

Para instalar os pacotes necessários:

```r
install.packages(c(
  "readxl",
  "dplyr",
  "tidyr",
  "ggplot2",
  "janitor",
  "stringr",
  "scales",
  "knitr",
  "forcats",
  "broom"
))
```

## Como executar

Abra o projeto no RStudio usando o arquivo:

```text
desigualdades_siape.Rproj
```

Depois, abra `siape_gini.Rmd` e renderize o relatório para HTML ou Word.

Também é possível renderizar pela linha de comando, a partir da raiz do repositório:

```r
rmarkdown::render("siape_gini.Rmd")
```

## Estrutura esperada da base

A base principal deve conter, entre outras, as seguintes colunas:

- `ano`
- `mes`
- `classificacao_ipea2026`
- `coeficiênte_gêni`
- `servidores`
- `vinculos`
- `qtde_cargos`
- `media_vr_rendim`
- `perc25_vr_rendim`
- `perc50_vr_rendim`
- `perc75_vr_rendim`
- `maximo_vr_rendim`
- `media_vr_remun`
- `perc25_vr_remun`
- `perc50_vr_remun`
- `perc75_vr_remun`
- `maximo_vr_remun`

No relatório, os nomes das colunas são padronizados com `janitor::clean_names()` e o coeficiente de Gini é renomeado internamente para `gini`.

## Observações metodológicas

- O coeficiente de Gini é usado como indicador de desigualdade interna dos grupos ocupacionais.
- As comparações entre 2022 e 2025 permitem observar mudanças na desigualdade ao longo do período.
- Os indicadores baseados em quartis ajudam a distinguir desigualdade difusa de concentração no topo.
- Alguns gráficos tipo boxplot são construídos a partir de estatísticas agregadas da base, não de microdados individuais.

## Observações sobre os dados

A base usa algumas grafias acentuadas incomuns, como `coeficiênte_gêni` e `Altos Dirigêntes`. Por isso, o relatório principal procura padronizar os nomes das colunas antes da análise. Ao atualizar a base, recomenda-se conferir a seção de diagnóstico de colunas gerada pelo próprio relatório.

## Saídas

As principais saídas do projeto são:

- relatório HTML navegável com sumário;
- relatório Word para edição e circulação;
- tabelas de comparação entre grupos e anos;
- gráficos para interpretação da desigualdade remuneratória.

