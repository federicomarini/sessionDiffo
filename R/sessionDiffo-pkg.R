#' `sessionDiffo`
#'
#' A tiny utility to compare (`diff`) the output of two different Session Info
#' (via `sessionInfo()`, `sessioninfo::session_info()`) calls
#'
#' @importFrom car recode
#' @importFrom utils compareVersion
#' @importFrom DT datatable dataTableOutput renderDataTable formatStyle
#' styleEqual
#' @importFrom shiny actionButton checkboxInput column fileInput fluidPage
#' fluidRow need observeEvent reactive reactiveValues req shinyApp validate
#' @importFrom shinyAce aceEditor updateAceEditor
#' @importFrom magrittr "%>%"
#'
#' @name sessionDiffo-pkg
#' @docType package
NULL
