
library(tidyverse)
library(opuy)
library(Boreluy)
library(hrbrthemes)
library(patchwork)

e19 <- nacional_uy(2019) %>% agrupar_partidos_uy()


e192 <- tibble(
    fecha = as.Date("2019-11-30"),
    partido = e19$Partido,
    resultado = e19$Porcentaje
) %>% filter(partido %in% c("Frente Amplio", "Partido Nacional", "Partido Colorado"))


op <- opuy %>%
    filter(medicion == "Intencion de voto",
           tipo_eleccion == "Nacional",
           empresa == "Equipos",
           eleccion == 2019,
           partido %in% c("Frente Amplio", "Partido Nacional", "Partido Colorado"))

## c("Frente Amplio", "Partido Nacional", "Partido Colorado")

margen <- op[which(op$fecha == max(op$fecha)),] %>%
    select(partido, valor) %>%
    filter(partido %in% c("Frente Amplio", "Partido Nacional", "Partido Colorado")) %>%
    left_join(., e192, "partido")


ggplot(op, aes(x = fecha, y = valor)) +
    facet_wrap(~partido, nrow = 1) +
    geom_segment(aes(x = fecha,
                     y = 5,
                     xend = fecha,
                     yend = resultado),
                 data = e192, size = 1, color = "red") +
    geom_rect(data = margen, aes(xmin = as.Date("2015-08-01"),
                                 xmax = as.Date("2019-11-30"),
                                 ymin = valor,
                                 ymax = resultado),
              fill = "gray", alpha = 0.7) +
    geom_line()+
    geom_point() +
    geom_point(data = margen, aes(x = fecha, y = resultado),
               color = "red", shape = 16, size = 3) +

    #annotate("text", x = 2:5, y = 25, label = "Some text") +
    ylim(5, 50) +
    labs(x = "", y = "",
             title = "",
             subtitle = "",
             group = "") +
        #ylim(0.3, 1) +
        #theme_minimal() +
        theme_ipsum() +
        theme(panel.grid = element_blank(),
              panel.grid.major.x = element_blank(),
              panel.grid.minor.x = element_blank(),
              panel.grid.major.y = ggplot2::element_line(color = "#cbcbcb"),
              panel.grid.minor.y = element_blank(),
              axis.title.y = element_text(size = 8, vjust = 3, angle = 0),
              axis.text.y = element_text(size = 11),
              axis.text.x = element_text(angle = 90, vjust = 0.5),
              axis.line.x = element_line(),
              plot.title = element_text(hjust = 0.5, face = "bold"),
              plot.subtitle = element_text(colour = "grey30", hjust = 0.5),
              plot.caption = element_text(colour = "grey50"),
              #text = element_text(family = "Arial Narrow"),
              legend.title = element_blank(),
              legend.position = c(0.08, 0.1))






