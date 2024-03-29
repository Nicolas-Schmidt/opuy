% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/resumen_opuy.R
\name{resumen_opuy}
\alias{resumen_opuy}
\alias{summary.opuy}
\alias{print.opuy}
\title{resumen opuy}
\usage{
resumen_opuy(year = allop(), polling.org = allc)

\method{summary}{opuy}(object, ...)

\method{print}{opuy}(x, ...)
}
\arguments{
\item{year}{anio de medicion}

\item{polling.org}{empresa consultora: "Equipos", "Cifra", "Factum", "Interconsult", "Radar" y "Opcion".}

\item{object}{objeto de la clase \code{opuy} de la funcion \code{\link{resumen_opuy}}}

\item{...}{parametros adicionales}

\item{x}{objeto de la clase \code{opuy} de la funcion \code{\link{resumen_opuy}}}
}
\value{
data.frame que contiene los indicadores que cada consultora realizó por anio.

data.frame
}
\description{
Resumen de los indicadores que contiene la base de datos por consultora.
    Permite consultar todos los indicadores disponibles por consultora por anio.

Ofrece un resumen por consultora e Indicador.

Metodo print de de la funcion \code{\link{resumen_opuy}}
}
\examples{
resumen_opuy()
resumen_opuy(1995)
resumen_opuy(year = 1992:1998, polling.org = c("Equipos", "Cifra"))

foo <- resumen_opuy(year = 1992:1998, polling.org = c("Equipos", "Cifra"))
print(foo)
summary(foo)
}
