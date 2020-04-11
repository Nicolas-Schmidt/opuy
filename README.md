
<!-- README.md is generated from README.Rmd. Please edit that file -->

# opuy

*Nicolás Schmidt, Daniela Vairo*

<!-- badges: start -->

[![Project Status: Active – The project has reached a stable, usable
state and is being actively
developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)
[![Travis build
status](https://travis-ci.com/Nicolas-Schmidt/opuy.svg?branch=master)](https://travis-ci.com/Nicolas-Schmidt/opuy)
<!-- badges: end -->

> Datos de opinón pública de Uruguay 1989 - 2020.

### Descripción

Provee un conjunto de datos de opinión publica en Uruguay en el periodo
que va desde 1989 hasta 2020. Asimismo, también se pueden obtener
resúmenes agregados por año, por elección, por consultora o por
indicador.

El manual del paquete se puede encontrar
[**aquí**](https://github.com/Nicolas-Schmidt/Boreluy/blob/master/man/figures/Manual_opuy.pdf).

### Instalación

``` r
## Versión en desarrollo
source("https://install-github.me/Nicolas-Schmidt/opuy")
```

### Contenido del paquete

#### Conjuntos de datos

| Función | Descripción |
| ------- | ----------- |
| `opuy`  | ….          |

#### Ejemplo

``` r
library(opuy)
library(tidyverse)

opuy %>%
    filter(medicion == 'Intencion de voto',
           tipo_eleccion == 'Nacional',
           eleccion == 2019,
           sigla %in% c('FA', 'PC', 'PN', 'CA')) %>%
    ggplot(aes(x = fecha, y = valor, color = empresa)) +
    geom_line(aes(group = empresa), size = 1, alpha = 0.6) +
    geom_point(size = 1.5) +
    ylim(0, 60) +
    facet_wrap(~partido, nrow = 1, scales = "free") +
    theme_minimal() +
    labs(x = "", y = "", title = "")
```

<img src='man/figures/iv2019.gif'/>