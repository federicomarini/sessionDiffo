#' Shiny up sessionDiffo
#'
#' A mini Shiny app for comparing `sessionInfo` outputs
#'
#' @return A Shiny app
#' @export
#'
#' @examples
#' if(interactive())
#'   ssd()
#' # and later upload the files/copy-paste the output in the editors directly
ssd <- function() {

  ssd_ui <- fluidPage(
    fluidRow(
      shiny::checkboxInput("display_equal", "Display also packages with the same version", value = TRUE),
      column(
        width = 6,
        shiny::fileInput(inputId = "file1",
                  label = "Paste here the content of your sessionInfo - A"),
        aceEditor("s1editor","")
      ),
      column(
        width = 6,
        shiny::fileInput(inputId = "file2",
                  label = "Paste here the content of your sessionInfo - B"),
        aceEditor("s2editor","")
      )
    ),
    fluidRow(
      shiny::actionButton("compare_sis", "Compare Session Infos"),
      DT::dataTableOutput("si_compared")
    )
  )

  ssd_server <- function(input, output, session) {
    rvs <- reactiveValues()

    si1 <- reactive({
      parse_si(file(input$file1$datapath))
    })
    si2 <- reactive({
      parse_si(file(input$file2$datapath))
    })

    observeEvent(input$file1, {
      shinyAce::updateAceEditor(
        session, "s1editor", value = paste0(readLines(file(input$file1$datapath)), collapse = "\n")
      )
    })
    observeEvent(input$file2, {
      shinyAce::updateAceEditor(
        session, "s2editor", value = paste0(readLines(file(input$file2$datapath)), collapse = "\n")
      )
    })


    observeEvent(input$compare_sis, {
      # req(input$file1)
      # req(input$file2)
      # # message(si1()$packages)
      # sid <- compare_si(si1(), si2())
      # message(input$file1$datapath)
      # # message(dim(si1()$packages))
      # rvs$sid <- sid

      s1e <- parse_si(input$s1editor, source ="editor")
      s2e <- parse_si(input$s2editor, source ="editor")
      message(dim(s1e$packages))
      sid <- compare_si(s1e, s2e)
      rvs$sid <- sid


    })

    output$si_compared <- DT::renderDataTable({
      validate(
        need(!is.null(rvs$sid), "Provide the two sessionInfo objects first")
      )
      sid <- rvs$sid

      if(!input$display_equal)
        sid <- sid[sid$comparison != "equal", ]

      DT::datatable(sid) %>%
        DT::formatStyle(
          'comparison',
          backgroundColor = DT::styleEqual(c("equal", "older", "newer", "Only in 1", "Only in 2"),
                                           c("white", "#E41A1C", "#377EB8", "lightgrey", "lightgrey")))
    })

  }
  shinyApp(ui = ssd_ui, server = ssd_server)

}
