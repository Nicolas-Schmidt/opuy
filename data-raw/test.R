
pkg <- c("opuy", "Boreluy", "hrbrthemes", "tidyverse")
tec <- sapply(pkg, library, character.only = TRUE)

e19 <- nacional_uy(2019) %>% agrupar_partidos_uy()

e192 <- tibble(
    fecha = as.Date("2019-11-30"),
    partido = e19$Partido,
    resultado = e19$Porcentaje
) %>% filter(partido %in% c("Frente Amplio", "Partido Nacional", "Partido Colorado"))

op <- opuy %>%
    filter(medicion == "Intencion de voto",
           tipo_eleccion == "Nacional",
           empresa %in% c("Equipos", "Cifra", "Factum", "Opcion"),
           eleccion == 2019,
           partido %in% c("Frente Amplio", "Partido Nacional", "Partido Colorado"))

op$empresa[which(op$empresa == "Opcion")] <- "Opci\u00f3n"

op$epa <- paste(op$empresa, op$partido)
distancia <- do.call("rbind", lapply(split(op, op$epa), function(x){return(x[nrow(x),])})) %>%
    select(empresa, partido, valor) %>%
    full_join(., e192 %>% select(-fecha)) %>%
    mutate(dist = valor - resultado,
           fecha = as.Date("2019-11-30"))

margen <- op[which(op$fecha == max(op$fecha)),] %>%
    select(partido, valor) %>%
    filter(partido %in% c("Frente Amplio", "Partido Nacional", "Partido Colorado")) %>%
    left_join(., e192, "partido")

gop <-
ggplot(op, aes(x = fecha, y = valor)) +
    facet_grid(rows = vars(empresa),
               cols = vars(partido)) +
    geom_segment(aes(x = fecha,
                     y = 5,
                     xend = fecha,
                     yend = resultado),
                 data = e192,
                 size = 0.8,
                 color = "red") +
    geom_rect(data = distancia,
              aes(xmin = as.Date("2015-08-01"),
                  xmax = as.Date("2019-11-30"),
                  ymin = valor,
                  ymax = resultado),
              fill = "red",
              alpha = 0.1) +
    geom_line()+
    geom_point(size = 0.4) +
    geom_point(data = margen,
               aes(x = fecha, y = resultado),
               color = "red",
               shape = 16,
               size = 1.2) +
    geom_text(x = as.Date("2015-10-01"),
              y = 46,
              aes(label = round(dist, 2)),
              data = distancia,
              size = 3.3,
              color = "red") +
    labs(x = "",
         y = "",
         title = "",
         subtitle = "",
         group = "",
         caption = "Fuente: Schmidt, N., Vairo, D., Opertti, M., UMAD (2022)\n opuy: Datos de Opinión Pública de Uruguay 1989 a la actualidad,\n R package version 0.1.1001, https://nicolas-schmidt.github.io/opuy/.") +
    ylim(0, 50) +
    theme_ipsum() +
    theme(panel.grid = element_blank(),
         panel.grid.major.x = element_blank(),
         panel.grid.minor.x = element_blank(),
         panel.grid.major.y = ggplot2::element_line(color = "#cbcbcb"),
         panel.grid.minor.y = element_blank(),
         axis.title.y = element_text(size = 8, vjust = 3, angle = 0),
         axis.text.y = element_text(size = 11),
         axis.text.x = element_text(angle = 0, vjust = 0.5),
         axis.line.x = element_line(),
         plot.title = element_text(hjust = 0.5, face = "bold"),
         plot.subtitle = element_text(colour = "grey30", hjust = 0.5),
         plot.caption = element_text(colour = "grey50"),
         text = element_text(family = "Arial Narrow"),
         legend.title = element_blank(),
         legend.position = c(0.08, 0.1)
         )


print(gop)



