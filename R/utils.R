#' @importFrom dplyr filter select group_by mutate arrange ungroup distinct summarise n
#' @importFrom tidyr pivot_wider
#' @importFrom magrittr %>%
#' @importFrom utils


base <- function(){
    opuy %>%
    select(anio_medicion, empresa, medicion, fecha) %>%
    distinct() %>%
    group_by(anio_medicion, empresa, medicion) %>%
    summarise(mediciones = n()) %>%
    ungroup()
}


allop <- function() unique(opuy$anio_medicion)

allc <- c("Equipos",
          "Cifra",
          "Factum",
          "Interconsult",
          "Radar",
          "Opcion")

polling <- c(
            E = "   Equipos    ",
            C = "    Cifra     ",
            F = "   Factum     ",
            I = " Interconsult ",
            R = "    Radar     ",
            O = "   Opcion     "
            )


nombres <- function(z){
    u <- which(names(polling) %in% substring(names(z), 1, 1))
    names(z) <- polling[u]
    z
}



vars <- c('anio_medicion', 'empresa', 'indicador', 'medicion', 'opuy',
          'fecha', 'mediciones','Intencion de voto', 'Evaluacion de gestion',
          'iv', 'eg', 'Anios', 'Mediciones', 'Evaluacion de gestion presidente',
          'Empresa', 'Indicador')


if(getRversion() >= "2.15.1"){
    utils::globalVariables(c('.', vars))
    utils::suppressForeignCheck(c('.', vars))
}









