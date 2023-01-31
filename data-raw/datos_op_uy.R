
## -----------------------------------------------------------------------------
## op_uy
## -----------------------------------------------------------------------------

#opuy <- readxl::read_excel("data-raw/opuy.xlsx")

opuy <- readxl::read_excel("data-raw/opuy.xlsx",
                           col_types = c("text", "text", "text", "numeric",
                                         "numeric", "numeric", "numeric",
                                         "text", "text", "text", "text",
                                         "text", "numeric", "numeric"))

str(opuy)
opuy$fecha <- janitor::excel_numeric_to_date(opuy$fecha)
opuy <- dplyr::arrange(opuy, medicion, empresa, fecha)

rio::export(opuy, 'opuy.rda')
load('opuy.rda')
opuy <- tibble::as_tibble(opuy)
save(opuy, file = here::here("data", "opuy.rda"))
file.remove('opuy.rda')

