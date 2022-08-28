#' @importFrom dplyr filter select group_by rename mutate arrange ungroup distinct
#' @importFrom tidyr pivot_wider
#' @importFrom stats na.omit
#' @importFrom magrittr %>%

vars <- c('anio_medicion', 'empresa', 'indicador', 'medicion', 'opuy')
if(getRversion() >= "2.15.1"){
    utils::globalVariables(c('.', vars))
    utils::suppressForeignCheck(c('.', vars))
}
