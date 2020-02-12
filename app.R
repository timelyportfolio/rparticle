library(shiny)
library(rparticle)

ui <- fluidPage(
  titlePanel("reactR HTMLWidget Example"),
  rparticleOutput('widgetOutput')
)

server <- function(input, output, session) {
  output$widgetOutput <- renderRparticle(
    rparticle("Hello world!")
  )
}

shinyApp(ui, server)