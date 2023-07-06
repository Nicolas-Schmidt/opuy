
#' @title opuy summary
#' @description A summary of the number of measurements by indicators and year that the dataset contains.
#' @param year measurement year
#' @param polling.org polling organization: "Equipos", "Cifra", "Factum", "Interconsult", "Radar" and "Opcion".
#' @return data.frame that contains the measurements each polling organization made per year.
#' @examples
#' resumen_opuy()
#' resumen_opuy(1995)
#' resumen_opuy(year = 1992:1998, polling.org = c("Equipos", "Cifra"))
#'
#' foo <- resumen_opuy(year = 1992:1998, polling.org = c("Equipos", "Cifra"))
#' print(foo)
#' summary(foo)
#' @export

resumen_opuy <- function(year = allop(), polling.org = allc){

    op <-
    base() %>%
    pivot_wider(., names_from = medicion, values_from = mediciones) %>%
    mutate(
        `Intencion de voto` = ifelse(nchar(`Intencion de voto`) == 1, paste0(0, `Intencion de voto`), `Intencion de voto`),
        `Evaluacion de gestion presidente` = ifelse(nchar(`Evaluacion de gestion presidente`) == 1, paste0(0, `Evaluacion de gestion presidente`), `Evaluacion de gestion presidente`),
        iv = ifelse(is.na(`Intencion de voto`), "   -   |",paste0("IV (", `Intencion de voto`, ")|")),
        eg = ifelse(is.na(`Evaluacion de gestion presidente`), "   -   ",paste0("EG (", `Evaluacion de gestion presidente`, ")")),
        indicador = paste0(iv, eg)
    ) %>%
    select(anio_medicion, empresa, indicador) %>%
    pivot_wider(., names_from = empresa, values_from = indicador) %>%
    arrange(anio_medicion) %>%
    as.data.frame()

    rownames(op) <- op$anio_medicion
    op <- op[, -1]
    op[is.na(op)] <- "   -   |   -   "
    op <- rbind(paste(rep("-", 15), collapse = ""), op)
    rownames(op)[1] <- "-----"

    op <- op[c(1, which(rownames(op) %in% year)), names(op) %in% polling.org, drop = FALSE]
    class(op) <- c("opuy", class(op))
    op

}

#' @title summary.opuy
#' @description Returns a summary by polling organization and indicator.
#' @param object object of class \code{opuy} from \code{\link{resumen_opuy}} function
#' @param ... additional arguments
#' @return data.frame
#' @rdname resumen_opuy
#' @export

summary.opuy <- function(object, ...){


    a1 <- rownames(object)
    a2 <- names(object)
    b  <- base()
    b  <- b[which(b$anio_medicion %in% a1), ]
    b  <- b[which(b$empresa %in% a2), ]
    #b$tipo_eleccion <- ifelse(is.na(b$tipo_eleccion), "--", paste0("   ", b$tipo_eleccion))

    b <- b %>%
    group_by(empresa, medicion) %>%#, tipo_eleccion
    summarise(
        Mediciones = sum(mediciones),
        Periodo    = paste0(min(anio_medicion), "-",max(anio_medicion)),
        Anios      = ifelse((max(anio_medicion) - min(anio_medicion)) == 0, 1, (max(anio_medicion) - min(anio_medicion))),
        Ratio      = round(Mediciones / Anios)
    ) %>%
    arrange(medicion, -Mediciones) %>%
    ungroup()
    names(b)[1:2] <- c("Empresa", "Indicador")
    b
}


#' @title print.opuy
#' @description Print method of \code{\link{resumen_opuy}} function
#' @param x object of class \code{opuy} from \code{\link{resumen_opuy}} function
#' @param ... additional arguments
#' @rdname resumen_opuy
#' @export


print.opuy <- function(x,...){

    cat("\n\n---- Resumen de Indicadores por anio y consultora ---------------------------\n\n\n")
    x <- nombres(x)
    print.data.frame(x)
    cat("\n\nIV: Intencion de Voto\nEG: Evaluacion de gestion\n\n")
    cat("Entre parentesis se indica la cantidad de mediciones.\n\n")
    cat("-----------------------------------------------------------------------------\n")



}


