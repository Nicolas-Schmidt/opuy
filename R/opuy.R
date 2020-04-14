#'opuy
#'
#' Contiene dos indicadores relevantes de opinion publica relativo a las
#' eleccione en Uruguay para el periodo 1989 - 2020: intencion de voto y evaluacion
#' de la gestion del presidente. Los datos son agregados y provienen de la divulgacion
#' de las empresas consultoras que realizan las encuestas.
#'
#'\describe{
#'    \item{medicion}{Indicador disponible. Hasta el momento solo hay dos: Intencion de voto y Evaluacion de la gestion del Presidente.}
#'    \item{empresa}{Nombre de la empresa consultora que hizo la medicion.}
#'    \item{tipo_eleccion}{Tipo de eleccion: Nacional, Balotaje o Internas. Esta variables es util para el indicador 'Intencion de voto'.}
#'    \item{anio_medicion}{Anio en el que se publico la medicion.}
#'    \item{anio_gobierno}{Anio de gobierno. Esta variables es un numero entro que va desde el 1 hasta el 5 indicado respectivamente el anio de gobierno. Es particularmente util para el indicador 'Evaluacion de la gestion del Presidente'. Con esta variable es mas simple realizar comparaciones entre Presidentes.}
#'    \item{eleccion}{Esta variable refiere al anio de la eleccion a la que está asociada la medicion. Por ejemplo, se puede tener una medicion de Intencion de Voto del anio 2017, y esta corresponde a la eleccion del 2019.}
#'    \item{fecha}{Fecha exacta de la publicacion de la medidion.}
#'    \item{partido}{Nombre del partido politico para la medicion de Intencion de voto.}
#'    \item{sigla}{Sigla del partido politico.}
#'    \item{candidato}{Nombre del candidato para el caso de la Intencion de voto en elecciones internas.}
#'    \item{presidente}{Nombre del Presidente para la medicion Evaluacion de la gestion del presidente.}
#'    \item{categoria}{Categoria original de la medicion para el caso de Evaluacion de la gestion del presidente. Esta variable se mide comunmente en escala de Likert.}
#'    \item{categoria_unificada}{Se armoniza la variable 'categoria' para poder comparar entre empresas consultoras.}
#'    \item{valor}{Valor del indicador en porcentaje.}
#'
#' }
#' @docType data
#' @keywords datasets
#' @name opuy
#' @usage data(opuy)
#' @format data.frame con 4788 filas y 14 columnas
'opuy'
