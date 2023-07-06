#'opuy
#'
#' The datset that contains two public opinion indicators: vote intention and
#' presidential approval. Data available ranges from 1989 to the present. Data
#'  was collected from polling organizations records and news articles by
#'  Unidad de Métodos y Acceso a Datos. All data is at the aggregate level,
#'  as no individual-level data is available.
#'
#' Data were collected by UMAD from polling organization records and news
#' articles. The structure, order, harmonization and creation of new variables
#' was done by the package authors.
#'
#'\describe{
#'    \item{medicion}{Indicator name. For now there are two available: \emph{Intención de voto} (vote intention) and \emph{Evaluación de la gestión del Presidente} (presidential approval).}
#'    \item{empresa}{Polling organization}
#'    \item{tipo_eleccion}{Election type: \emph{Nacional}, \emph{Balotaje} o \emph{Internas}. Election associated with vote intention data.}
#'    \item{anio_medicion}{Measurement year}
#'    \item{anio_gobierno}{Administration year. This variable is an integer that goes from 1 to 5, indicating the year of the administration (1 = administration's first year, 2 = administration's second year...). Is useful for the 'Evaluación de la gestión del Presidente' indicator to make valid comparissons between presidents at the same period of the administration.}
#'    \item{eleccion}{Election associated with the vote intention measure. For example, there could be vote intention data available for the year 2017 which is associated with the 2019 election.}
#'    \item{fecha}{Last day of survey field dates. In some cases, where this data is not available, it could be date of publication instead}
#'    \item{partido}{Political party name.}
#'    \item{sigla}{Political party abbreviation}
#'    \item{candidato}{Name of the candidate for primary and 'balotaje' elections.}
#'    \item{presidente}{President's name for presidential approval data.}
#'    \item{categoria}{Original response category for presidential approval data. This variable is usually a Likert scale.
#'    \item{categoria_unificada}{Harmonized value for the response category of presidential approval to make comparissons between polling organizations. Respondents that did not answer or were not sure were given the value 0, those who disapprove the president's job are given the value of 1, neutral evaluations are given the value of 2 and those who approve the president's job are given the value of 3.}
#'    \item{valor}{Measurement value in procentage.}
#' }
#' @docType data
#' @keywords datasets
#' @name opuy
#' @usage data(opuy)
#' @format data.frame with 5113 rows and 14 columns
'opuy'
