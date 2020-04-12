
<!-- README.md is generated from README.Rmd. Please edit that file -->

# opuy

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
str(opuy)
#> Classes 'tbl_df', 'tbl' and 'data.frame':    4788 obs. of  12 variables:
#>  $ medicion     : chr  "Evaluacion de gestion presidente" "Evaluacion de gestion presidente" "Evaluacion de gestion presidente" "Evaluacion de gestion presidente" ...
#>  $ empresa      : chr  "Cifra" "Cifra" "Cifra" "Cifra" ...
#>  $ tipo_eleccion: chr  NA NA NA NA ...
#>  $ anio_medicion: num  2000 2000 2000 2000 2000 ...
#>  $ eleccion     : num  NA NA NA NA NA NA NA NA NA NA ...
#>  $ fecha        : POSIXct, format: "2000-06-25" "2000-06-25" ...
#>  $ partido      : chr  "Partido Colorado" "Partido Colorado" "Partido Colorado" "Partido Colorado" ...
#>  $ sigla        : chr  "PC" "PC" "PC" "PC" ...
#>  $ candidato    : chr  NA NA NA NA ...
#>  $ presidente   : chr  "Batlle" "Batlle" "Batlle" "Batlle" ...
#>  $ categoria    : chr  "Aprueba" "Ni aprueba ni desaprueba" "Desaprueba" "No sabe o no contesta" ...
#>  $ valor        : num  54 17 23 6 39 25 31 5 67 19 ...
```

``` r

library(tidyverse)
data(opuy)

opuy %>%
    filter(medicion == 'Intencion de voto',
           tipo_eleccion == 'Nacional',
           eleccion == 2019,
           sigla %in% c('FA', 'PC', 'PN', 'CA')) %>%
    ggplot(aes(x = fecha, y = valor, color = empresa)) +
    geom_line(aes(group = empresa), size = 1, alpha = 0.6) +
    geom_point(size = 1.5) +
    ylim(0, 60) +
    facet_wrap(~partido, nrow = 1) +
    theme_minimal() +
    labs(x = "", y = "", title = "")
```

<img src='man/figures/iv2019.gif'/>

##### Resumen intención de voto 2019 de los principales partidos

| Partido          | Valor Mínimo | Valor Máximo | Valor Mínimo 2019 | Valor Máximo 2019 | Votación real |
| :--------------- | :----------- | :----------- | :---------------- | :---------------- | :------------ |
| Frente Amplio    | 24%          | 43%          | 27%               | 43%               | 39.26%        |
| Partido Nacional | 21.6%        | 34%          | 21.6%             | 33%               | 28.8%         |
| Partido Colorado | 3%           | 22%          | 9%                | 22%               | 12.41%        |
| Cabildo Abierto  | 1%           | 12%          | 1%                | 12%               | 11.11%        |

-----

##### Mantenedor

Nicolás Schmidt (<nschmidt@cienciassociales.edu.uy>)
