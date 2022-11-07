
library(gganimate)
library(tidyverse)
library(readxl)
library(Boreluy)
library(opuy)
library(hrbrthemes)
library(extrafont)

#font_import()
#loadfonts(device = "win")

una <- opuy %>%
    filter(medicion == 'Intencion de voto',
             tipo_eleccion == 'Nacional',
             eleccion == 2019,
           sigla %in% c('FA', 'PC', 'PN', 'CA')) %>%
    arrange(empresa, fecha)


una$partido <- factor(una$partido)
una$partido <- factor(una$partido, levels = levels(una$partido)[c(2, 3, 4, 1)])

una <- una %>%
    group_by(partido) %>%
    mutate(minimo = min(valor, na.rm = TRUE),
           maximo = max(valor, na.rm = TRUE)) %>%
    ungroup()

franja <- distinct(una[, c('partido', 'minimo', 'maximo')])


g2 <-
    ggplot(una, aes(x = fecha, y = valor, color = empresa)) +
    geom_line(aes(group = empresa), size = 1, alpha = 0.6) +
    geom_point(size = 1.5) +
    geom_segment(aes(xend = fecha[length(fecha)], yend = valor, group = empresa),
                 linetype = 2, colour = 'grey') +
    geom_text(aes(x = fecha[length(fecha)], label = empresa), hjust = 0) +
    ylim(0, 60) +
    #scale_color_ipsum() +
    #scale_fill_ipsum() +
    facet_wrap(~partido, nrow = 1) + #, scales = "free") +
    geom_hline(aes(yintercept = minimo), franja, color = 'red', alpha = 1, linetype = "dotted") +
    geom_hline(aes(yintercept = maximo), franja, color = 'red', alpha = 1, linetype = "dotted") +
    guides(color = FALSE) +
    theme_ipsum_tw(grid="XY", axis="xy") +
    labs(x = "",
         y = "Porcentaje de votos",
         title = "Intención de voto en elecciones nacionales 2019",
         subtitle = '27 de octubre de 2019',
         caption = 'Fuente: Unidad de Métodos y Acceso a Datos (UMAD)') +
    theme(plot.title = element_text(size = 15),
          plot.subtitle = element_text(size = 12),
          axis.text.x = element_text(size = 10),
          plot.caption = element_text(size = 10, color = "grey40")) +
    transition_reveal(fecha) +
    coord_cartesian(clip = 'off') +
    enter_fade() +
    exit_shrink()

#animate(g2, duration = 25)
animate(g2, height = 500, width = 800, duration = 20)
anim_save("C:\\Users\\usuario\\Desktop\\R_packages\\opuy\\opuy\\man\\figures\\iv2019.gif")



# ADD text
e19  <- resultado_eleccion_uy(2019, 'Presidencial') %>%
    select(Partido, Porcentaje) %>%
    rename(partido = Partido)

una2 <- una %>%
    group_by(partido) %>%
    summarise(minimo = min(valor),
              maximo = max(valor)) %>%
    ungroup() %>%
    mutate(partido = as.character(partido)) %>%
    left_join(., e19, by = 'partido') %>%
    mutate(
        text = paste('Resultado...', Porcentaje)
    )
una2$partido <- factor(una2$partido)
una2$partido <- factor(una2$partido, levels = levels(una2$partido)[c(2, 3, 4, 1)])



## tabla
e19  <- resultado_eleccion_uy(2019, 'Presidencial') %>%
    select(Partido, Porcentaje)
tab <- opuy %>%
    filter(medicion == 'Intencion de voto',
           tipo_eleccion == 'Nacional',
           eleccion == 2019,
           sigla %in% c('FA', 'PC', 'PN', 'CA')) %>%
    group_by(partido) %>%
    summarise('Valor Mínimo' = min(valor),
              'Valor Máximo' = max(valor),
              'Valor Mínimo 2019' = min(valor[anio_medicion == 2019]),
              'Valor Máximo 2019' = max(valor[anio_medicion == 2019])) %>%
    ungroup() %>%
    rename(Partido = partido) %>%
    left_join(., e19, by = 'Partido') %>%
    arrange(-Porcentaje) %>%
    rename('Votacón real' = Porcentaje)

tab <- cbind(tab[,1], apply(tab[, -1], 2, function(x){paste0(x, "%")}))
tab



## agrupar categoria
library(opuy)
unique(opuy$categoria)


library(tidyverse)
data(opuy)


print(
opuy %>%
    filter(medicion == 'Evaluacion de gestion presidente',
           categoria_unificada == 3) %>%
    select(anio_gobierno, empresa, valor, presidente) %>%
    group_by(empresa, anio_gobierno, presidente) %>%
    summarise(promedio = mean(valor, na.rm = TRUE)) %>%
    ungroup() %>%
    na.omit() %>%
    arrange(presidente) %>%
    mutate(anio_gobierno = paste("Año", anio_gobierno))

    , n = 100)


opuy %>%
    filter(medicion == 'Evaluacion de gestion presidente',
           categoria_unificada == 3) %>%
    select(anio_medicion, empresa, valor, presidente) %>%
    group_by(empresa, anio_medicion, presidente) %>%
    summarise(promedio = mean(valor, na.rm = TRUE)) %>%
    ungroup() %>%
    na.omit() %>%
    arrange(presidente) %>%
    mutate(presidente = factor(presidente, levels = c("Lacalle", "Sanguinetti 2",
                                                      "Batlle", "Vazquez 1", "Mujica",
                                                      "Vazquez 2", "Lacalle Pou"))) %>%
    ggplot(aes(x = anio_medicion, y = promedio, color = empresa)) +
    geom_line(aes(group = empresa), size = 1, alpha = 0.6) +
    geom_point(size = 1.5) +
    facet_wrap(~presidente, nrow = 1) +
    theme_ipsum_tw(grid="XY", axis="xy") +
    labs(x = "Año de gobierno",
         y = "Porcentaje de aprobación",
         color = "",
         title = "Evaluacion de la gestión del presidente",
         subtitle = 'Serie historica con datos de todas las consultoras',
         caption = 'Fuente: Unidad de Métodos y Acceso a Datos (UMAD)')
