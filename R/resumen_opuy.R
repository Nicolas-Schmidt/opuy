
#' @title resumen opuy
#' @description Resumen de los indicadores que contiene la base de datos por consultora.
#'     Permite consultar todos los indicadores disponibles por consultora por anio.
#' @param year anio de medicion
#' @param polling.org empresa consultora: "Equipos", "Cifra", "Factum", "Interconsult", "Radar" y "Opcion".
#' @return data.frame que contiene los indicadores que cada consultora realizó por anio.
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
        iv = ifelse(is.na(`Intencion de voto`), "       |",paste0("IV (", `Intencion de voto`, ")|")),
        eg = ifelse(is.na(`Evaluacion de gestion presidente`), "       ",paste0("EG (", `Evaluacion de gestion presidente`, ")")),
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
#' @description Ofrece un resumen por consultora e Indicador.
#' @param object objeto de la clase \code{opuy} de la funcion \code{\link{resumen_opuy}}
#' @param ... parametros adicionales
#' @return data.frame
#' @rdname resumen_opuy
#' @export

summary.opuy <- function(object, ...){


    a1 <- rownames(object)
    a2 <- names(object)
    b  <- base()
    b  <- b[which(b$anio_medicion %in% a1), ]
    b  <- b[which(b$empresa %in% a2), ]

    b <- b %>%
    group_by(empresa, medicion) %>%
    summarise(
        Mediciones = sum(mediciones),
        Periodo    = paste0(min(anio_medicion), "-",max(anio_medicion)),
        Anios      = ifelse((max(anio_medicion) - min(anio_medicion))==0, 1, (max(anio_medicion) - min(anio_medicion))),
        Ratio      = round(Mediciones / Anios)
    ) %>%
    arrange(medicion, -Mediciones) %>%
    ungroup()
    names(b)[1:2] <- c("Empresa", "Indicador")
    b
}


#' @title print.opuy
#' @description Metodo print de de la funcion \code{\link{resumen_opuy}}
#' @param x objeto de la clase \code{opuy} de la funcion \code{\link{resumen_opuy}}
#' @param ... parametros adicionales
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


