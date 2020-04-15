
#' @title resumen opuy
#' @description Resumen de los indicadores que contiene la base de datos por consultora.
#' @return data.frame que contiene los indicadores que cada consultora realizó por anio.
#' @examples
#' resumen_opuy()
#' @export


resumen_opuy <- function(){

    op <- opuy %>%
        select(anio_medicion, empresa, medicion) %>%
        distinct() %>%
        group_by(anio_medicion, empresa) %>%
        mutate(
            medicion  = ifelse(medicion == 'Intencion de voto', '  IV| -', '  - |EG'),
            indicador = ifelse(length(medicion) == 2, "  IV|EG", medicion)) %>%
        ungroup() %>%
        select(-medicion) %>%
        distinct() %>%
        pivot_wider(., names_from = empresa, values_from = indicador) %>%
        arrange(anio_medicion) %>%
        as.data.frame()

    #op$anio_medicion[32] <- ".NA."  ## arreglar index
    rownames(op) <- op$anio_medicion
    op <- op[, -1]
    op[is.na(op)] <- "  - | -"
    op <- rbind(paste(rep("-", 11), collapse = ""), op) #max(nchar(names(op))))
    rownames(op)[1] <- "----"

    cat("\n\n---- Resumen de Indicadores por anio y consultora ---------------------------\n\n\n")
    print(op)
    cat("\nIV: Intencion de Voto\nEG: Evaluacion de gestion\n\n")
    cat("-----------------------------------------------------------------------------\n")
}


